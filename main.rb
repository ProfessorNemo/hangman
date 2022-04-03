require_relative 'lib/console_interface'
require_relative 'lib/game'
require 'pry-byebug'
# binding.byebug

# 1. Поздороваться
puts 'Всем привет!'

# 2. Загрузить случайное слово из файла
words = File.readlines("#{__dir__}/data/words.txt", chomp: true)
questions = File.readlines("#{__dir__}/data/questions.txt", chomp: true)

index_word = words.index(words.sample)
word = words[index_word]
question = questions[index_word]

game = Game.new(word, question)
console_interface = ConsoleInterface.new(game)

# 3. Пока не закончилась игра
until game.over?
  #  3.1 Вывести очередное состояние игры
  console_interface.print_out
  #  3.2 Спросить очередную букву
  letter = console_interface.get_input
  #  3.3 Обновить состояние игры
  game.play!(letter)
end

# 4. Вывести финальное состояние игры
console_interface.print_out
