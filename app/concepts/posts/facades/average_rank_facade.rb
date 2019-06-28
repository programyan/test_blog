# frozen_string_literal: true

module Posts
  module Facades
    class AverageRankFacade
      def initialize(post_id)
        @post_id = post_id
      end

      def avg_rank
        ::Rank.where(post_id: post_id).average(:rank)
      end

      private

      attr_reader :post_id
    end
  end
end
