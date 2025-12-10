class PhoneNumbersController < ApplicationController
  def index
    @phone_numbers = PhoneNumber.order(active: :desc, name: :asc)
  end

  def new
    @phone_number = PhoneNumber.new
  end

  def create
    @phone_number = PhoneNumber.new(phone_number_params)

    if @phone_number.save
      redirect_to phone_numbers_path, notice: "Phone number added successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @phone_number = PhoneNumber.find(params[:id])
    @phone_number.destroy
    redirect_to phone_numbers_path, notice: "Phone number removed."
  end

  private

  def phone_number_params
    params.require(:phone_number).permit(:name, :number, :active)
  end
end

