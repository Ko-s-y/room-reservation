module ApplicationHelper

  def avatar_url(user)
    if user.avatar.attached?
      url_for(user.avatar)
    elsif user.image?
      user.image
    else
      ActionController::Base.helpers.asset_path('icon_default_avatar.jpg')
    end
  end

  def avatar_url(room)
    if room.avatar.attached?
        url_for(room.avatar)
    elsif room.image?
        room.image
    else
        ActionController::Base.helpers.asset_path('sample.jpg')
    end
  end

end
