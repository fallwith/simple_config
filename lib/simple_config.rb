require File.join(File.dirname(__FILE__), 'errors')
module SimpleConfig
  require 'ostruct'

  class Settings 
    DEFAULT_DELIMITER = '='
    
    attr_reader :delimiter

    def initialize
      @delimiter = DEFAULT_DELIMITER
    end

    def delimiter= desired_delimiter
      @delimiter = desired_delimiter
      desired_delimiter
    end
  end
  SETTINGS = Settings.new

  def self.load_file(path)
    load(File.read(path))
  end

  def self.load(config)
    struct = OpenStruct.new
    config.split("\n").each_with_index do |line, index|
      next if line =~ /^\s*\#/ || line == ''
      pair = line.split(/\s+#{Regexp.escape(SETTINGS.delimiter)}\s+/)
      if pair.size == 2 && !pair.detect{|half| half == ''}
        pair[-1] = case pair.last
            when 'true' then true
            when 'false' then false
            when 'nil' then nil
            when /^\d+$/ then pair.last.to_i
            else pair.last
          end
        struct.send("#{pair.first}=", pair.last)
      else
        raise InputError, "Line #{index+1} of config input is invalid:\n\t#{line}"
      end
    end
    struct
  end
end

