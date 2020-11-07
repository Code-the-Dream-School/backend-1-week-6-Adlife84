require 'sinatra'

enable :sessions

set :bind, "0.0.0.0"




get '/'do
    "Hello from '/' route!"
    erb :start_game 
end

get '/foo' do
  session[:message] = 'Hello World!'
  session[:secret] = 57
  session[:guess_history] = [11, 23]
  
  redirect to('/bar')
end

get '/bar' do
  session[:message]   # => 'Hello World!'
end

get '/game' do
  erb :game
end






# get '/foo' do
#     "Hello from '/foo' route!"
#     session[:secret] = 57
#     session[:guess_history] = [11, 23]
#     redirect "/bar"
# end

# get '/bar' do
#     "Hello from '/bar' route!"
#     session[:secret]   # => '57'
# end


