module ApplicationHelper
  def nl2br(str)
    return str unless str.is_a?(String)

    str.gsub("\n", "<br>").html_safe
  end
end
