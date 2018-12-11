# frozen_string_literal: true

require_relative '../lib/puzzle_helper.rb'

module Day1
  class PartOne # :nodoc:
    include PuzzleHelper

    attr_reader :puzzle

    def initialize
      @puzzle = read_puzzle.map(&:to_i)
      @result = nil
    end

    def result
      @result ||= puzzle.inject(:+)
    end
  end
end

# pp Day1::PartOne.new.print_result
