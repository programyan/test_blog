# frozen_string_literal: true

require 'acceptance_helper'

RSpec.resource 'API - NetworkAddresses', acceptance: true do
  get '/network_addresses/shared' do
    let(:ip1) { Faker::Internet.public_ip_v4_address }
    let(:ip2) { Faker::Internet.public_ip_v4_address }

    before do
      create(:post, ip: ip1)
      create(:post, ip: ip1)
      create(:post)
      create(:post, ip: ip2)
      create(:post, ip: ip2)
      create(:post)
      create(:post, ip: ip2)
      create(:post, ip: ip2)
    end

    example_request 'Shared IP addreses' do
      expect(response_status).to eq(200)
    end
  end
end
