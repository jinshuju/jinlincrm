class CreateContactNotes < ActiveRecord::Migration
  def change
    create_table :contact_notes do |t|
      t.text :notes
      t.references :contact, index: true
      t.datetime :occurred_on
      t.references :user, index: true

      t.timestamps
    end
  end
end
