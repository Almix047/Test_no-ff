# frozen_string_literal: true

require_relative 'page_parser.rb'

DAY = 86_400

LOGIN_XPATH = '//div[@id="YouTubeUserTopInfoBlockTop"]//h2/text()'

TOP_INFO_BLOCK = '//div[@id="YouTubeUserTopInfoBlockTop"]//div[@class="YouTubeUserTopInfo"]'
FOLLOWERS_XPATH = TOP_INFO_BLOCK + '/span[text()="Followers"]/../span[2]'
ER_XPATH = TOP_INFO_BLOCK + '/span[text()="Engagement Rate"]/../span[3]'

TABLE_AVG_FOLLOWERS_XPATH = '//div[contains(text(), "Daily Averages")]/..//span'

class Page
  attr_reader :parser, :date

  def initialize(link)
    @parser = PageParser.new(link)
    @date = table_date
  end

  def login
    parser.fetch_page.xpath(LOGIN_XPATH).text.strip
  end

  def followers
    parser.fetch_page.xpath(FOLLOWERS_XPATH).text.tr(',', '')
  end

  def er
    parser.fetch_page.xpath(ER_XPATH).text.strip
  end

  def table_daily
    date_xpath = "//div[contains(text(), '#{date}')]/../..//span"
    parser.fetch_page.xpath(date_xpath)
  end

  def table_avg
    parser.fetch_page.xpath(TABLE_AVG_FOLLOWERS_XPATH)
  end

  private

  def table_date
    current_time = Time.now.localtime
    yesterday = current_time - DAY
    yesterday.strftime('%Y-%m-%d')
  end
end
