class Bug < ApplicationRecord
    validates :title, uniqueness: true
    validates :title, presence: true
    validates :status, presence: true
    validates :bug_type, presence: true
    belongs_to :user
    belongs_to :project
    enum status: { New: 0, Started: 1, Completed: 2}
    mount_uploader :screenshot, FileUploader
    validate :upload_is_image

    private
    def upload_is_image
        unless screenshot and screenshot.content_type =~ /^image\/(gif|png)$/
            errors.add(:upload, "Not a valid image")
        end
    end
end
