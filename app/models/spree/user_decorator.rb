module Spree
  User.class_eval do
    validates :firstname, :lastname, presence: true
  end
end