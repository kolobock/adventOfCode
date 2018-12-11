
** Start an irb console

    bundle console

  In case to load all days just load puzzle.rb

    load './puzzle.rb'

** DAY 1 (https://adventofcode.com/2018/day/1)

    require_relative 'day1/part_one.rb'
    puzzle = Day1::PartOne.new
    puzzle.print_result

    require_relative 'day1/part_two.rb'
    puzzle = Day1::PartTwo.new
    puzzle.print_result

** DAY 2 (https://adventofcode.com/2018/day/2)

    require_relative 'day2/part_one.rb'
    puzzle = Day2::PartOne.new
    puzzle.print_result

    require_relative 'day2/part_two.rb'
    puzzle = Day2::PartTwo.new
    puzzle.print_result

** DAY 3 (https://adventofcode.com/2018/day/3)

    require_relative 'day3/part_one.rb'
    puzzle = Day3::PartOne.new
    puzzle.print_result

  Part One and Part Two have the identical parts for calculations
  so it can be combined within the same class

    require_relative 'day3/part_two.rb'
    puzzle = Day3::PartTwo.new
    puzzle.print_result
    puzzle.print_result_one

** DAY 4 (https://adventofcode.com/2018/day/4)

    require_relative 'day4/part_one.rb'
    puzzle = Day4::PartOne.new
    puzzle.print_result

    require_relative 'day4/part_two.rb'
    puzzle = Day4::PartTwo.new
    puzzle.print_result

** DAY 5 (https://adventofcode.com/2018/day/5)

    require_relative 'day5/part_one.rb'
    puzzle = Day5::PartOne.new
    puzzle.print_result

    require_relative 'day5/part_two.rb'
    puzzle = Day5::PartTwo.new
    puzzle.print_result

