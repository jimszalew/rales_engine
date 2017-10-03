require 'rails_helper'

describe 'Merchant API', type: :request do
  it 'returns all of merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_success
  end
end
