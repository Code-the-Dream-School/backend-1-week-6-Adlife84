require 'sinatra'

enable :sessions

set :bind, "0.0.0.0"

#Global variable
counter = 7
random_number = rand(1..100)
guess_history = []
backgroundColor = "Salmon"
isWin = FALSE


# Take a number as argument and return (win, lose, counter of guesses)
# if number < random more than 10 to frize 
# if number < random less than 10 to cold
# if number > random more than 10 to hot
# if number > random less than 10 to warm
# if number == random than Win!!! :)
# if counter == 0 than Lose :( 
def mainLogicGame(number, random_number, counter)
    puts "Hello from mainLogicGame number is: #{number} "
    puts "Delta is: #{delta = random_number - number}"
    
    delta = random_number - number
    result = ""

      if counter == 0 
        result = "Sorry :((( You Lose."
      elsif delta == 0
      puts "You Win! :) #{delta}"
      result = "You Guessed!!!"

      elsif delta > 0  
        if delta <= 10
          puts "#{delta} <= 10"
          result = "It is Hot!!!"
          backgroundColor = "Salmon"
        else
          puts "#{delta} > 10"
          result = "It is Warm!"
          backgroundColor = "FireBrick"
        end

      elsif delta < 0
        if delta >= -10
          puts "#{delta} <= -10"
          result = "It's Cold"
          backgroundColor = "LightSkyBlue"
          
        else
          puts "#{delta} > -10"
          result = "It's Super cold!!!"
          backgroundColor = "DeepSkyBlue"
        end

      else
          puts "Sorry! Nothing mutch :( #{delta}"
          resul = "Sorry! Nothing mutch :( #{delta}"
      end
      return result
end


get '/'do
    "Hello from '/' route!"
    erb :start_game 
end



get '/game' do
  @random_number = random_number
  @guessNumber = session[:guess_history]
  @guess_history = guess_history
  @counter = counter
  @backgroundColor = backgroundColor
  @result = session[:guess_result]
  erb :game
end


post '/guess' do
  "Hello from guess"
  session[:guess_result] = mainLogicGame(params["number"].to_i, random_number, counter)
  session[:guess_history] = params["number"]
  guess_history.push(params["number"].to_i)
  counter = counter - 1
  redirect "/game"
end



# Example session
get '/foo' do
  session[:message] = 'Hello World!'
  session[:secret] = 57
  session[:guess_history] = [11, 23]
  
  redirect ('/bar')
end

get '/bar' do
  session[:message]   # => 'Hello World!'
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


