class Recipe < ActiveRecord::Base
    belongs_to :chef
    validates :name, :summary, :description, presence: true
    validates :name, length: {minimum: 5, maximum: 100 }
    validates :summary, length: {minimum: 10, maximum: 200 }
    validates :description, length: {minimum: 20, maximum: 500 }
    
end
