# frozen_string_literal: true

%w[
  ./lib
  ./
].each do |p|
  puts p
  $LOAD_PATH << p
end

%w[
  day1/part_one
  day1/part_two
  day2/part_one
  day2/part_two
  day3/part_one
  day3/part_two
  day4/part_one
  day4/part_two
  day5/part_one
  day5/part_two
].each do |c|
  puts "loading #{c}..."
  require_relative "./#{c}"
end
