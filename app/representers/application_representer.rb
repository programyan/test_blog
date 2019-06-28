# frozen_string_literal: true

require 'representable/json'

class ApplicationRepresenter < Representable::Decorator
  include Representable::JSON

  defaults render_nil: true
end
