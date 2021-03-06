class Alert < ActiveRecord::Base
  attr_accessible :link, :cleared, :message, :user_id

  belongs_to :user

  scope :uncleared, where("cleared IS NOT TRUE")
  scope :for_user, lambda {|user| where(user_id:user.id)} 
  default_scope order('created_at DESC')

  def self.generate(user_id, message, link="")
    if user_id && message
      Alert.create(user_id:user_id,message:message,link:link)
    end
  end
end
