# frozen_string_literal: true

DEFAULT_FILENAME = 'input.txt'
DEFAULT_FILE = File.expand_path('../../' + DEFAULT_FILENAME, __FILE__)

class InputListFetcher
  def self.read_from_file
    if File.exist? DEFAULT_FILE
      File.foreach(DEFAULT_FILE).map(&:chomp)
    else
      puts 'Input data file is missing or has an invalid name.'
      puts 'The file should be named "input.txt" and be located next to the <source> folder.'
      exit
    end
  end
end
