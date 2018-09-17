class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :car_id
      t.text :commnet_body

      t.timestamps
    end
  end
end
