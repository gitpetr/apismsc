require 'rails_helper'

RSpec.feature "TestController", type: :feature do

  scenario 'User tries to get home#insecure with success' do
    visit '/v1/test'

    expect(page).to have_content('Welcome home, master')
  end

  scenario 'User tries to get home#secured with an error' do
    visit '/v1/test/secured'

    expect(page).to have_http_status(401)
  end

  scenario 'User tries to get home#secured with right token and gets green' do
    page.driver.header 'AUTHORIZATION', ActionController::HttpAuthentication::Token.encode_credentials('secret')
    visit '/v1/test/secured'

    expect(page).to_not have_http_status(401)
  end

  scenario 'User tries to get home#secured with wrong token and gets an error' do
    page.driver.header 'AUTHORIZATION', ActionController::HttpAuthentication::Token.encode_credentials('secret123')
    visit '/v1/test/secured'

    expect(page).to have_http_status(401)
  end

  scenario 'User tries to get home#markers' do
    page.driver.header 'AUTHORIZATION', ActionController::HttpAuthentication::Token.encode_credentials('secret')
    visit '/v1/test/markers'

    expect(page).to have_content('markers_count')
  end

end
