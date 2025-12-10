class FreezerItem < ApplicationRecord
  belongs_to :freezer_location, class_name: "FreezerLocation", foreign_key: :freezer_id

  alias_method :freezer, :freezer_location

  validates :name, presence: true
  validates :category, presence: true
  validates :freezer_id, presence: true
  validates :weight_lbs, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validates :weight_oz, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true

  scope :ordered, -> { order(:category, :name) }

  def self.distinct_categories
    distinct.pluck(:category).compact.sort
  end

  def self.distinct_names
    distinct.pluck(:name).compact.sort
  end

  def weight_display
    parts = []
    parts << "#{weight_lbs} lbs" if weight_lbs.present? && weight_lbs > 0
    parts << "#{weight_oz} oz" if weight_oz.present? && weight_oz > 0
    parts.empty? ? nil : parts.join(" ")
  end

  def expiring_soon?
    expiration_date.present? && expiration_date <= 7.days.from_now && expiration_date >= Date.current
  end
end
