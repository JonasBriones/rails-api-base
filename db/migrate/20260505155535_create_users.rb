# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :fullName
      t.string :dni
      t.string :email
      t.date   :date_of_birth
      t.string :password_digest
      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :dni, unique: true
  end
end
