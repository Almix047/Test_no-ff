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
      row = [
        info.login, info.followers, info.er, info.date,
        info.table_daily[0].text.tr(',', ''), info.table_avg[0].text.tr(',', ''),
        info.table_daily[2].text.tr(',', ''), info.table_avg[2].text.tr(',', '')
      ]
      @rows.push(row)
    end
    @rows.unshift(HEADER)
  end
end
