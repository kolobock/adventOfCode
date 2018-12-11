# frozen_string_literal: true

require_relative '../lib/puzzle_helper.rb'

module Day2
  class PartOne # :nodoc:
    include PuzzleHelper

    attr_reader :puzzle

    def initialize
      @puzzle = read_puzzle
      @result = nil
      @cb = []
    end

    def result
      return @result if @result

      box_counts =
        uniq_chars_count.each_with_object(Hash.new { |h, k| h[k] = 0 }) do |cnt, obj|
          cnt.each do |c|
            obj[c] += 1
          end
        end

      @result = box_counts.values.inject(:*)
    end

    private

    def uniq_chars_count
      return @cb if @cb.any?

      puzzle.each_with_object(@cb) do |box, cb|
        r = Hash.new { |h, k| h[k] = 0 }
        box.each_char do |c|
          r[c] += 1
        end
        cb << (r.values.uniq - [1])
      end
    end
  end
end

# pp Day2::PartOne.new.print_result
