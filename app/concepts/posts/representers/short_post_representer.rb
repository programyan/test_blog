# frozen_string_literal: true

module Posts
  module Representers
    class ShortPostRepresenter < ApplicationRepresenter
      property :title
      property :body
    end
  end
end
