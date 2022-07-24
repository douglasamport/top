require 'logger'
logger = Logger.new('bug_logs.log', 'weekly')
# logger = Logger.new(STDOUT)

word_group = ["laboratory", "experiment", nil, "Pans Labyrinth", 2,  "elaborate", "polar bear"]

def check_string(array, snippit)
  
  array.each do |string| 
    begin
      if string.include? snippit
        puts string
      # else
      #   puts "#{string} does not include #{snippit}"
      end
    rescue
      # $logger.debug("The exceptions sent us #{string}")
      puts "exception"
    end
  end

end

logger.info "user did something interesting"
check_string(word_group, "lab")