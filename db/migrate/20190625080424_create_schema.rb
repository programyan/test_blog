# frozen_string_literal: true

class CreateSchema < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :login, null: false

      t.index [:login], unique: true
    end

    create_table :posts do |t|
      t.references :user, index: true
      t.string :title, null: false
      t.text :body, null: false
      t.string :ip, null: false
      t.string :login, null: false
      t.decimal :avg_rank, precision: 18, scale: 2

      t.index [:avg_rank], order: { avg_rank: 'desc nulls last' }
      t.index [:ip, :login]
    end

    create_table :ranks do |t|
      t.references :post, null: false, index: true
      t.integer :rank, null: false
    end

    add_foreign_key :posts, :users
    add_foreign_key :ranks, :posts
  end
end
