# frozen_string_literal: true

module Posts
  class SetAverageRankJob < ApplicationJob
    def perform(post_id)
      Post
        .where(id: post_id)
        .update(
          avg_rank: ::Rank.where(post_id: post_id).average(:rank),
        )
    end
  end
end
