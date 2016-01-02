class Recipe < ActiveRecord::Base
    belongs_to :chef
    validates :name, :summary, :description, presence: true
    validates :name, length: {minimum: 5, maximum: 100 }
    validates :summary, length: {minimum: 10, maximum: 200 }
    validates :description, length: {minimum: 20, maximum: 500 }
    mount_uploader :picture, PictureUploader 
    validate :picture_size
    
    private
        def picture_size
            if picture.size > 5.megabytes
                errors.add(:picture, "should be less than 5MB")
        end
    end
end
