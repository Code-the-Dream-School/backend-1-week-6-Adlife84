require 'sinatra'

enable :sessions

set :bind, "0.0.0.0"

#Global variable
counter = 7
random_number = rand(1..100)
guess_history = []
backgroundColor = "Red"
isWin = FALSE
result = ""



# Take a number as argument and return (win, lose, counter of guesses)
# if number < random more than 10 to frize 
# if number < random less than 10 to cold
# if number > random more than 10 to hot
# if number > random less than 10 to warm
# if number == random than Win!!! :)
# if counter == 0 than Lose :( 

# Main method of the game (takes 3 argument and return result as a String)
def mainLogicGame(number, random_number, counter)
    puts "Hello from mainLogicGame! Number is: #{number} "
    puts "Delta is: #{delta = random_number - number}"
    
    delta = random_number - number
    
      if counter == 1 
        puts "Sorry :((( You Lose. #{delta}"
        result = "Sorry :((( You Lose."
        # redirect "/result"
      elsif delta == 0
        puts "You Win! :) #{delta}"
        result = "You Guessed!!!"
        # redirect "/result"
      
      elsif delta > 0  
        if delta <= 10
          puts "#{delta} <= 10"
          result = "Your guess is much too low!!!"
          changeBackground("Salmon")
        else
          puts "#{delta} > 10"
          result = "Your guess is close but too low!"
          changeBackground("FireBrick")
        end

      elsif delta < 0
        if delta >= -10
          puts "#{delta} >= -10"
          result = "Your guess is close but too high!"
          changeBackground("LightSkyBlue")
        else
          puts "#{delta} < -10"
          result = "Your guess is way too high!!!"
          changeBackground("DeepSkyBlue")
        end

      else
          puts "Sorry! Nothing mutch :( #{delta}"
          result = "Sorry! Nothing mutch :( #{delta}"
      end 
    return result
end

def changeBackground(colorName = "Salmon")
  # backgroundColor = "Salmon"
  # backgroundColor = "FireBrick"
  # backgroundColor = "LightSkyBlue"
  # backgroundColor = "DeepSkyBlue"
  puts "BackgroundColor is: #{colorName}"
  session[:backgroundColor] = colorName
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
  @backgroundColor = session[:backgroundColor]
  @result = session[:guess_result]
  
  # Check Won or Lose if true go to /result page with all data else continue the game 
  if result == "You Guessed!!!" || result == "Sorry :((( You Lose."
    session[:total_result] = @result
    redirect "/result"
  else
    erb :game 
  end
  
end


post '/guess' do
  "Hello from guess"
  result = mainLogicGame(params["number"].to_i, random_number, counter)
  session[:guess_result] = result
  session[:guess_history] = params["number"]
  guess_history.push(params["number"].to_i)
  counter = counter - 1
  redirect "/game"
end

get '/result' do
  puts "Hello from Total Result"
  @guess_history = guess_history
  @total_result = session[:total_result]
  
  # Reset game status 
  counter = 7
  guess_history = []
  random_number = rand(1..100)
  result = ""

  erb :total_result
end



# # Example session
# get '/foo' do
#   session[:message] = 'Hello World!'
#   session[:secret] = 57
#   session[:guess_history] = [11, 23]
  
#   redirect ('/bar')
# end

# get '/bar' do
#   session[:message]   # => 'Hello World!'
# end

