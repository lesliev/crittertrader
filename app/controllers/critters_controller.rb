class CrittersController < ApplicationController
  skip_before_action :verify_authenticity_token
  respond_to :json

  def index
    critters = Critter.all.map{|c| c.data_hash}
    render json: {critters: critters}
  end

  # Load and show critter pointed to by hash, or if that resource
  # does not exist, provide a token for uploading it
  def show
    data_hash = params[:id]
    critter = Critter.where(data_hash: data_hash).first
    render json: {critter: {data: critter.data, data_hash: critter.data_hash}}
  end

  # Once a token is retrieved from show, pass the token with the critter data
  def create
    token = params[:critter][:token]
    data = params[:critter][:data]

    critter = Critter.where(token: token).first
    if critter
      if critter.data
        render json: {errors: ['Critter data already exists']}, status: :conflict
      else
        critter.data_hash = generate_hash(data)
        critter.data = data

        if critter.save
          render json: {critter: {data_hash: critter.data_hash, token: critter.token}}
        else
          render json: {errors: critter.errors.messages}
        end
      end
    else
      render json: {errors: ['You need to request a token first with /show']}, status: :bad_request
    end
  end

private

  def generate_hash(data)
    Digest::MD5.hexdigest(data)
  end

  def generate_token
    SecureRandom.uuid
  end
end

