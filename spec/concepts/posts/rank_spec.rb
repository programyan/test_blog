# frozen_string_literal: true

require 'rails_helper'

module Posts
  RSpec.describe Rank do
    let(:operation_run) { described_class.run(params) }
    let(:result) { operation_run[0] }
    let(:operation) { operation_run[1] }

    let(:params) do
      {
        id: id,
        rank: rank,
      }
    end

    let(:post) { create(:post) }
    let(:id) { post.id }
    let(:rank) { (1..5).to_a.sample }

    before { allow(SetAverageRankJob).to receive(:perform_later) }

    describe '.call' do
      specify { expect(result).to eq true }
      specify { expect { operation_run }.to change(::Rank, :count).by(1) }
      specify { expect(operation.model.rank).to eq rank }

      context 'with background job' do
        before { operation_run }

        specify { expect(SetAverageRankJob).to have_received(:perform_later).with(id) }
      end
    end
  end
end
