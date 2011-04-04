module ApplicationHelper
  
  #Sets title
  def title
    default_title = "Interviewer"

    if @title.nil?
      default_title
    else
      "#{default_title} | #{@title}"
    end
  end

  #Given a user id, gives name
  def name_of(user_id)
    user = User.find(user_id)
    if user.nil?
      "a ghost"
    else
      user.name
    end
  end
  
end
