#  Переопределение методов в сисетмном классе
# class String
#   def ==(other)
#     return false unless other.is_a?(String)

#     two_chars = [ord, other.ord].sort
#     # из юникодовых таблиц: 1025 - Е, 1045 - Ё
#     return true if two_chars == [1025, 1045]

#     # вызов оригинального метода через super
#     super
#   end
# end

class Game
  attr_reader :question
  # Количество допустимых ошибок
  TOTAL_ERRORS_ALLOWED = 7

  # Конструктор класса Game на вход получает строку с загаданным словом.
  #
  # В конструкторе инициализируем две переменные экземпляра: массив букв
  # загаданного слова и пустой массив для дальнейшего сбора в него вводимых
  # букв.
  def initialize(word, question)
    @letters = word.chars
    @question = question
    @user_guesses = []
  end

  # Возвращает массив букв, введенных пользователем, но отсутствующих в
  # загаданном слове (ошибочные буквы)
  def errors
    @user_guesses - normalized_letters
  end

  # Возвращает количество ошибок, сделанных пользователем
  def errors_made
    errors.length
  end

  # Отнимает от допустимого количества ошибок число сделанных ошибок и
  # возвращает оставшееся число допустимых ошибок
  def errors_allowed
    TOTAL_ERRORS_ALLOWED - errors_made
  end

  def normalize_letter(letter) # принимаем букву в параметр
    case letter
    when 'Ё' then 'Е'
    when 'Й' then 'И'
    else letter
    end
  end

  def normalized_letters
    @letters.map { |letter| normalize_letter(letter) } # преобразуем букву в массиве букв
  end

  # Возвращает массив с уже отгаданными буквами, вместо неотгаданных букв в
  # массиве на соответствующем месте находится nil. Этот массив нужен методу
  # экземпляра класса ConsoleInterface для вывода слова на игровом табло.
  def letters_to_guess
    @letters.map do |letter|
      letter if @user_guesses.include?(normalize_letter(letter))
    end
  end

  # Возвращает true, если у пользователя не осталось ошибок, т.е. игра проиграна
  def lost?
    errors_allowed.zero?
  end

  # Возвращает true, если игра закончена (проиграна или выиграна)
  def over?
    won? || lost?
  end

  # По сути, это основной игровой метод, типа "сыграть букву".
  #
  # Если игра не закончена и передаваемая буква отсутствует в массиве
  # введённых букв, то закидывает передаваемую букву в массив "попыток".
  def play!(letter)
    normalize_letter = normalize_letter(letter)
    @user_guesses << normalize_letter if !over? && !@user_guesses.include?(normalize_letter)
  end

  # Возвращает true, если не осталось неотгаданных букв (пользователь выиграл)
  def won?
    (normalized_letters - @user_guesses).empty?
  end

  # Возвращает загаданное слово, склеивая его из загаданных букв
  def word
    @letters.join
  end
end
