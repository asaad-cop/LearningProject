class Bug < ApplicationRecord
    validates :title, uniqueness: true
    validates :title, presence: true
    validates :status, presence: true
    validates :bug_type, presence: true
    belongs_to :user
    belongs_to :project
    enum status: { New: 0, Started: 1, Completed: 2}
end
