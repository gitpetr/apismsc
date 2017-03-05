class CodeService
  attr_accessor :object

  def create(params)
    return nil unless params_valid?(params)

    url = ::UrlService.format(params[:url])
    if Code.where(url: url).any?
      return Code.where(url: url).first
    end

    start_uid = params_to_uid(params)
    url_uid = start_to_url_uid(start_uid)
    Code.create!(uid: url_uid, url: url)
  end

  def search_by_params(params)
    start_uid = params_to_uid(params)
    result = {initial_uid: start_uid}
    @query = Code.uid_like(start_uid).order('id DESC')
    prepare_result
  end

  def search_by_url(url)
    url = ::UrlService.format(url)
    @query = Code.where(url: url)
    prepare_result
  end

  private

  def start_to_url_uid(start_uid)
    codes = Code.uid_like(start_uid).order('id DESC')
    number = if codes.any?
               '%04d' % (::UidService.parse(codes.first.uid).number.to_i + 1)
             else
               "0101"
             end
    "#{start_uid}#{number}"
  end

  def params_to_uid(params)
    params = {color: 100, icon_first: 100, icon_second: 100}.merge(params.to_hash.symbolize_keys)
    parts = []
    parts << params[:color]
    parts << params[:icon_first]
    parts << params[:icon_second]
    parts << params[:number] if params[:number].present?
    parts.map! { |n| '%04d' % n }.join
  end

  def params_valid?(params)
    raise Exception.new('Params has to all needed keys') unless params.key?(:color) and params.key?(:icon_first) and params.key?(:icon_second) and params.key?(:url)
    raise Exception.new('Color not found') unless Color.where(uid: params[:color]).any?
    raise Exception.new('Icon not found') unless Icon.where(uid: params[:icon_first]).any?
    raise Exception.new('Icon not found') unless Icon.where(uid: params[:icon_second]).any?
    raise Exception.new('Url is not valid') unless params[:url] =~ /^((ftp|https?):\/\/)?([a-zA-Z0-9]+(\.[a-zA-Z0-9]+)+.*)$/i
    true
  end

  def prepare_result
    result = { count: @query.count }
    if result[:count] == 1
      result.merge!(@query.first.do_hash)
    else
      result[:items] = @query.first(5).map(&:do_hash)
    end
    result
  end
end