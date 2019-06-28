# frozen_string_literal: true

require 'rails_helper'

module Posts
  RSpec.describe CreateAuthorJob do
    describe '#perform' do
      subject(:run_job) { described_class.perform_now(post_id) }

      let!(:post_id) { post.id }

      context 'with existing author' do
        let(:post) { create(:post) }

        specify { expect { run_job }.not_to change(User, :count) }
      end

      context 'without author' do
        let(:post) { create(:post, :without_user) }

        specify { expect { run_job }.to change(User, :count).by(1) }
      end
    end
  end
end
