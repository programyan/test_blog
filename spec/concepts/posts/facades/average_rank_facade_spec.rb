# frozen_string_literal: true

require 'rails_helper'

module Posts
  module Facades
    RSpec.describe AverageRankFacade do
      describe '#avg_rank' do
        subject { described_class.new(post_id).avg_rank.to_f }

        let(:post) { create(:post) }
        let(:post_id) { post.id }

        context 'with one rank' do
          let!(:rank) { create(:rank, post: post) }

          specify { is_expected.to eq rank.rank }
        end

        context 'with several ranks' do
          let!(:rank1) { create(:rank, post: post) }
          let!(:rank2) { create(:rank, post: post) }
          let!(:rank3) { create(:rank) }
          let!(:rank4) { create(:rank, post: post) }

          specify { is_expected.to eq((rank1.rank + rank2.rank + rank4.rank) / 3.0) }
        end
      end
    end
  end
end
