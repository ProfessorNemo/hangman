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
      text.join.gsub('Ё', 'Е').chars
    elsif text.include?('Й')
      text.join.gsub('Й', 'Е').chars
    else
      text
    end
  end

  def printing
    if won?
      puts <<~END
        \nВопрос: #{@question}
        Слово: #{letters.join}
        #{FIG[@game.errors_made]}
        Поздравляем, вы выиграли!
      END
    else
      puts <<~END
        Вопрос: #{@question}
        #{FIG[TOTAL_ERRORS_ALLOWED]}
        Вы проиграли, загаданное слово: #{letters.join}
      END
    end
  end

  # Возвращает true, если пользователь отгадал слово
  def won?
    (normalize_letter(letters) - normalize_letter(input_answer)).empty?
  end
end
