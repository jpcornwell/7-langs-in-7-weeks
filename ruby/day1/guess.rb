#!/usr/bin/env ruby

puts 'Guess number from 1 to 10.'

number = rand(10) + 1
guess = 0

until guess == number
  print '> '
  guess = gets.to_i
  puts 'Too high' if guess > number
  puts 'Too low'  if guess < number
  puts 'Correct!' if guess == number
end

