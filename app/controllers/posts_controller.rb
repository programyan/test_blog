# frozen_string_literal: true

class PostsController < ApplicationController
  def create
    respond Posts::Create, location: nil
  end

  def rank
    ActiveRecord::Base.transaction(isolation: :repeatable_read) do
      respond Posts::Rank, location: nil
    end
  end

  def top
    respond Posts::TopN
  end
end
