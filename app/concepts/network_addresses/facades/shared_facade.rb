# frozen_string_literal: true

module NetworkAddresses
  module Facades
    class SharedFacade
      def list
        Post
          .group(:ip)
          .having('array_length(array_agg(distinct login), 1) > 1')
          .select('ip, array_agg(distinct login) as logins')
          .as_json(except: :id)
      end
    end
  end
end
