# frozen_string_literal: true

require 'rails_helper'

module NetworkAddresses
  module Facades
    RSpec.describe SharedFacade do
      describe '#list' do
        subject(:list) { described_class.new.list }

        let(:user1) { create(:user) }
        let(:user2) { create(:user) }
        let(:ip1) { Faker::Internet.public_ip_v4_address }
        let(:ip2) { Faker::Internet.public_ip_v4_address }

        let!(:post1) { create(:post, login: user1.login, user: user1, ip: ip1) }
        let!(:post2) { create(:post, login: user1.login, user: user1, ip: ip1) }
        let!(:post3) { create(:post, login: user1.login, user: user1, ip: ip2) }
        let!(:post4) { create(:post, login: user2.login, user: user2, ip: ip2) }

        specify { expect(list[0]['ip']).to eq ip2 }
        specify { expect(list[0]['logins']).to match_array [user1.login, user2.login] }
      end
    end
  end
end
