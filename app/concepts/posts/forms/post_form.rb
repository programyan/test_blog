# frozen_string_literal: true

module Posts
  module Forms
    class PostForm < Reform::Form
      property :title
      property :body
      property :ip
      property :login

      validates :title, :body, :ip, :login, presence: true
      validates :ip, ip: true
    end
  end
end
