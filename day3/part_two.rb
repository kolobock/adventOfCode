# frozen_string_literal: true

require_relative '../lib/puzzle_helper.rb'
require 'matrix'

module Day3
  class PartTwo # :nodoc:
    include PuzzleHelper

    attr_reader :puzzle

    def initialize
      @puzzle = read_puzzle
      @result = nil
      @claims = nil
      @fabrics = {}
      @dimensions = [0, 0]
    end

    def result
      return @result if @result

      build_fabrics

      print 'combining fabrics'
      @matrixes = build_matrixes

      puts
      puts "Matrixes have built: #{@matrixes.size}"

      @matrix = combine_matrix
      puts 'Matrix combined!'

      # PartOne result
      @result_one = @matrix.sum { |a| a > 1 ? 1 : 0 }
      puts(resultOne: @result_one)

      # PartTwo calculations
      @result = detect_claim_id
    end

    def build_fabrics
      return unless @fabrics.empty?

      print 'building fabrics'
      @fabrics =
        Parallel.map(claims, in_processes: 6) do |claim|
          print '.'
          claim_fabric(claim)
        end

      puts
      puts "Fabrics have built: #{@fabrics.size}"
    end

    private

    def claims
      return @claims unless @claims.empty?

      puzzle.each_with_object(@claims) do |claim_puzzle, claims|
        claims << parse_claim(claim_puzzle)
      end
    end

    def dimensions
      return @dimensions unless @dimensions[0].zero?

      claims.each_with_object(@dimensions) do |claim, dim|
        dim[0] = [claim[:offset][0] + claim[:box][0], dim[0]].max
        dim[1] = [claim[:offset][1] + claim[:box][1], dim[1]].max
      end
    end

    def claim_fabric(claim)
      fabric = []
      row = 0

      loop do
        break if (row += 1) > dimensions[1]

        fabric <<
          if row <= claim[:offset][1] || row > claim[:offset][1] + claim[:box][1]
            Array.new(dimensions[0]) { 0 }
          else
            Array.new(claim[:offset][0]) { 0 } +
            Array.new(claim[:box][0]) { 1 } +
            Array.new(dimensions[0] - claim[:offset][0] - claim[:box][0]) { 0 }
          end
      end

      Matrix[*fabric]
    end

    def parse_claim(claim_puzzle)
      id_part, dimension_part = claim_puzzle.split('@').map(&:strip)

      claim = {
        claim_id: id_part[1..-1].to_i
      }

      offset, box = dimension_part.split(':').map(&:strip)

      claim.update(offset: offset.split(',').map(&:strip).map(&:to_i))
      claim.update(box: box.split('x').map(&:strip).map(&:to_i))
    end

    def build_matrixes
      Parallel.map(@fabrics.each_slice(10), in_processes: 6) do |fabrics|
        print '.'
        matrix = fabrics.shift
        loop do
          break if fabrics.size.zero?

          matrix = matrix.combine(fabrics.shift) { |a, b| a + b }
        end
        matrix
      end
    end

    def combine_matrix
      matrix = @matrixes.shift
      loop do
        break if @matrixes.size.zero?

        matrix = matrix.combine(@matrixes.shift) { |a, b| a + b }
      end
      matrix
    end

    def detect_claim_id
      matrix_sum = @matrix.sum
      puts(matrixSum: matrix_sum)

      while (claim = @claims.shift)
        fabric = @fabrics.delete(claim[:claim_id])

        fabric_sum = @matrix.combine(fabric) { |a, b| a != b ? a + b : a }.sum

        next if matrix_sum != fabric_sum

        @matrix = nil
        @fabrics = nil
        @claims = nil
        @puzzle = nil
        # PartTwo result
        return claim[:claim_id]
      end
    end
  end
end

# pp Day3::PartTwo.new.print_result
# pp Day3::PartTwo.new.print_result_one
