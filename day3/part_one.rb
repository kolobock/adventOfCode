# frozen_string_literal: true

require_relative '../lib/puzzle_helper.rb'
require 'matrix'

module Day3
  class PartOne # :nodoc:
    include PuzzleHelper

    attr_reader :puzzle

    def initialize
      @puzzle = read_puzzle
      @result = nil
      @dimensions = [0, 0]
    end

    def result
      return @result if @result

      calculate_dimensions

      matrix = nil
      claims.each do |claim|
        fabric = claim_fabric(claim)
        if matrix.nil?
          matrix = fabric
          next
        end
        matrix = matrix.combine(fabric) { |a, b| a + b }
      end

      @result = matrix.sum { |a| a > 1 ? 1 : 0 }
    end

    private

    def claims
      @claims ||=
        puzzle.each_with_object([]) do |claim_puzzle, clms|
          clms << parse_claim(claim_puzzle)
        end
    end

    def calculate_dimensions
      claims.each do |claim|
        @dimensions[0] = [claim[:offset][0] + claim[:box][0], @dimensions[0]].max
        @dimensions[1] = [claim[:offset][1] + claim[:box][1], @dimensions[1]].max
      end
    end

    def claim_fabric(claim)
      fabric = []
      row = 0

      loop do
        break if (row += 1) > @dimensions[1]

        fabric <<
          if row <= claim[:offset][1] || row > claim[:offset][1] + claim[:box][1]
            Array.new(@dimensions[0]) { 0 }
          else
            Array.new(claim[:offset][0]) { 0 } +
            Array.new(claim[:box][0]) { 1 } +
            Array.new(@dimensions[0] - claim[:offset][0] - claim[:box][0]) { 0 }
          end
      end

      Matrix[*fabric]
    end

    def parse_claim(claim_puzzle)
      id_part, dimension_part = claim_puzzle.split('@').map(&:strip)

      claim = {
        claim_id: id_part[1..-1]
      }

      offset, box = dimension_part.split(':').map(&:strip)

      claim.update(offset: offset.split(',').map(&:strip).map(&:to_i))
      claim.update(box: box.split('x').map(&:strip).map(&:to_i))
    end
  end
end

# pp Day3::PartOne.new.print_result
