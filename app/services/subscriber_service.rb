class SubscriberService
  attr_accessor :object

  def create(params)
    return nil unless params_valid?(params)
    raise Exception.new('Subscriber is empty') if params[:subscriber].blank?
    subscriber_fields_valid?(params[:subscriber])

    list = SubscribersList.find_or_create_by(uid: params[:uid], name: params[:name])
    subscriber = SubscribeMember.create(subscribers_list: list, data: params[:subscriber])
    { list_name: list.name, subscriber: subscriber.data }
  end

  def search_by_params(params)
    return nil unless params_valid?(params)

    list = SubscribersList.where(uid: params[:uid], name: params[:name]).first
    return nil unless list.present?

    {uid: list.uid, name: list.name, subscribers_count: list.subscribe_members.count, subscribers: list.subscribe_members.map(&:data_with_system_info)}
  end

  private

  def subscriber_fields_valid?(subscriber)
    raise Exception.new('Subscriber data are empty') if subscriber.all? { |value| value[1].blank? }
    if subscriber[:email].present?
      raise Exception.new('Subscriber email are wrong') unless subscriber[:email] =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    end
    true
  end

  def params_valid?(params)
    raise Exception.new('Uid is empty') unless params[:uid].present?
    raise Exception.new('Name is empty') unless params[:name].present?
    true
  end
end