require 'spec_helper'

describe TokensController do
  it 'returns a token' do
    get :index
    expect(response.status).to eq(200)
    json = JSON.parse(response.body)
    expect(json['critter']['token']).to_not be_nil
  end
end
