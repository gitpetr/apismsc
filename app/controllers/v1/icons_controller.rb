class V1::IconsController < ApplicationController
  def index
    @icons = Icon.ordered.all

    render json: @icons.as_json(only: [:id, :uid, :name])
  end
end
