require 'spec_helper'

describe CrittersController do
  before :each do
    Critter.any_instance.stub(:critter_data_is_valid).and_return(true)
  end

  it 'creates a critter when passing token and data' do
    token = 'iamatokenshortandstout'
    Critter.create(token: token)

    post :create, {critter: {token: token, data: 'this is some critter data'}, format: :json}
    expect(response.status).to eq(200)
    json = JSON.parse(response.body)
    data_hash = json['critter']['data_hash']
    expect(data_hash).to eq('2cd366b6b2c01770f9753984b7d73fda')
  end

  it 'returns critter data when passing hash' do
    token = 'iamanothertokenshortandstout'
    Critter.create(token: token)

    post :create, {critter: {token: token, data: 'critter critter data critter'}, format: :json}
    expect(response.status).to eq(200)

    json = JSON.parse(response.body)
    data_hash = json['critter']['data_hash']
    expect(data_hash).to eq('b2fb4e951ecd68ddb225acd97f2b61ba')

    get :show, id: data_hash, format: :json
    json = JSON.parse(response.body)
    data_hash = json['critter']['data_hash']
    expect(data_hash).to eq('b2fb4e951ecd68ddb225acd97f2b61ba')
    data = json['critter']['data']
    expect(data).to eq('critter critter data critter')
  end

  it 'returns all critter hashes' do
    token = 'iamanothertokenshortandstoutagain'
    Critter.create(token: token)

    post :create, {critter: {token: token, data: 'more critter data critter'}, format: :json}
    expect(response.status).to eq(200)
    json = JSON.parse(response.body)
    data_hash = json['critter']['data_hash']

    get :index
    expect(response.status).to eq(200)
    json = JSON.parse(response.body)
    critters = json['critters']
    expect(critters).to include(data_hash)
  end
end
