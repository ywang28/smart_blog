class Comment < ActiveRecord::Base
  belongs_to :photo
  belongs_to :user
  default_scope -> { order('date_time ASC') }

  validates :comment, presence: true, length: { maximum: 140 }
end
