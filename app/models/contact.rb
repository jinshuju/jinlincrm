class Contact < ActiveRecord::Base
  has_many :contact_notes, order: "occurred_on desc"
  validates_presence_of :full_name
end
