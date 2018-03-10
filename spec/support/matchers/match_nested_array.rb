require 'rspec/expectations'

RSpec::Matchers.define :match_nested_array do |expected|
  match do |nested_array|
    nested_match?(nested_array, expected)
  end

  failure_message do |actual|
    "expected #{actual} to match nested array #{expected}"
  end

  description do
    'match nested array'
  end

  diffable
end

private

# Very cryptic implementation. Just consider it works like match_array, but on a composition of Hashes & Arrays.
def nested_match?(actual, expected)
  # Comparing element with `eq` if not hash/array
  return actual == expected unless [Hash, Array].any? { |klass| actual.is_a?(klass) && expected.is_a?(klass) }
  # Different size
  return false if actual.size != expected.size

  if actual.is_a?(Array)
    actual.sort_by(&:to_s).zip(expected.sort_by(&:to_s)).all? do |(actual_item, expected_item)|
      nested_match?(actual_item, expected_item)
    end
  else # Hash
    actual.keys.all? do |key|
      nested_match?(actual[key], expected[key])
    end
  end
end
