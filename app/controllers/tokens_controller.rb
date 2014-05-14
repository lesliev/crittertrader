class TokensController < ApplicationController

  skip_before_action :verify_authenticity_token
  respond_to :json

  def index
    token = generate_token
    critter = Critter.create(token: token)
    render json: {critter: {token: critter.token}}
  end

private

  def generate_token
    SecureRandom.uuid
  end
end

