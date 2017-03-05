class V1::ColorsController < ApplicationController
  def index
    @colors = Color.ordered.all

    render json: @colors.as_json(only: [:id, :uid, :hex_code, :name])
  end
end
