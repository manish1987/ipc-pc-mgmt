class Feedback < ActiveRecord::Base
  attr_accessible :feedback, :session_id
  belongs_to :session
end
