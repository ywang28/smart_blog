class Photo < ActiveRecord::Base
  belongs_to :user
  has_many   :comment
  default_scope -> { order('date_time DESC') }
end
