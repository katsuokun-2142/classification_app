module UrlChecker
  def self.check_url(url)
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    
    if response.code == "200"
      true
    else
      false
    end
  rescue => e
    false
  end
end