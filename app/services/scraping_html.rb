require 'open-uri'
require 'nokogiri'
require 'nkf'

class ScrapingHtml
  def self.get_title(url)
    raise ArgumentError, 'Invalid URL' unless UrlChecker.valid_url?(url)

    html = URI.open(url, open_timeout: 5, read_timeout: 5).read
    # エンコーディングを判別
    enc = NKF.guess(html)
    if enc.name != 'UTF-8'
      # オリジナルのエンコーディングからUTF-8に変換
      html = html.encode('UTF-8', enc.name)
    end
    doc = Nokogiri::HTML.parse(html)
    # title = doc.title
    doc.title
  rescue OpenURI::HTTPError => e
    Rails.logger.error "HTTP Error accessing #{url}: #{e.message}"
  rescue StandardError => e
    Rails.logger.error "Error accessing #{url}: #{e.message}"
  end
end
