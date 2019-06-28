# frozen_string_literal: true

require 'rails_helper'

module Posts
  module Facades
    RSpec.describe TopNFacade do
      describe '#posts' do
        subject { described_class.new(limit).posts }

        let!(:post1) { create(:post, avg_rank: 4) }
        let!(:post2) { create(:post, avg_rank: 3) }
        let!(:post3) { create(:post, avg_rank: 3.6) }
        let!(:post4) { create(:post, avg_rank: 4.2) }
        let!(:post5) { create(:post, avg_rank: 2.7) }
        let!(:post6) { create(:post, avg_rank: nil) }

        context 'without limit' do
          let(:limit) { nil }

          it 'default limit 5' do
            is_expected.to eq [post4, post1, post3, post2, post5]
          end
        end

        context 'with limit 3' do
          let(:limit) { 3 }

          specify { is_expected.to eq [post4, post1, post3] }
        end

        context 'with limit 10' do
          let(:limit) { 10 }

          specify { is_expected.to eq [post4, post1, post3, post2, post5, post6] }
        end
      end
    end
  end
end
