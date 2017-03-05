class V1::TestController < ApplicationController

  before_action :authenticate, except: [:insecure]

  def insecure
    result = {status: 200}
    result[:text] = 'Welcome home, master!'
    result[:value] = random_string

    render json: result
  end

  def secured
    result = {status: 200}
    result[:text] = 'Welcome home, master!'
    result[:value] = random_string

    render json: result
  end

  def markers
    result = {status: 200}

    result[:markers] = (5...15).to_a.sample.times.map do |t|
      {
          label: "#{random_string} #{%w(City Town Village).sample}",
          latitude: 47.00 + "0.0#{(5..25).to_a.sample}".to_f,
          longitude: 29.00 + "0.0#{(10..35).to_a.sample}".to_f
      }
    end

    result[:markers_count] = result[:markers].size

    render json: result
  end

  private
  def random_string
    (0...10).map { (65 + rand(26)).chr }.join
  end

end
