# frozen_string_literal: true

require_relative '../lib/puzzle_helper.rb'

module Day5
  class PartTwo # :nodoc:
    include PuzzleHelper

    attr_reader :puzzle

    def initialize
      @puzzle = read_puzzle(split: false)
      @result = nil
    end

    def result
      return @result if @result

      letter_res = {}
      letter_idx = -1

      while (letter = puzzle[letter_idx += 1])
        next if letter_res.key?(letter.downcase)

        tr_puzzle = puzzle.tr([letter.downcase, letter.upcase].join, '')
        res = [tr_puzzle[0]]
        idx = 0

        while (unit = tr_puzzle[idx += 1])
          r = res.last
          if r
            if r != unit && r.casecmp?(unit)
              res.pop
              next
            end
          end
          res << unit
        end

        letter_res[letter.downcase] = res.size
      end

      @result = letter_res.min_by(&:last)[1]
    end
  end
end

# pp Day5::PartTwo.new.print_result
