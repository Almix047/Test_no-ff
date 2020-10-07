# frozen_string_literal: true

# Configuration of the output view
class OutputList
  HEADER = %w[
    Login Followers ER Date DailyFollowers FollowersAVG Media MediaAVG
  ].freeze

  attr_reader :dataset

  def initialize(dataset)
    @dataset = dataset
    @rows = []
  end

  def call
    prepare_list_info
  end

  private

  def prepare_list_info
    dataset.each do |info|
      if info.valid_page?
        t_daily = info.table_daily
        row = [
          info.login, info.followers, info.er, info.date,
          t_daily[0].text.tr(',', ''), info.table_followers_avg,
          t_daily[2].text.tr(',', ''), info.table_media_avg
        ]
      else
        row = [info.login, 'nevalid']
      end
      @rows.push(row)
    end
    @rows.unshift(HEADER)
  end
end
