# frozen_string_literal: true

module Posts
  class CreateAuthorJob < ApplicationJob
    def perform(post_id)
      post = Post.find(post_id)

      author = User.find_or_create_by(login: post.login)

      post.update(user_id: author.id)
    end
  end
end
