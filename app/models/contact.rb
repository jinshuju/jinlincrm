class Contact < ActiveRecord::Base
  has_many :contact_notes
  validates_presence_of :full_name
end
