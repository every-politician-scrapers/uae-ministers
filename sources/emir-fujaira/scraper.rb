#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class OfficeholderList < OfficeholderListBase
  decorator RemoveReferences
  decorator UnspanAllTables
  decorator WikidataIdsDecorator::Links

  def header_column
    'Ruled'
  end

  def table_number
    4
  end

  class Officeholder < OfficeholderBase
    def columns
      %w[dates name].freeze
    end

    def raw_combo_date
      super.gsub(/\(.*?\)/, '').tidy
    end
  end
end

url = ARGV.first
puts EveryPoliticianScraper::ScraperData.new(url, klass: OfficeholderList).csv
