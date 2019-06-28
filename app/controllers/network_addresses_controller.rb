# frozen_string_literal: true

class NetworkAddressesController < ApplicationController
  def shared
    respond NetworkAddresses::Shared, location: nil
  end
end
