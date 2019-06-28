# frozen_string_literal: true

module Posts
  module Representers
    class TopNRepresenter < ApplicationRepresenter
      collection :posts, decorator: ShortPostRepresenter
    end
  end
end
