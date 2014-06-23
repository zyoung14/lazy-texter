require 'sinatra'
#require 'sinatra/reloader'
require 'twilio-ruby'
# require 'googlevoiceapi'
#api = GoogleVoice::Api.new('zyoung14@gmail.com', 'mynameiszach')
#require 'pry'

account_sid = 'AC6bb55ecdf61f02c7692ab0e2b1883bca' 
auth_token = '02320eafb5cc10b0a95d187407a1ca11'
@@client = Twilio::REST::Client.new account_sid, auth_token

enable :sessions
enable :method_override
@@rows_total = 26

get '/' do
	session['circles'] ||= {}
	erb :index, :locals => { :result => session["circles"].sort_by { |k,v| v["circle_count"]*(-1) }  }
end

get '/new' do
	erb :new
end

get '/:circle_name' do
	b = Array.new
	session["circles"][params[:circle_name]]["names_and_numbers"].each do |hash| 
		hash.select {|k,v| b.push(v) }
	end

	b.each do |number|
		if number != ""
			message = @@client.account.messages.create(:body => "Sent from Zach Young via Lazy Txtr:  " + session["circles"][params[:circle_name]]["message"],
	 			:to => number,
	    		:from => "+15132582662")
	    	puts message.to
	    end
	end

	session["circles"][params[:circle_name]]["circle_count"] += 1
	erb :post_text, :locals => { :result => "Text has been sent! :)"}
end

get '/:circle_name/edit' do
	erb :edit, :locals => {:result => session["circles"][params[:circle_name]]}
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

put '/' do
	session["circles"] ||= {}
	session["circles"][params[:circle_name]]["message"] = params[:message]
	redirect to ('/')
end

delete '/' do
	session["circles"] ||= {}
	session["circles"].delete(params[:circle])
	redirect to ('/')
end

