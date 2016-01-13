class Recipe < ActiveRecord::Base
    belongs_to :chef
    has_many :likes
    has_many :recipe_styles 
    has_many :recipe_ingredients
    has_many :styles, through: :recipe_styles
    has_many :ingredients, through: :recipe_ingredients
    validates :name, :summary, :description, presence: true
    validates :chef_id, presence: true
    validates :name, length: {minimum: 5, maximum: 100 }
    validates :summary, length: {minimum: 10, maximum: 200 }
    validates :description, length: {minimum: 20, maximum: 500 }
    mount_uploader :picture, PictureUploader 
    validate :picture_size
    default_scope -> { order(updated_at: :desc) }
    
    def thumbs_up_total
        self.likes.where(like: true).size
    end
    
    
    def thumbs_down_total  
        self.likes.where(like: false).size
    end
    private
        def picture_size
            if picture.size > 5.megabytes
                errors.add(:picture, "should be less than 5MB")
        end
    end
end
