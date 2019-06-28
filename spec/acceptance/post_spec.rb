# frozen_string_literal: true

require 'acceptance_helper'

RSpec.resource 'API - Posts', acceptance: true do
  post '/posts' do
    parameter :title, 'Заголовок'
    parameter :body, 'Текст сообщения'
    parameter :login, 'Логин автора сообщений'
    parameter :ip, 'IP адрес, с которого было отправлено сообщение'

    let(:title) { Faker::Lorem.word }
    let(:body) { Faker::Lorem.sentence }
    let(:ip) { Faker::Internet.public_ip_v4_address }
    let(:login) { Faker::Internet.username }

    example_request 'Create' do
      expect(response_status).to eq(201)
    end
  end

  post '/posts/:id/rank' do
    parameter :id, 'ID поста'
    parameter :rank, 'Оценка'

    let(:id) { create(:post).id }
    let(:rank) { (1..5).to_a.sample }

    example_request 'Rank' do
      expect(response_status).to eq(201)
    end
  end

  get '/posts/top' do
    parameter :limit, 'Количество первых запросов'

    let(:limit) { 3 }

    let!(:post1) { create(:post, avg_rank: 4.5) }
    let!(:post2) { create(:post, avg_rank: 3.5) }
    let!(:post3) { create(:post, avg_rank: 5) }
    let!(:post4) { create(:post, avg_rank: 4) }

    example_request 'Top N' do
      expect(response_status).to eq 200
    end
  end
end
