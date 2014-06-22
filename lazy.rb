require 'sinatra'
require 'sinatra/reloader'
require 'googlevoiceapi'
api = GoogleVoice::Api.new('zyoung14@gmail.com', '')
#require 'pry'

enable :sessions
enable :method_override
@@rows_total = 10

get '/' do
	session['circles'] ||= {}
	erb :index, :locals => { :result => session["circles"].sort_by { |k,v| v["circle_count"]*(-1) }  }
end

get '/new' do
	erb :new
end

get '/:circle_name' do
	a = session["circles"][params[:circle_name]]["names_and_numbers"]
	b = []
	a.each do |hash| 
		hash.select {|k,v| b.push(v) }
	end

	# b.each do |number|
	# 	if number != ""
	# 		api.sms(number, session["circles"][params[:circle_name]]["message"])
	# 	end
	# end

	session["circles"][params[:circle_name]]["circle_count"] += 1
	erb :custom, :locals => { :result => "Text has been sent! :)"}
end

post '/' do
	session["circles"] ||= {}
	
	circle_count = 0
	names_and_numbers =  Array.new
	@@rows_total.times do |count|
		new_guy = params["name#{count}".to_sym]
		new_digit = params["digit#{count}".to_sym]
		if new_guy != "" && new_digit != ""
			names_and_numbers.push ({new_guy => new_digit})
		end
	end

	session["circles"].store(params[:circle_name], {
		"circle_name" => params[:circle_name], 
		"message" => params[:message], 
		"names_and_numbers" => names_and_numbers,
		"circle_size" => names_and_numbers.length,
		"circle_count" => circle_count})

	erb :index, :locals => { :result => session["circles"].sort_by { |k,v| v["circle_count"]*(-1) }  }
end

delete '/' do
	session["circles"] ||= {}
	session["circles"].delete(params[:circle])
	redirect to ('/')
end

