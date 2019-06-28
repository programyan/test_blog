# frozen_string_literal: true

module Posts
  module Facades
    class TopNFacade
      def initialize(limit)
        @limit = limit || DEFAULT_LIMIT
      end

      def posts
        Post.order('avg_rank DESC NULLS LAST').limit(limit)
      end

      private

      attr_reader :limit

      DEFAULT_LIMIT = 5
    end
  end
end
