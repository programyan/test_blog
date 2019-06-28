# frozen_string_literal: true

module NetworkAddresses
  class Shared < ApplicationOperation
    representer Representers::SharedRepresenter

    def represented
      Facades::SharedFacade.new
    end
  end
end
