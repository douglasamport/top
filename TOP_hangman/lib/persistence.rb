require 'yaml'

module Persistence #:nodoc:
 
  def save
    class_file = YAML.dump(self)
    Dir.mkdir('saved') unless Dir.exist?('saved')
    File.open('saved/saved_game.txt', 'w') { |f| f.write(class_file) }
  end

  def self.included(klass)
    klass.extend(ClassMethods)
  end

  module ClassMethods #:nodoc:
    def load(fname)
      file = File.open(fname, 'r')
      YAML.load(file)
    end
  end
end
