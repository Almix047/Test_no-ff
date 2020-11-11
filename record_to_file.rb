# frozen_string_literal: true

require_relative 'output_list.rb'
require_relative 'page.rb'
require 'csv'

OUTPUT_FILENAME = "output_#{Time.now.localtime.strftime('%Y%m%d-%H:%M:%S')}.csv"
OUTPUT_FILE = File.expand_path('../../' + OUTPUT_FILENAME, __FILE__)

# Testing mode (offline, work with cache)
CACHE = { khloekardashian: '../cache/kho.html',
          beyonce: '../cache/Bey.html',
          kyliejenner: '../cache/kyl.html',
          kimkardashian: '../cache/kim.html',
          jlo: '../cache/jlo.html',
          balegavasia: '../cache/nvd.html' }.freeze

# Recording scraped Information
class RecordToFile
  def self.save_as_csv_file
    # Testing mode (offline, work with cache)
    dataset = []
    INPUT.reject(&:empty?).each do |site|
      cache_page_path = CACHE[site.to_sym]
      if cache_page_path
        site_page = Page.new(cache_page_path)
        unless site_page.resource_page?
          puts 'Need refresh'
          break
        end
        dataset.push(site_page)
      end
    end

    rows = OutputList.new(dataset).call

    # Return if no items to parse are found.
    # 1 because the first row is the HEADER.
    return if rows.length == 1

    CSV.open(OUTPUT_FILE, 'wb') do |csv|
      rows.each { |row| csv << row }
    end
  end
end
