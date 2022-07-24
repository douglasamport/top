# frozen_string_literal: true

require 'date'
require 'time'
require 'json'
require 'erb'
require 'csv'

def format_date_time(str)
  str.split(/( )|(\/)/)
     .map.with_index { |n, i| i == 4 ? n.rjust(4, '20') : n }
     .join('')
end

def create_master_array(file)
  file.each_with_object([]) do |line, obj|
    formatted = format_date_time(line[:regdate])
    t = DateTime.strptime(formatted, '%m/%d/%Y %H:%M')
    obj << [t.wday, t.strftime('%H %p')]
  end
end

def save_datetime_file(hash)
  Dir.mkdir('custom_charts') unless Dir.exist?('custom_charts')
  File.open('custom_charts/signup_day_time_data.txt', 'w') do |f|
    data = JSON.dump(hash)
    f.puts(data)
  end
end

def time24to12(str)
  t = DateTime.strptime(str, '%H %p')
  t.strftime('%l %p')
end

def signups_by_hour(array)
  time_arr = array.map { |arr| arr[1] }.sort!.map { |h| time24to12(h)}
  time_arr.each_with_object(Hash.new(0)) { |time, hash| hash[time] += 1 }
end

def signups_by_day(array)
  day_arr = array.sort!.map{ |arr| Date::DAYNAMES[arr[0]] }
  day_arr.each_with_object(Hash.new(0)) { |day, hash| hash[day] += 1 }
end

def signups_by_day_hour(array)
  day_time_arr = array.sort!.map { |arr| [Date::DAYNAMES[arr[0]], time24to12(arr[1])] }
  day_time_arr.each_with_object(Hash.new(0)) { |arr, hash| hash["#{arr[0]} #{arr[1]}"] += 1 }
end

def build_signup_data_hash(array)
  hash = { signups_by_hour: signups_by_hour(array).to_a,
           signups_by_day: signups_by_day(array).to_a,
           signups_by_day_and_hour: signups_by_day_hour(array).to_a }
  save_datetime_file(hash)
  hash
end

def save_custom_charts(fname, custom_chart)
  Dir.mkdir('custom_charts') unless Dir.exist?('custom_charts')
  File.open("custom_charts/#{fname}", 'w') {|f| f.puts(custom_chart)}
end

def custom_chart_construction(hash)
  chart_template = File.read('templates/chart_template.erb')
  erb_template = ERB.new(chart_template)
  hash.to_a.each do |arr|
    chart_name = arr[0].to_s.gsub!('_', ' ')
    chart_data = arr[1]
    fname = "#{arr[0].to_s.gsub('_', '-')}.html"
    custom_chart = erb_template.result(binding)
    save_custom_charts(fname, custom_chart)
  end
end

def build_custom_charts(file)
  puts 'Signup Cruncher Initialized!'
  day_by_hour_array = create_master_array(file)
  signup_datetime_hsh = build_signup_data_hash(day_by_hour_array)
  custom_chart_construction(signup_datetime_hsh)
end
