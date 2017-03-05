class UidService
  attr_accessor :color, :icon_first, :icon_second, :number

  def self.parse(uid)
    service = UidService.new
    service.color, service.icon_first, service.icon_second, service.number = uid.scan(/.{4}/)
    service
  end
end