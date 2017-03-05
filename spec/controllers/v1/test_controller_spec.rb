require 'rails_helper'

RSpec.describe V1::TestController, type: :controller do

  it 'should works in normal mode' do
    get :insecure
    expect(response).to have_http_status(200)
  end

  it 'should works in secured mode' do
    get :secured
    expect(response).to have_http_status(401)
  end

end
