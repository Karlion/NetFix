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
	result = CalculationService.calculate_income(new_hash[:money],new_hash[:rate],
		new_hash[:date],new_hash[:term],new_hash[:period],new_hash[:capitalization])
	print result
	{:result => result}.to_json
end

