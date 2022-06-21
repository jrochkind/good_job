# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `timers` gem.
# Please instead update this file by running `bin/tapioca gem timers`.

module Timers; end

# Maintains a PriorityHeap of events ordered on time, which can be cancelled.
class Timers::Events
  # @return [Events] a new instance of Events
  def initialize; end

  # Fire all handles for which Handle#time is less than the given time.
  def fire(time); end

  # Returns the first non-cancelled handle.
  def first; end

  # Add an event at the given time.
  def schedule(time, callback); end

  # Returns the number of pending (possibly cancelled) events.
  def size; end

  private

  # Move all non-cancelled timers from the pending queue to the priority heap
  def merge!; end
end

# Represents a cancellable handle for a specific timer event.
class Timers::Events::Handle
  include ::Comparable

  # @return [Handle] a new instance of Handle
  def initialize(time, callback); end

  def <=>(other); end

  # Cancel this timer, O(1).
  def cancel!; end

  # Has this timer been cancelled? Cancelled timer's don't fire.
  #
  # @return [Boolean]
  def cancelled?; end

  # Fire the callback if not cancelled with the given time parameter.
  def fire(time); end

  # The absolute time that the handle should be fired at.
  def time; end
end

# A collection of timers which may fire at different times
class Timers::Group
  include ::Enumerable
  extend ::Forwardable

  # @return [Group] a new instance of Group
  def initialize; end

  # Call the given block after the given interval. The first argument will be
  # the time at which the group was asked to fire timers for.
  def after(interval, &block); end

  # Cancel all timers.
  def cancel; end

  # Resume all timers.
  def continue; end

  # The group's current time.
  def current_offset; end

  # Delay all timers.
  def delay(seconds); end

  def each(*args, &block); end
  def empty?(*args, &block); end

  # Scheduled events:
  def events; end

  # Call the given block periodically at the given interval. The first
  # argument will be the time at which the group was asked to fire timers for.
  def every(interval, recur = T.unsafe(nil), &block); end

  # Fire all timers that are ready.
  def fire(offset = T.unsafe(nil)); end

  # Call the given block immediately, and then after the given interval. The first
  # argument will be the time at which the group was asked to fire timers for.
  def now_and_after(interval, &block); end

  # Call the given block immediately, and then periodically at the given interval. The first
  # argument will be the time at which the group was asked to fire timers for.
  def now_and_every(interval, recur = T.unsafe(nil), &block); end

  # Pause all timers.
  def pause; end

  # Paused timers:
  def paused_timers; end

  # Resume all timers.
  def resume; end

  # Active timers:
  def timers; end

  # Wait for the next timer and fire it. Can take a block, which should behave
  # like sleep(n), except that n may be nil (sleep forever) or a negative
  # number (fire immediately after return).
  def wait; end

  # Interval to wait until when the next timer will fire.
  # - nil: no timers
  # - -ve: timers expired already
  # -   0: timers ready to fire
  # - +ve: timers waiting to fire
  def wait_interval(offset = T.unsafe(nil)); end
end

# A collection of timers which may fire at different times
class Timers::Interval
  # Get the current elapsed monotonic time.
  #
  # @return [Interval] a new instance of Interval
  def initialize; end

  def start; end
  def stop; end
  def to_f; end

  protected

  def duration; end
  def now; end
end

# A priority queue implementation using a standard binary minheap. It uses straight comparison
# of its contents to determine priority. This works because a Handle from Timers::Events implements
# the '<' operation by comparing the expiry time.
# See <https://en.wikipedia.org/wiki/Binary_heap> for explanations of the main methods.
class Timers::PriorityHeap
  # @return [PriorityHeap] a new instance of PriorityHeap
  def initialize; end

  # Returns the earliest timer or nil if the heap is empty.
  def peek; end

  # Returns the earliest timer if the heap is non-empty and removes it from the heap.
  # Returns nil if the heap is empty. (and doesn't change the heap in that case)
  def pop; end

  # Inserts a new timer into the heap, then rearranges elements until the heap invariant is true again.
  def push(element); end

  # Returns the number of elements in the heap
  def size; end

  private

  def bubble_down(index); end
  def bubble_up(index); end
  def swap(i, j); end

  # Validate the heap invariant.
  def validate!(index = T.unsafe(nil)); end
end

# An individual timer set to fire a given proc at a given time. A timer is
# always connected to a Timer::Group but it would ONLY be in @group.timers
# if it also has a @handle specified. Otherwise it is either PAUSED or has
# been FIRED and is not recurring. You can manually enter this state by
# calling #cancel and resume normal operation by calling #reset.
class Timers::Timer
  include ::Comparable

  # @return [Timer] a new instance of Timer
  def initialize(group, interval, recurring = T.unsafe(nil), offset = T.unsafe(nil), &block); end

  # Fire the block.
  def call(offset = T.unsafe(nil)); end

  # Cancel this timer. Do not call while paused.
  def cancel; end

  def continue; end

  # Extend this timer
  def delay(seconds); end

  # Fire the block.
  def fire(offset = T.unsafe(nil)); end

  # Number of seconds until next fire / since last fire
  def fires_in; end

  # Inspect a timer
  def inspect; end

  # Returns the value of attribute interval.
  def interval; end

  # Returns the value of attribute offset.
  def offset; end

  def pause; end

  # @return [Boolean]
  def paused?; end

  # Returns the value of attribute recurring.
  def recurring; end

  # Reset this timer. Do not call while paused.
  #
  # @param offset [Numeric] the duration to add to the timer.
  def reset(offset = T.unsafe(nil)); end

  def resume; end
end

Timers::VERSION = T.let(T.unsafe(nil), String)

# An exclusive, monotonic timeout class.
class Timers::Wait
  # @return [Wait] a new instance of Wait
  def initialize(duration); end

  # Returns the value of attribute duration.
  def duration; end

  # Returns the value of attribute remaining.
  def remaining; end

  # Yields while time remains for work to be done:
  def while_time_remaining; end

  private

  # @return [Boolean]
  def time_remaining?; end

  class << self
    def for(duration, &block); end
  end
end
