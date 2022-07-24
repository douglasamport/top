# frozen_string_literal: true

require 'csv'

def validate_and_format_digits(dig)
  msg = 'Invalid Phone Number'
  return msg if dig.length < 10 || dig.length > 11
  return msg if dig.length == 11 && dig[0] != '1'

  "#{dig[-10..-8]}-#{dig[-7..-5]}-#{dig[-4..-1]}"
end

def save_new_csv(entry_arr, file)
  headers = file.headers
  fname = 'signup_data/form_event_attendees.cvs'
  Dir.mkdir('signup_data') unless Dir.exist?('signup_data')
  CSV.open(fname, 'w', headers: headers, write_headers: true) do |csv|
    entry_arr.each { |entry| csv << entry }
  end
end

def format_phone_numbers(file)
  puts 'Phone Number Cleaner Initialized!'
  entry_arr = []
  file.each do |entry|
    digits =  entry[:homephone].scan(/\d+/).join('')
    entry[:homephone] = validate_and_format_digits(digits)
    entry_arr << entry
  end
  save_new_csv(entry_arr, file)
end
