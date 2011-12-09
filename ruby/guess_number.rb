puts "Guess my number (between 1 and 10)!"
my_number = rand(10)+1
correct = false

until correct 
  print "Your guess: "
  gets # Get a line of input from command line
  your_guess = $_.to_i # Make sure it's an integer
  if your_guess == my_number
    puts "That's my number!"
    correct = true
  elsif your_guess < my_number
    puts "Too low.."
  else
    puts "Too high..."
  end
end