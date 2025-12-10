module Freezer
  class DashboardController < BaseController
    def index
      @freezers = ::FreezerLocation.ordered
      @total_items = ::FreezerItem.count
      @expiring_soon = ::FreezerItem.where("expiration_date <= ? AND expiration_date >= ?", 7.days.from_now, Date.current).count
    end
  end
end

