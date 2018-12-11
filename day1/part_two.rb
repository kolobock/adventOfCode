# frozen_string_literal: true

require_relative '../lib/puzzle_helper.rb'

module Day1
  class PartTwo # :nodoc:
    include PuzzleHelper

    attr_reader :puzzle

    def initialize
      @puzzle = read_puzzle.map(&:to_i).to_enum
      @result = nil
      @freqs = []
      @freq = 0
      @iterations = 0
    end

    def result
      return @result if @result

      loop do
        @freq += puzzle.next

        break if @freqs.include?(@freq)

        @freqs << @freq
      rescue StopIteration
        print '.' if ((@iterations += 1) % 10).zero?

        puzzle.rewind
      end
      puts

      @result = @freq
    end
  end
end

# pp Day1::PartTwo.new.print_result
