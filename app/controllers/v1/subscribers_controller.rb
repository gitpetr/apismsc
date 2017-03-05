class V1::SubscribersController < ApplicationController

  def create
    service = ::SubscriberService.new
    begin
      result = service.create(params)
      if result[:subscriber].present?
        tmp_subscriber_nofitication(result)
        return success_response
      end
    rescue Exception => e
      return error_response(e.message)
    end

    error_response('Something went wrong')
  end

  def search
    service = ::SubscriberService.new
    begin
      result = service.search_by_params(params)
      return success_response(result) unless result.nil?
    rescue Exception => e
      return error_response(e.message)
    end

    error_response('Something went wrong')
  end

  def destroy
    subscriber = SubscribeMember.find_by(id: params[:id])
    if subscriber
      subscriber.destroy
      success_response(subscriber.data_with_system_info)
    else
      error_response('Not found', :not_found)
    end
  end

  private

  def tmp_subscriber_nofitication(result)
    params = { 'subject' => "#{result[:list_name]} - Новая подписка" }
    if result[:subscriber]
      params['html'] = "<table><tbody><tr><th>Имя</th><th>Телефон</th><th>Email</th></tr><tr><td>#{result[:subscriber]['name']}</td><td>#{result[:subscriber]['phone']}</td><td>#{result[:subscriber]['email']}</td></tr></tbody></table>"
    end
    SendPulseEmail.new(email: params).delivery
  end

end
