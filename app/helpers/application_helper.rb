module ApplicationHelper
  def custom_flash_message
    if flash[:notice] && session[:name]
      "#{session[:name]}, #{flash[:notice]}"
    else
      flash[:notice]
    end
  end
end
