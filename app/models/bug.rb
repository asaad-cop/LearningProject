class Bug < ApplicationRecord
    belongs_to :project
    validates :title, uniqueness: { scope: :project_id}
    validates :title, presence: true
    validates :status, presence: true
    validates :bug_type, presence: true
    belongs_to :user
    enum status: { New: 0, Started: 1, Completed: 2, Resolved: 3}
    mount_uploader :screenshot, FileUploader
    validate :upload_is_image

    private
    def upload_is_image
        unless screenshot or screenshot.content_type =~ /^image\/(gif|png)$/
            errors.add(:upload, "a valid image. (Only png or gif allowed)")
        end
    end
end
