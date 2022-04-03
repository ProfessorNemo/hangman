require 'pry-byebug'
# binding.byebug

PW = 'lib/'
%W[#{PW}console_interface #{PW}game #{PW}answer].each do |file|
  require_relative file
end

puts 'Всем привет!'

# 2. Загрузить случайное слово с вопросом из файла
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

  puts 'Введите слово, если знаете ответ. Или нажмите <enter> и продолжайте отгадывать по буквам'
  print '>'
  input_answer = STDIN.gets.chomp

  unless input_answer.empty?
    quick_response = Answer.new(input_answer, word, question, game)

    quick_response.printing
    exit
  end

  #  3.2 Спросить очередную букву
  letter = console_interface.get_input
  #  3.3 Обновить состояние игры
  game.play!(letter)
end

# 4. Вывести финальное состояние игры
console_interface.print_out if input_answer.empty?
