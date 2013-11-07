class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :password, null: false
      t.string :name, null: false
      t.string :session, null: false

      t.timestamps
    end

    add_index :users, :session, unique: true
    add_index :users, :username, unique: true
  end
end
