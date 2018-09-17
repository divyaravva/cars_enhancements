class Car < ApplicationRecord

	has_many :comments, :dependent => :destroy, :foreign_key => "car_id"
end
