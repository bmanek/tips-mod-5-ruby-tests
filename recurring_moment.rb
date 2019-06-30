require 'active_support'
require 'active_support/core_ext'
require 'pry'

class RecurringMoment
  def initialize(start:, interval:, period:)
    @start = start
    @interval = interval
    @period = period
  end

  def match(date)
    current = @start

    while current < date
      if current == date
        return true
      end

      if @period == 'monthly'
        current = current.advance(months: @interval)
      elsif @period == 'weekly'
        current = current.advance(weeks: @interval)
      elsif @period == 'daily'
        current = current.advance(days: @interval)
      end
    end

    return false
  end
end


# tried:
# reviewed the test suite, had questions
#   - what is 'context'? (read online a bit to better understand)
#   - 75 tests: is something simple out of whack? (tried switching a couple
# booleans, observed changes in behavior)

# Ran the program directly (ruby recurring_moment.rb in bash), found error:
# = in elsif, not ==. changed to ==, tests still fail

# Re-read test suite, revisit code and found mismatch in lns19-22. if @period == "monthly" ...current.advance(weeks:)
#
# similar mismatch elsif @period == "weekly" ... current.advance(months:)
#
# Changed, but all tests still fail.

# Tried pry in ln 7, received warning re: zeitwerk "recommend gem cleanup
#  zeitwerk". Did that, trying again

# Forgetting how to inspect class definitions; unsure how to reach pry...

# Changed a couple things and saw no difference in behavior - are the tests
# running the correct file? Yes, just checked by changing 'require_relative'
# in the test suite. Errors out w/ 'cannot load such file' if the file isn't
# right...

# Looking at it again a day later: I don't trust the definition of current...
