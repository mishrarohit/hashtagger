# == Schema Information
#
# Table name: hashtags
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Hashtag < ActiveRecord::Base
end
