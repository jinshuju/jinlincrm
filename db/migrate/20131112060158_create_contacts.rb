class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :full_name
      t.string :title
      t.string :company
      t.string :phone
      t.string :email
      t.string :qq
      t.string :weibo
      t.string :website
      t.text :background_info

      t.timestamps
    end
  end
end
