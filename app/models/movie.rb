class Movie < ActiveRecord::Base
    
    def self.get_all_ratings
        #Rails.logger.debug " modelo - get_all_ratings"
        #Rails.logger.debug " modelo - self.uniq.pluck(:rating) #{self.uniq.pluck(:rating)}"
        
        return self.uniq.pluck(:rating)
    end
    
    def self.get_selected_ratings(rating_allowed)
        #Rails.logger.debug " modelo - get_selectec_ratings"
        #Rails.logger.debug " modelo - rating_allowed #{rating_allowed}"
        return rating_allowed.keys if rating_allowed.respond_to?('keys')
        return rating_allowed
    end    
    
    def self.filtering(rating_allowed)
        #Rails.logger.debug " modelo - filtering [#{rating_allowed}]"
        return rating_allowed

    end 
    
    def self.sorting(field, ratings1)
        #Rails.logger.debug " modelo - sorting [#{field}]"
        #Rails.logger.debug " modelo - ratings1 [#{ratings1}]"
        #Rails.logger.debug " modelo - self.where(rating: ratings1) [#{self.where(rating: ratings1)}]"

        return self.where(rating: ratings1).order(field)
    end
    

end
