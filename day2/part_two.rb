# frozen_string_literal: true

require_relative '../lib/puzzle_helper.rb'

module Day2
  class PartTwo # :nodoc:
    include PuzzleHelper

    attr_reader :puzzle

    def initialize
      @puzzle = read_puzzle
      @result = nil
      @iteration = 0
    end

    def result
      return @result if @result

      res = ''

      loop do
        b1 = puzzle[@iteration]

        break if b1.nil?

        puzzle[(@iteration += 1)..-1].each do |b2|
          diff = diff_char(b1, b2)
          res = diff if res.size < diff.size
        end
      end

      @result = res.join
    end

    private

    def diff_char(boo1, boo2)
      boo1.each_char.to_a.keep_if.with_index { |b, idx| b == boo2.each_char.to_a[idx] }
    end
  end
end

# pp Day2::PartTwo.new.print_result
