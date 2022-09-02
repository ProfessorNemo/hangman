# frozen_string_literal: true

class Answer
  attr_reader :letters, :input_answer

  FIG = ConsoleInterface::FIGURES
  TOTAL_ERRORS_ALLOWED = Game::TOTAL_ERRORS_ALLOWED

  def initialize(input_answer, word, question, game)
    @input_answer = input_answer.upcase.chars
    @letters = word.chars
    @question = question
    @game = game
  end

  def normalize_letter(text)
    if text.include?('Ё')
      text.join.tr('Ё', 'Е').chars
    elsif text.include?('Й')
      text.join.tr('Й', 'Е').chars
    else
      text
    end
  end

  def printing
    if won?
      puts <<~GAMESTATUS
        \nВопрос: #{@question}
        Слово: #{ColorizedString[letters.join].colorize(:light_black).colorize(background: :light_white)}
        #{ColorizedString[FIG[@game.errors_made]].colorize(:yellow)}
        Поздравляем, вы выиграли!
      GAMESTATUS
    else
      puts <<~ANSWER
        Вопрос: #{@question}
        #{ColorizedString[FIG[TOTAL_ERRORS_ALLOWED]].colorize(:yellow)}
        Вы проиграли, загаданное слово: #{ColorizedString[letters.join].colorize(:green)}
      ANSWER
    end
  end

  # Возвращает true, если пользователь отгадал слово
  def won?
    (normalize_letter(letters) - normalize_letter(input_answer)).empty?
  end
end
