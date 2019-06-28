# frozen_string_literal: true

require 'rails_helper'

module Posts
  module Forms
    RSpec.describe RankForm do
      let(:form) { described_class.new(model) }
      let(:form_validate) { form.validate(params) }
      let(:error_messages) { form.errors.messages }

      let(:model) { ::Rank.new(post_id: post.id) }
      let(:post) { create(:post) }

      let(:params) { { rank: rank } }

      let(:rank) { nil }

      before { form_validate }

      context 'with blank params' do
        specify { expect(error_messages[:rank]).to match_array ['is not a number', 'is not included in the list'] }
      end

      context 'with greater value of the valid range' do
        let(:rank) { 6 }

        specify { expect(error_messages[:rank]).to match_array ['is not included in the list'] }
      end

      context 'with less value of the valid range' do
        let(:rank) { 0 }

        specify { expect(error_messages[:rank]).to match_array ['is not included in the list'] }
      end

      context 'with float point in range' do
        let(:rank) { 2.5 }

        specify { expect(error_messages[:rank]).to match_array ['must be an integer'] }
      end

      context 'with valid params' do
        let(:rank) { (1..5).to_a.sample }

        specify { expect(error_messages).to be_blank }
      end
    end
  end
end
