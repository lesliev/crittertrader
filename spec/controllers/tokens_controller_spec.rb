require 'spec_helper'

describe TokensController do
  it 'returns a token if critter has no data' do
    get :show, {data_hash: '12345', format: :json}
    expect(response.status).to eq(200)
    json = JSON.parse(response.body)
    expect(json['critter']['token']).to_not be_nil
  end

  it 'creates a critter when passing token and data' do
    get :show, {data_hash: '12345', format: :json}
    expect(response.status).to eq(200)
    json = JSON.parse(response.body)
    token = json['critter']['token']

    post :create, {critter: {token: token, data: 'this is some critter data'}, format: :json}
    expect(response.status).to eq(200)
    json = JSON.parse(response.body)
    data_hash = json['critter']['data_hash']
    expect(data_hash).to eq('2cd366b6b2c01770f9753984b7d73fda')
  end

  it 'returns critter data when passing hash' do
    get :show
    expect(response.status).to eq(200)
    json = JSON.parse(response.body)
    token = json['critter']['token']

    post :create, {critter: {token: token, data: 'critter critter data critter'}, format: :json}
    expect(response.status).to eq(200)

    json = JSON.parse(response.body)
    data_hash = json['critter']['data_hash']
    expect(data_hash).to eq('b2fb4e951ecd68ddb225acd97f2b61ba')

    get :show, {critter: {data_hash: data_hash}, format: :json}
    json = JSON.parse(response.body)
    data_hash = json['critter']['data_hash']
    expect(data_hash).to eq('b2fb4e951ecd68ddb225acd97f2b61ba')
    data = json['critter']['data']
    expect(data).to eq('critter critter data critter')
  end
end
