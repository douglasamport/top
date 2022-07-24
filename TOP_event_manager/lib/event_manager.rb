# frozen_string_literal: true

require 'erb'
require 'google-apis-civicinfo_v2'
require 'csv'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def log_error(error)
  logger = Logger.new('logs/err_log.txt')
  logger.formatter = proc { |severity, datetime, progname, msg| "#{severity}, #{datetime}, #{msg}\n" }
  logger.error(error)
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'
  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody','legislatorLowerBody']
    ).officials
  rescue StandardError => e
    log_error(e)
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thankyou_letters(id, custom_letter)
  Dir.mkdir('custom_letters') unless Dir.exist?('custom_letters')
  fname = "custom_letters/thanks_#{id}.html"
  File.open(fname,'w'){ |f| f.puts(custom_letter)}
end

def build_custom_letters(file)
  puts 'EventManager Initialized!'
  form_letter = File.read('templates/form_letter.erb')
  erb_template = ERB.new(form_letter)
  
  file.each do |row|
    name = row[:first_name]
    id = row[0]
    zip = clean_zipcode(row[:zipcode])
    legislators = legislators_by_zipcode(zip)
    custom_letter = erb_template.result(binding)
    save_thankyou_letters(id, custom_letter)
    sleep(1)
  end
end




