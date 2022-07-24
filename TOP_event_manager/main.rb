# frozen_string_literal: true

require 'csv'
require './lib/date_time'
require './lib/event_manager'
require './lib/phonenum_cleaner'

contents = CSV.open(
  'event_attendees.csv',
  headers: true, 
  header_converters: :symbol
).read

# from event_manager.rb ouputs letters to custom_letters dir.
build_custom_letters(contents)

# from phonenum_cleaner saves new csv to signup_data
format_phone_numbers(contents)

# saves new custom charts & json file to custom_charts
build_custom_charts(contents)
