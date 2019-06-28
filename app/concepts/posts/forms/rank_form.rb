# frozen_string_literal: true

module Posts
  module Forms
    class RankForm < Reform::Form
      property :rank

      validates :rank, inclusion: { in: 1..5 }, numericality: { only_integer: true }
    end
  end
end
