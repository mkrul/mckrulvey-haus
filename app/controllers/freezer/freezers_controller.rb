module Freezer
  class FreezersController < BaseController
    def index
      @freezers = ::FreezerLocation.ordered
    end

    def new
      @freezer = ::FreezerLocation.new
    end

    def create
      @freezer = ::FreezerLocation.new(freezer_params)

      if @freezer.save
        redirect_to freezer_freezers_path, notice: "Freezer added successfully."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @freezer = ::FreezerLocation.find(params[:id])
    end

    def update
      @freezer = ::FreezerLocation.find(params[:id])

      if @freezer.update(freezer_params)
        redirect_to freezer_freezers_path, notice: "Freezer updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @freezer = ::FreezerLocation.find(params[:id])
      @freezer.destroy
      redirect_to freezer_freezers_path, notice: "Freezer removed."
    end

    private

    def freezer_params
      params.require(:freezer_location).permit(:name)
    end
  end
end
