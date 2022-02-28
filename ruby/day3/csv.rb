#!/usr/bin/env ruby

module ActsAsCsv
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def acts_as_csv
      include InstanceMethods
    end
  end

  module InstanceMethods
    class CsvRow
      attr_accessor :headers, :row_contents

      def method_missing name, *args
        name = name.to_s
        index = @headers.find_index(name)
        return @row_contents[index]
      end
    end

    def read
      @csv_contents = []
      filename = self.class.to_s.downcase + '.txt'
      file = File.new(filename)
      @headers = file.gets.chomp.split(', ' )
      file.each do |row|
        @csv_contents << row.chomp.split(', ' )
      end
    end

    def each
      @csv_contents.each do |line|
        row = CsvRow.new
        row.headers = @headers
        row.row_contents = line
        yield row
      end
    end

    attr_accessor :headers, :csv_contents

    def initialize
        read
    end
  end
end

class RubyCsv # no inheritance! You can mix it in
  include ActsAsCsv
  acts_as_csv
end

csv = RubyCsv.new

puts 'Verbs'
print '  '
csv.each {|row| print row.verb + ', '}
print "\n\n"

puts 'Nouns'
print '  '
csv.each {|row| print row.noun + ', '}
print "\n\n"

