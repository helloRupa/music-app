module ApplicationHelper
  def auth_form
    "<input type='hidden' name='authenticity_token' value='#{form_authenticity_token}'>".html_safe
  end

  def ugly_lyrics(lyrics)
    lines = lyrics.split("\r\n")
    lines.map! { |line| "<pre>♫ #{h(line)}</pre>" }
    lines.join.html_safe
  end
end
