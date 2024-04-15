require 'open-uri'
require 'nokogiri'

class ScrapingHtml
  def self.get_title(url)
    html = URI.open(url).read
    doc = Nokogiri::HTML.parse(html)
    title = doc.title
  end
end