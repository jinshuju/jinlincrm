class ContactNote < ActiveRecord::Base
  belongs_to :contact
  belongs_to :user
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  validates_presence_of :notes, :contact, :occurred_on
end
