# frozen_string_literal: true

module PuzzleHelper # :nodoc:
  def read_puzzle(split: true)
    fl = "#{self.class.name.split('::').first.downcase}/puzzles.txt"
    r = File.read(fl)
    return r.chomp unless split

    r.split("\n")
  end

  def print_result
    # rubocop:disable Style/RedundantSelf
    pp self.result
    # rubocop:enable Style/RedundantSelf
  end

  def print_result_one
    result_memo = result
    @result = @result_one

    print_result
  ensure
    @result = result_memo
  end
end
