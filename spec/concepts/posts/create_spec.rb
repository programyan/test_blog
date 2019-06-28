# frozen_string_literal: true

require 'rails_helper'

module Posts
  RSpec.describe Create do
    let(:operation_run) { described_class.run(params) }
    let(:result) { operation_run[0] }
    let(:operation) { operation_run[1] }

    let(:params) do
      {
        title: title,
        body: body,
        login: login,
        ip: ip,
      }
    end

    let(:title) { Faker::Lorem.word }
    let(:body) { Faker::Lorem.sentence }
    let(:ip) { Faker::Internet.public_ip_v4_address }
    let(:login) { Faker::Internet.username }

    before { allow(CreateAuthorJob).to receive(:perform_later) }

    describe '.call' do
      specify { expect(result).to eq true }
      specify { expect { operation_run }.to change(Post, :count).by(1) }

      context 'with background job' do
        before { operation_run }

        specify { expect(CreateAuthorJob).to have_received(:perform_later).with(Post.last.id) }
      end

      context 'with post attributes' do
        specify { expect(operation.model.title).to eq title }
        specify { expect(operation.model.body).to eq body }
        specify { expect(operation.model.ip).to eq ip }
        specify { expect(operation.model.login).to eq login }
      end
    end
  end
end
