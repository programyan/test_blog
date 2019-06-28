# frozen_string_literal: true

module Posts
  class Rank < ApplicationOperation
    contract Forms::RankForm

    representer Representers::AverageRankRepresenter

    def represented
      Facades::AverageRankFacade.new(model.post_id)
    end

    def model!(params)
      ::Rank.new(post_id: params[:id])
    end

    def process(params)
      validate(params) do
        contract.save
        SetAverageRankJob.perform_later(model.post_id)
      end
    end
  end
end
