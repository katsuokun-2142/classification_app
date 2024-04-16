module UrlChecker
  MAX_REDIRECTS = 3 # リダイレクトの最大回数を設定

  def self.valid_url?(url)
    uri = URI.parse(url)
    uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
  rescue URI::InvalidURIError
    false
  end

  def self.check_url(url, limit = MAX_REDIRECTS)
    return false unless valid_url?(url) # URLの検証
    raise ArgumentError, 'too many HTTP redirects' if limit == 0

    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == 'https')
    http.open_timeout = 5 # オープンタイムアウトを5秒に設定
    http.read_timeout = 5 # 読み取りタイムアウトを5秒に設定

    response = http.start { http.request(Net::HTTP::Get.new(uri)) }

    case response
    when Net::HTTPSuccess then
      true
    when Net::HTTPRedirection then
      new_location = response['location']
      Rails.logger "redirected to #{new_location}"
      check_url(new_location, limit - 1) # 再帰的にリダイレクトを追跡
    else
      false
    end
  rescue => e
    Rails.logger "Error checking URL: #{e.message}"
    false
  end
end