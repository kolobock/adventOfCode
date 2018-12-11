# frozen_string_literal: true

require_relative '../lib/puzzle_helper.rb'

module Day5
  class PartOne # :nodoc:
    include PuzzleHelper

    attr_reader :puzzle

    def initialize
      @puzzle = read_puzzle(split: false)
      @result = nil
    end

    def result
      return @result if @result

      res = [puzzle[0]]
      idx = 0

      while (unit = puzzle[idx += 1])
        r = res.last
        if r
          if r != unit && r.casecmp?(unit)
            res.pop
            next
          end
        end
        res << unit
      end

      @result = res.size
    end
  end
end

# pp Day5::PartOne.new.print_result
