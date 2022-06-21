# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `sigdump` gem.
# Please instead update this file by running `bin/tapioca gem sigdump`.

module Sigdump
  class << self
    def dump(path = T.unsafe(nil)); end
    def dump_all_thread_backtrace(io); end
    def dump_backtrace(thread, io); end
    def dump_gc_profiler_result(io); end
    def dump_gc_stat(io); end
    def dump_object_count(io); end
    def setup(signal = T.unsafe(nil), path = T.unsafe(nil)); end

    private

    def _fn(num); end
    def _open_dump_path(path, &block); end
  end
end

Sigdump::VERSION = T.let(T.unsafe(nil), String)
