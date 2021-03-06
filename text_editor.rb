class TextEditor
  def initialize
    @save_file = "text_editor_save.txt"
    @text = []
    run
  end

  private

  def run
    greet
    prompt_load

    puts
    puts 'Type "quit" to stop entering text.'
    puts

    loop do
      line = gets.chomp
      break if line == "quit"
      @text << line
    end

    print
    prompt_edit
    prompt_save
  end

  def greet
    greeting = %q(
     _____  _     _____    _____ _______   _______ 
    /  __ \| |   |_   _|  |_   _|  ___\ \ / /_   _|
    | /  \/| |     | |      | | | |__  \ V /  | |  
    | |    | |     | |      | | |  __| /   \  | |  
    | \__/\| |_____| |_     | | | |___/ /^\ \ | |  
     \____/\_____/\___/     \_/ \____/\/   \/ \_/ 
    )

    puts greeting
    puts
  end

  def prompt_load
    input = nil
    until input == "N" || input == "L"
      puts "Would you like to start a (N)ew file or (L)oad an existing file?"
      puts
      input = gets.chomp.upcase
    end

    load if input == "L"
  end

  def load
    if File.exist?(@save_file)
      file = File.open(@save_file, "r")
      file.each_line {|line| @text << line}
    else
      puts "No saved file exists. Starting new file."
    end
    puts
  end

  def print
    puts
    puts "You wrote:"
    @text.each_with_index {|sentence, line| puts "#{line+1} #{sentence}"}
    puts
  end

  def prompt_edit
    puts "Would you like to edit a line? (Y/N)"
    puts
    response = gets.chomp.upcase

    if response == "Y"
      line = nil
      until (1..@text.length).include? line
        puts
        puts "Which line would you like to edit?"
        line = gets.chomp.to_i
      end

      edit(line)
    end
  end

  def edit(line)
    puts
    puts "Was:"
    puts @text[line-1]
    puts

    puts "Enter new text:"
    @text[line-1] = gets.chomp
    puts

    print
  end

  def prompt_save
    puts "Would you like to save? (Y/N)"
    puts
    input = gets.chomp.upcase

    save if input = "Y"
  end

  def save
    file = File.open(@save_file, "w")
    file.puts(@text)
  end
end

TextEditor.new