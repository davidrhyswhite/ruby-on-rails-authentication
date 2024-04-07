class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, null: false, limit: 150
      t.string :email, null: false, index: { unique: true }, limit: 320 # Length: {64}@{255} = 64 + 1 + 255 = 320
      t.string :password_digest, null: false, limit: 60

      t.timestamps
    end
  end
end
