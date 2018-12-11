# frozen_string_literal: true

require_relative '../lib/puzzle_helper.rb'
require 'time'

module Day4
  class PartOne # :nodoc:
    include PuzzleHelper

    attr_reader :puzzle

    STATES = {
      'falls asleep' => 1,
      'wakes up' => 0
    }.freeze

    def initialize
      @puzzle = read_puzzle
      @result = nil
    end

    def result
      return @result if @result

      shifts = arrange_puzzles
      asleeps =
        shifts.each_with_object(Hash.new { |h, k| h[k] = 0 }) do |(_date, shift), obj|
          obj[shift[:guard]] += shift[:state].sum
        end
      asleep_guard = asleeps.key(asleeps.values.max)

      asleep_total =
        shifts.map do |(_date, shift)|
          next if shift[:guard] != asleep_guard

          shift[:state]
        end.compact

      asleep_matrix = asleep_total[0].zip(*asleep_total[1..-1]).map(&:sum)

      asleep_minutes = asleep_matrix.index(asleep_matrix.max)

      @result = asleep_guard[1..-1].to_i * asleep_minutes.to_i
    end

    def arrange_puzzles
      puzzles =
        puzzle.each_with_object([]) do |message, obj|
          t, m = message.split(']')
          obj.push([Time.parse(t.strip[1..-1].to_s), m.strip])
        end

      guard = nil
      date = nil
      shifts =
        puzzles.sort.each_with_object(Hash.new { |h, k| h[k] = { state: [] } }) do |(t, m), obj|
          if m =~ /\#\d+/
            unless date.nil?
              guard_state = obj[date][:state]
              obj[date][:state] += Array.new(60 - guard_state.size) { guard_state[-1] }
            end

            guard = Regexp.last_match(0)
            next
          end

          date = t.strftime('%m-%d')
          obj[date][:guard] ||= guard

          minutes = t.min
          guard_state = obj[date][:state]

          guard_state +=
            if guard_state.size.zero?
              Array.new(minutes) { STATES['wakes up'] }
            else
              Array.new(minutes - guard_state.size) { guard_state[-1] }
            end

          guard_state << STATES[message]

          obj[date][:state] = guard_state
        end
      guard_state = shifts[date][:state]
      shifts[date][:state] += Array.new(60 - guard_state.size) { guard_state[-1] }

      shifts
    end
  end
end

# pp Day4::PartOne.new.print_result
