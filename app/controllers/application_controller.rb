# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Trailblazer::Operation::Controller
  respond_to :json
end
