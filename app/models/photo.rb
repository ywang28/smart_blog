class Photo < ActiveRecord::Base
  belongs_to :user
  has_many   :comment
  has_many   :tag
  default_scope -> { order('date_time DESC') }
end
