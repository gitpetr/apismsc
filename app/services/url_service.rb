class UrlService
  def self.format(url)
    url.to_s.sub(/^(https?:|)\/\//i, '').sub(/^www\./i, '').strip
  end
end