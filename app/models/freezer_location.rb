class FreezerLocation < ApplicationRecord
  self.table_name = "freezers"

  has_many :freezer_items, dependent: :destroy, foreign_key: :freezer_id

  validates :name, presence: true, uniqueness: true

  scope :ordered, -> { order(:name) }
end
