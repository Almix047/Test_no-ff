# frozen_string_literal: true

require_relative 'record_to_file.rb'
require_relative 'input_list_fetcher.rb'

INPUT = InputListFetcher.read_from_file

RecordToFile.save_as_csv_file
