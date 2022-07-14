class Project < ApplicationRecord
    has_many :bugs, dependent: :destroy 
    has_many :users, through: :bugs
end
