module Freezer
  class ItemsController < BaseController
    def index
      @search = params[:search]
      @items = ::FreezerItem.includes(:freezer_location).ordered

      if @search.present?
        @items = @items.where("name ILIKE ? OR category ILIKE ?", "%#{@search}%", "%#{@search}%")
      end

      @items_by_freezer = @items.group_by(&:freezer)
    end

    def new
      @freezer_item = ::FreezerItem.new
      @freezers = ::FreezerLocation.ordered
      @categories = ::FreezerItem.distinct_categories
      @item_names = ::FreezerItem.distinct_names
    end

    def create
      @freezers = ::FreezerLocation.ordered
      @categories = ::FreezerItem.distinct_categories
      @item_names = ::FreezerItem.distinct_names

      quantity = params[:quantity].to_i
      quantity = 1 if quantity < 1

      if quantity == 1
        @freezer_item = ::FreezerItem.new(freezer_item_params)
        if @freezer_item.save
          redirect_to freezer_items_path, notice: "Item added successfully."
        else
          render :new, status: :unprocessable_entity
        end
      else
        items_created = 0
        quantity.times do
          item = ::FreezerItem.new(freezer_item_params)
          items_created += 1 if item.save
        end

        if items_created == quantity
          redirect_to freezer_items_path, notice: "#{items_created} items created successfully."
        else
          @freezer_item = ::FreezerItem.new(freezer_item_params)
          @freezer_item.errors.add(:base, "Failed to create all items. Only #{items_created} of #{quantity} were created.")
          render :new, status: :unprocessable_entity
        end
      end
    end

    def edit
      @freezer_item = ::FreezerItem.find(params[:id])
      @freezers = ::FreezerLocation.ordered
      @categories = ::FreezerItem.distinct_categories
      @item_names = ::FreezerItem.distinct_names
    end

    def update
      @freezer_item = ::FreezerItem.find(params[:id])
      @freezers = ::FreezerLocation.ordered
      @categories = ::FreezerItem.distinct_categories
      @item_names = ::FreezerItem.distinct_names

      if @freezer_item.update(freezer_item_params)
        redirect_to freezer_items_path, notice: "Item updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @freezer_item = ::FreezerItem.find(params[:id])
      @freezer_item.destroy
      redirect_to freezer_items_path, notice: "Item removed."
    end

    def duplicate
      source_item = ::FreezerItem.find(params[:id])
      @freezer_item = ::FreezerItem.new(
        freezer_id: source_item.freezer_id,
        name: source_item.name,
        category: source_item.category,
        weight_lbs: source_item.weight_lbs,
        weight_oz: source_item.weight_oz,
        packaged_date: source_item.packaged_date,
        expiration_date: source_item.expiration_date
      )
      @freezers = ::FreezerLocation.ordered
      @categories = ::FreezerItem.distinct_categories
      @item_names = ::FreezerItem.distinct_names
      @source_item = source_item
      render :new
    end

    private

    def freezer_item_params
      params.require(:freezer_item).permit(:freezer_id, :name, :category, :weight_lbs, :weight_oz, :packaged_date, :expiration_date)
    end
  end
end
