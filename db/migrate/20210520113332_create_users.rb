class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :account
      t.string :email
      t.string :phone
      t.date :birthday
      t.string :gender
      t.text :intro
      t.string :img
      t.string :password_digest

      t.timestamps
    end
  end
end
