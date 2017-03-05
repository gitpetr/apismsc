require 'rest-client'
require 'base64'

class SendPulseEmail
  def initialize(options = {})
    @options = options
    @client_id = options[:client_id] || Rails.application.secrets.sendpulse_id
    @client_secret = options[:client_secret] || Rails.application.secrets.sendpulse_secret
    @auth_token ||= get_token
  end

  def get_token
    response = RestClient.post 'https://api.sendpulse.com/oauth/access_token', {grant_type: 'client_credentials', client_id: @client_id, client_secret: @client_secret}, {content_type: :json, accept: :json}
    JSON.parse(response.body)['access_token']
  end

  def delivery
    response = RestClient.post 'https://api.sendpulse.com/smtp/emails', { email: email_params }, { Authorization: "Bearer #{@auth_token}"}
    { "result" => JSON.parse(response.body)['result'] }
  end

  def email_params
    default_params = {
                       "html" => "<h1>Текст по умолчанию</h1>",
                       "subject" => "Заголовок по умолчанию",
                       "from" => { "name" => "Bafsy", "email" => "support@bafsy.com" },
                       "to" => [
                         {"name" => "Евгений Зуев","email" => "zuev.evgenii@carbonfay.ru"},
                         {"name" => "Bafsy Support","email" => "phil@carbonfay.ru"},
                         {"name" => "Anton Baranov", "email" => "baranovneversleep@gmail.com"}
                       ],
                       "bcc" => [
                         {"name" => "Евгений Зуев","email" => "zuev.evgenii@carbonfay.ru"},
                         {"name" => "Bafsy Support","email" => "support@bafsy.com"},
                         {"name" => "Anton Baranov", "email" => "baranovneversleep@gmail.com"}
                       ]
                     }
    params = default_params.merge(@options[:email] || {})
    params["text"] = ActionView::Base.full_sanitizer.sanitize(params["html"])
    params["html"] = Base64.encode64(params["html"])
    params["bcc"].delete_if{ |bcc| params["to"].detect{|f| f["email"] == bcc["email"]}.present? }
    params.to_json
  end
end