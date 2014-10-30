module ApplicationHelper
  def ugly_lyrics(lyrics)
    lines = lyrics.split("\n")
    lines.map do |line|
      
      "<p>"+"&#9835" + h(line) +"</p>"
    end.join("\n").html_safe
  end
end
