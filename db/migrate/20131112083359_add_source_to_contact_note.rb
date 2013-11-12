class AddSourceToContactNote < ActiveRecord::Migration
  def change
    add_column :contact_notes, :source, :string
  end
end
