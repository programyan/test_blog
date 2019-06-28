# frozen_string_literal: true

require 'rails_helper'

module Posts
  RSpec.describe SetAverageRankJob do
    describe '#perform' do
      subject(:run_job) { described_class.perform_now(post_id) }

      let(:post_id) { post.id }
      let(:post) { create(:post) }

      before do
        create(:rank, post: post, rank: 2)
        create(:rank, post: post, rank: 5)
        create(:rank, post: post, rank: 3)
        create(:rank, post: post, rank: 1)
        create(:rank, rank: 4)

        run_job
      end

      specify { expect(post.reload.avg_rank).to eq 2.75 }
    end
  end
end
