class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :full_name
      t.string :photo
      t.string :cover_image

      t.timestamps
    end
  end
end
