class Car < ApplicationRecord
	
	require 'open_weather'
	WEATHER_API_KEY= "9412c4a3513302a0699db4659eae553e"
	has_many :comments, :dependent => :destroy, :foreign_key => "car_id"


	def self.show_weather_based_on_city
		options = { units: "metric", APPID: WEATHER_API_KEY }
		OpenWeather::Current.city_id("5219003", options)
	end
end
