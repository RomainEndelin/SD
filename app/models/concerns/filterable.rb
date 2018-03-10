module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter(filtering_params)
      results = self.where(nil)
      filtering_params.each do |key, value|
        unless key == "category" && value == "0"
          results = results.public_send("by_#{key}", value) if value.present?
        end
      end
      results
    end

    def by_order(order)
      results = self.where(nil)
      begin
        results = results.public_send("most_#{order}")
      ensure
        return results
      end
    end
  end

  def filter_suggestions(filter)
    begin
      self.public_send("similar_by_#{filter}")
    rescue NoMethodError
      self.public_send("similar")
    end
  end
end
