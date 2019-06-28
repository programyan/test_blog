# frozen_string_literal: true

module Posts
  class Create < ApplicationOperation
    contract Forms::PostForm

    representer PostRepresenter

    def model!(*)
      Post.new
    end

    def process(params)
      validate(params) do
        contract.save
        CreateAuthorJob.perform_later(model.id)
      end
    end
  end
end
