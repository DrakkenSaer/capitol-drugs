module Spree
  User.class_eval do
    validates :firstname, :lastname, presence: true, unless: :admin?
  end
end