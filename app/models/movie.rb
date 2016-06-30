class Movie < ActiveRecord::Base
    def self.get_ratings
      self.uniq.pluck(:rating)
    end
end
