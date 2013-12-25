class Contact < ActiveRecord::Base
  has_many :contact_notes, order: "occurred_on desc"
  validates_presence_of :full_name
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }
end
