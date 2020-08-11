class Micropost < ApplicationRecord
  PARAMS = %i(content picture).freeze

  belongs_to :user
  scope :created_post_at, ->{order(created_at: :desc)}
  scope :new_feed, ->(following_ids){where user_id: following_ids}
  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.micropost.max_length}
  validate  :picture_size

  def picture_size
    errors.add(:picture, t("microposts.should_be_less_than")) if picture.size > Settings.micropost.image.size.megabytes
  end
end
