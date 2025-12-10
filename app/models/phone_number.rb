class PhoneNumber < ApplicationRecord
  has_many :notifications, dependent: :destroy

  validates :name, presence: true
  validates :number, presence: true, uniqueness: true, format: { with: /\A\+?[1-9]\d{1,14}\z/, message: "must be a valid phone number" }

  scope :active, -> { where(active: true) }

  def formatted_number
    return number unless number.start_with?("+1") && number.length == 12

    "(#{number[2..4]}) #{number[5..7]}-#{number[8..11]}"
  end
end
