# frozen_string_literal: true

require 'nokogiri'

class PageParser
  attr_reader :link

  def initialize(link)
    @link = link
  end

  def fetch_page
    @fetch_page ||= parse_page(link)
  end

  private

  def parse_page(link)
    Nokogiri::HTML(File.open(link)) # Testing mode (offline, work with cache)
  end
end
