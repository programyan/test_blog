# frozen_string_literal: true

class CreateSchema < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :login, null: false
    end

    create_table :posts do |t|
      t.references :user, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.string :ip, null: false
    end

    create_table :ranks do |t|
      t.references :post, null: false
      t.integer :rank, null: false
    end
  end
end
