# frozen_string_literal: true

require 'rails_helper'

module Posts
  module Forms
    RSpec.describe PostForm do
      let(:form) { described_class.new(model) }
      let(:form_validate) { form.validate(params) }
      let(:error_messages) { form.errors.messages }

      let(:model) { Post.new }

      let(:params) do
        {
          title: title,
          body: body,
          ip: ip,
          login: login,
        }
      end

      let(:title) { nil }
      let(:body) { nil }
      let(:ip) { nil }
      let(:login) { nil }

      before { form_validate }

      context 'with blank params' do
        specify { expect(error_messages[:title]).to match_array ["can't be blank"] }
        specify { expect(error_messages[:body]).to match_array ["can't be blank"] }
        specify { expect(error_messages[:ip]).to match_array ["can't be blank"] }
        specify { expect(error_messages[:login]).to match_array ["can't be blank"] }
      end

      context 'with non ip address' do
        let(:ip) { Faker::Internet.email }

        specify { expect(error_messages[:ip]).to match_array ['is invalid'] }
      end

      context 'with valid params' do
        let(:title) { Faker::Lorem.word }
        let(:body) { Faker::Lorem.sentence }
        let(:ip) { Faker::Internet.public_ip_v4_address }
        let(:login) { Faker::Internet.username }

        specify { expect(error_messages).to be_blank }
      end
    end
  end
end
