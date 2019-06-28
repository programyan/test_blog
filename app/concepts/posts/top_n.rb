# frozen_string_literal: true

module Posts
  class TopN < ApplicationOperation
    representer Representers::TopNRepresenter

    def represented
      Facades::TopNFacade.new(@params[:limit])
    end
  end
end
