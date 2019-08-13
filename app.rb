require 'rubygems'
require 'sinatra'
require 'json'
require './logic.rb'

get '/' do
  erb :index
end

post '/deposit', :provides => :json do
	request.body.rewind
	data = JSON.parse(request.body.read)
	new_hash = CalculationService.validate(data)
	if new_hash.size == 6
		result = CalculationService.calculate_income(new_hash[:money],new_hash[:rate],
			new_hash[:date],new_hash[:term],new_hash[:period],new_hash[:capitalization])
	else
		result = "Wrong parameters"
	end	

	print result
	a = {:result => result}.to_json
	print a

	{:result => result}.to_json
end

