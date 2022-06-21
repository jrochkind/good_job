# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `async-http` gem.
# Please instead update this file by running `bin/tapioca gem async-http`.

module Async
  extend ::Console

  class << self
    # Invoke `Reactor.run` with all arguments/block.
    def run(*arguments, &block); end
  end
end

module Async::HTTP; end

module Async::HTTP::Body
  include ::Protocol::HTTP::Body
end

class Async::HTTP::Body::Pipe
  # If the input stream is closed first, it's likely the output stream will also be closed.
  #
  # @return [Pipe] a new instance of Pipe
  def initialize(input, output = T.unsafe(nil), task: T.unsafe(nil)); end

  def close; end
  def to_io; end

  private

  def close_head; end

  # Read from the @input stream and write to the head of the pipe.
  def reader(task); end

  # Read from the head of the pipe and write to the @output stream.
  # If the @tail is closed, this will cause chunk to be nil, which in turn will call `@output.close` and `@head.close`
  def writer(task); end
end

# The input stream is an IO-like object which contains the raw HTTP POST data. When applicable, its external encoding must be “ASCII-8BIT” and it must be opened in binary mode, for Ruby 1.9 compatibility. The input stream must respond to gets, each, read and rewind.
class Async::HTTP::Body::Stream
  # @raise [ArgumentError]
  # @return [Stream] a new instance of Stream
  def initialize(input, output = T.unsafe(nil)); end

  # Close the input and output bodies.
  def close(error = T.unsafe(nil)); end

  def close_read; end
  def close_write; end

  # Whether the stream has been closed.
  #
  # @return [Boolean]
  def closed?; end

  # Whether there are any output chunks remaining?
  #
  # @return [Boolean]
  def empty?; end

  def flush; end

  # Returns the value of attribute input.
  def input; end

  # Returns the value of attribute output.
  def output; end

  # read behaves like IO#read. Its signature is read([length, [buffer]]). If given, length must be a non-negative Integer (>= 0) or nil, and buffer must be a String and may not be nil. If length is given and not nil, then this method reads at most length bytes from the input stream. If length is not given or nil, then this method reads all data until EOF. When EOF is reached, this method returns nil if length is given and not nil, or “” if length is not given or is nil. If buffer is given, then the read data will be placed into buffer instead of a newly created String object.
  #
  # @param length [Integer] the amount of data to read
  # @param buffer [String] the buffer which will receive the data
  # @return a buffer containing the data
  def read(size = T.unsafe(nil), buffer = T.unsafe(nil)); end

  def read_nonblock(length, buffer = T.unsafe(nil)); end

  # Read at most `size` bytes from the stream. Will avoid reading from the underlying stream if possible.
  def read_partial(size = T.unsafe(nil)); end

  def write(buffer); end
  def write_nonblock(buffer); end

  private

  def read_next; end
end

# A dynamic body which you can write to and read from.
class Async::HTTP::Body::Writable < ::Protocol::HTTP::Body::Readable
  # @param length [Integer] The length of the response body if known.
  # @param queue [Async::Queue] Specify a different queue implementation, e.g. `Async::LimitedQueue.new(8)` to enable back-pressure streaming.
  # @return [Writable] a new instance of Writable
  def initialize(length = T.unsafe(nil), queue: T.unsafe(nil)); end

  # Write a single chunk to the body. Signal completion by calling `#finish`.
  def <<(chunk); end

  # Stop generating output; cause the next call to write to fail with the given error.
  def close(error = T.unsafe(nil)); end

  # @return [Boolean]
  def closed?; end

  # Has the producer called #finish and has the reader consumed the nil token?
  #
  # @return [Boolean]
  def empty?; end

  def inspect; end
  def length; end

  # Read the next available chunk.
  def read; end

  # @return [Boolean]
  def ready?; end

  # Write a single chunk to the body. Signal completion by calling `#finish`.
  def write(chunk); end

  private

  def status; end
end

class Async::HTTP::Body::Writable::Closed < ::StandardError; end

class Async::HTTP::Client < ::Protocol::HTTP::Methods
  include ::Async::HTTP::Proxy::Client

  # Provides a robust interface to a server.
  # * If there are no connections, it will create one.
  # * If there are already connections, it will reuse it.
  # * If a request fails, it will retry it up to N times if it was idempotent.
  # The client object will never become unusable. It internally manages persistent connections (or non-persistent connections if that's required).
  #
  # @param endpoint [Endpoint] the endpoint to connnect to.
  # @param protocol [Protocol::HTTP1 | Protocol::HTTP2 | Protocol::HTTPS] the protocol to use.
  # @param scheme [String] The default scheme to set to requests.
  # @param authority [String] The default authority to set to requests.
  # @return [Client] a new instance of Client
  def initialize(endpoint, protocol: T.unsafe(nil), scheme: T.unsafe(nil), authority: T.unsafe(nil), retries: T.unsafe(nil), connection_limit: T.unsafe(nil)); end

  # Returns the value of attribute authority.
  def authority; end

  def call(request); end
  def close; end

  # Returns the value of attribute endpoint.
  def endpoint; end

  # Returns the value of attribute pool.
  def pool; end

  # Returns the value of attribute protocol.
  def protocol; end

  # Returns the value of attribute retries.
  def retries; end

  # Returns the value of attribute scheme.
  def scheme; end

  # @return [Boolean]
  def secure?; end

  protected

  def make_pool(connection_limit); end
  def make_response(request, connection); end

  class << self
    def open(*arguments, **options, &block); end
  end
end

Async::HTTP::DEFAULT_RETRIES = T.let(T.unsafe(nil), Integer)

# Represents a way to connect to a remote HTTP server.
class Async::HTTP::Endpoint < ::Async::IO::Endpoint
  # @option hostname
  # @option scheme
  # @option port
  # @option ssl_context
  # @option alpn_protocols
  # @param hostname [Hash] a customizable set of options
  # @param scheme [Hash] a customizable set of options
  # @param port [Hash] a customizable set of options
  # @param ssl_context [Hash] a customizable set of options
  # @param alpn_protocols [Hash] a customizable set of options
  # @raise [ArgumentError]
  # @return [Endpoint] a new instance of Endpoint
  def initialize(url, endpoint = T.unsafe(nil), **options); end

  def address; end
  def alpn_protocols; end
  def authority(ignore_default_port = T.unsafe(nil)); end
  def bind(*arguments, &block); end
  def build_endpoint(endpoint = T.unsafe(nil)); end
  def connect(&block); end
  def default_port; end

  # @return [Boolean]
  def default_port?; end

  def each; end
  def endpoint; end

  # @return [Boolean]
  def eql?(other); end

  def hash; end

  # The hostname is the server we are connecting to:
  def hostname; end

  def inspect; end
  def key; end

  # @return [Boolean]
  def localhost?; end

  # Return the path and query components of the given URL.
  def path; end

  def port; end
  def protocol; end
  def scheme; end

  # @return [Boolean]
  def secure?; end

  def ssl_context; end

  # We don't try to validate peer certificates when talking to localhost because they would always be self-signed.
  def ssl_verify_mode; end

  def to_s; end
  def to_url; end

  # Returns the value of attribute url.
  def url; end

  protected

  def tcp_endpoint; end
  def tcp_options; end

  class << self
    # Construct an endpoint with a specified scheme, hostname, and options.
    def for(scheme, hostname, **options); end

    def parse(string, endpoint = T.unsafe(nil), **options); end
  end
end

# A protocol specifies a way in which to communicate with a remote peer.
module Async::HTTP::Protocol; end

module Async::HTTP::Protocol::HTTP1
  class << self
    # @return [Boolean]
    def bidirectional?; end

    def client(peer); end
    def names; end
    def server(peer); end

    # @return [Boolean]
    def trailer?; end
  end
end

module Async::HTTP::Protocol::HTTP10
  class << self
    # @return [Boolean]
    def bidirectional?; end

    def client(peer); end
    def names; end
    def server(peer); end

    # @return [Boolean]
    def trailer?; end
  end
end

Async::HTTP::Protocol::HTTP10::VERSION = T.let(T.unsafe(nil), String)

module Async::HTTP::Protocol::HTTP11
  class << self
    # @return [Boolean]
    def bidirectional?; end

    def client(peer); end
    def names; end
    def server(peer); end

    # @return [Boolean]
    def trailer?; end
  end
end

Async::HTTP::Protocol::HTTP11::VERSION = T.let(T.unsafe(nil), String)

class Async::HTTP::Protocol::HTTP1::Client < ::Async::HTTP::Protocol::HTTP1::Connection
  # Used by the client to send requests to the remote server.
  def call(request, task: T.unsafe(nil)); end
end

class Async::HTTP::Protocol::HTTP1::Connection < ::Protocol::HTTP1::Connection
  # @return [Connection] a new instance of Connection
  def initialize(stream, version); end

  def concurrency; end

  # Returns the value of attribute count.
  def count; end

  # @return [Boolean]
  def http1?; end

  # @return [Boolean]
  def http2?; end

  def peer; end
  def read_line; end

  # @return [Boolean]
  def read_line?; end

  # @return [Boolean]
  def reusable?; end

  # Returns the value of attribute version.
  def version; end

  # Can we use this connection to make requests?
  #
  # @return [Boolean]
  def viable?; end
end

class Async::HTTP::Protocol::HTTP1::Request < ::Async::HTTP::Protocol::Request
  # @return [Request] a new instance of Request
  def initialize(connection, authority, method, path, version, headers, body); end

  def connection; end
  def hijack!; end

  # @return [Boolean]
  def hijack?; end

  class << self
    def read(connection); end
  end
end

class Async::HTTP::Protocol::HTTP1::Response < ::Async::HTTP::Protocol::Response
  # @param reason [String] HTTP response line reason, ignored.
  # @return [Response] a new instance of Response
  def initialize(connection, version, status, reason, headers, body); end

  def connection; end
  def hijack!; end

  # @return [Boolean]
  def hijack?; end

  class << self
    def read(connection, request); end
  end
end

class Async::HTTP::Protocol::HTTP1::Server < ::Async::HTTP::Protocol::HTTP1::Connection
  # Server loop.
  def each(task: T.unsafe(nil)); end

  def fail_request(status); end
  def next_request; end
end

Async::HTTP::Protocol::HTTP1::VERSION = T.let(T.unsafe(nil), String)

module Async::HTTP::Protocol::HTTP2
  class << self
    # @return [Boolean]
    def bidirectional?; end

    def client(peer, settings = T.unsafe(nil)); end
    def names; end
    def server(peer, settings = T.unsafe(nil)); end

    # @return [Boolean]
    def trailer?; end
  end
end

Async::HTTP::Protocol::HTTP2::AUTHORITY = T.let(T.unsafe(nil), String)
Async::HTTP::Protocol::HTTP2::CLIENT_SETTINGS = T.let(T.unsafe(nil), Hash)
Async::HTTP::Protocol::HTTP2::CONNECTION = T.let(T.unsafe(nil), String)
Async::HTTP::Protocol::HTTP2::CONTENT_LENGTH = T.let(T.unsafe(nil), String)

class Async::HTTP::Protocol::HTTP2::Client < ::Protocol::HTTP2::Client
  include ::Async::HTTP::Protocol::HTTP2::Connection

  # @return [Client] a new instance of Client
  def initialize(stream); end

  # Used by the client to send requests to the remote server.
  #
  # @raise [::Protocol::HTTP2::Error]
  def call(request); end

  def create_response; end
end

module Async::HTTP::Protocol::HTTP2::Connection
  def initialize(*_arg0); end

  def close(error = T.unsafe(nil)); end
  def concurrency; end

  # Returns the value of attribute count.
  def count; end

  # @return [Boolean]
  def http1?; end

  # @return [Boolean]
  def http2?; end

  def peer; end

  # Returns the value of attribute promises.
  def promises; end

  # @raise [RuntimeError]
  def read_in_background(parent: T.unsafe(nil)); end

  # @return [Boolean]
  def reusable?; end

  def start_connection; end

  # Returns the value of attribute stream.
  def stream; end

  def to_s; end
  def version; end

  # Can we use this connection to make requests?
  #
  # @return [Boolean]
  def viable?; end

  def write_frame(frame); end
  def write_frames(&block); end
end

Async::HTTP::Protocol::HTTP2::HTTPS = T.let(T.unsafe(nil), String)

# A writable body which requests window updates when data is read from it.
class Async::HTTP::Protocol::HTTP2::Input < ::Async::HTTP::Body::Writable
  # @return [Input] a new instance of Input
  def initialize(stream, length); end

  def read; end
end

Async::HTTP::Protocol::HTTP2::METHOD = T.let(T.unsafe(nil), String)

class Async::HTTP::Protocol::HTTP2::Output
  # @return [Output] a new instance of Output
  def initialize(stream, body, trailer = T.unsafe(nil)); end

  # This method should only be called from within the context of the output task.
  def close(error = T.unsafe(nil)); end

  def start(parent: T.unsafe(nil)); end

  # This method should only be called from within the context of the HTTP/2 stream.
  def stop(error); end

  # Returns the value of attribute trailer.
  def trailer; end

  def window_updated(size); end
  def write(chunk); end

  private

  # Reads chunks from the given body and writes them to the stream as fast as possible.
  def passthrough(task); end

  # Send `maximum_size` bytes of data using the specified `stream`. If the buffer has no more chunks, `END_STREAM` will be sent on the final chunk.
  #
  # @param maximum_size [Integer] send up to this many bytes of data.
  # @param stream [Stream] the stream to use for sending data frames.
  # @return [String, nil] any data that could not be written.
  def send_data(chunk, maximum_size); end

  def stream(task); end
end

Async::HTTP::Protocol::HTTP2::PATH = T.let(T.unsafe(nil), String)
Async::HTTP::Protocol::HTTP2::PROTOCOL = T.let(T.unsafe(nil), String)

# Typically used on the server side to represent an incoming request, and write the response.
class Async::HTTP::Protocol::HTTP2::Request < ::Async::HTTP::Protocol::Request
  # @return [Request] a new instance of Request
  def initialize(stream); end

  def connection; end

  # @return [Boolean]
  def hijack?; end

  def send_response(response); end

  # Returns the value of attribute stream.
  def stream; end

  # @return [Boolean]
  def valid?; end
end

Async::HTTP::Protocol::HTTP2::Request::NO_RESPONSE = T.let(T.unsafe(nil), Array)

class Async::HTTP::Protocol::HTTP2::Request::Stream < ::Async::HTTP::Protocol::HTTP2::Stream
  # @return [Stream] a new instance of Stream
  def initialize(*_arg0); end

  def closed(error); end
  def receive_initial_headers(headers, end_stream); end

  # Returns the value of attribute request.
  def request; end
end

# Typically used on the client side for writing a request and reading the incoming response.
class Async::HTTP::Protocol::HTTP2::Response < ::Async::HTTP::Protocol::Response
  # @return [Response] a new instance of Response
  def initialize(stream); end

  def build_request(headers); end
  def connection; end

  # @return [Boolean]
  def head?; end

  # Returns the value of attribute request.
  def request; end

  # Send a request and read it into this response.
  def send_request(request); end

  # Returns the value of attribute stream.
  def stream; end

  # @return [Boolean]
  def valid?; end

  def wait; end
end

class Async::HTTP::Protocol::HTTP2::Response::Stream < ::Async::HTTP::Protocol::HTTP2::Stream
  # @return [Stream] a new instance of Stream
  def initialize(*_arg0); end

  # @raise [ProtocolError]
  def accept_push_promise_stream(promised_stream_id, headers); end

  def closed(error); end

  # Notify anyone waiting on the response headers to be received (or failure).
  def notify!; end

  # This should be invoked from the background reader, and notifies the task waiting for the headers that we are done.
  def receive_initial_headers(headers, end_stream); end

  # Returns the value of attribute response.
  def response; end

  # Wait for the headers to be received or for stream reset.
  def wait; end

  def wait_for_input; end
end

Async::HTTP::Protocol::HTTP2::SCHEME = T.let(T.unsafe(nil), String)
Async::HTTP::Protocol::HTTP2::SERVER_SETTINGS = T.let(T.unsafe(nil), Hash)
Async::HTTP::Protocol::HTTP2::STATUS = T.let(T.unsafe(nil), String)

class Async::HTTP::Protocol::HTTP2::Server < ::Protocol::HTTP2::Server
  include ::Async::HTTP::Protocol::HTTP2::Connection

  # @return [Server] a new instance of Server
  def initialize(stream); end

  def accept_stream(stream_id); end
  def close(error = T.unsafe(nil)); end
  def each(task: T.unsafe(nil)); end

  # Returns the value of attribute requests.
  def requests; end
end

class Async::HTTP::Protocol::HTTP2::Stream < ::Protocol::HTTP2::Stream
  # @return [Stream] a new instance of Stream
  def initialize(*_arg0); end

  def add_header(key, value); end

  # When the stream transitions to the closed state, this method is called. There are roughly two ways this can happen:
  # - A frame is received which causes this stream to enter the closed state. This method will be invoked from the background reader task.
  # - A frame is sent which causes this stream to enter the closed state. This method will be invoked from that task.
  # While the input stream is relatively straight forward, the output stream can trigger the second case above
  def closed(error); end

  # Called when the output terminates normally.
  def finish_output(error = T.unsafe(nil)); end

  # Returns the value of attribute headers.
  def headers; end

  # Sets the attribute headers
  #
  # @param value the value to set the attribute headers to.
  def headers=(_arg0); end

  # Returns the value of attribute input.
  def input; end

  # Prepare the input stream which will be used for incoming data frames.
  #
  # @return [Input] the input body.
  def prepare_input(length); end

  def process_data(frame); end
  def process_headers(frame); end
  def receive_trailing_headers(headers, end_stream); end

  # Set the body and begin sending it.
  def send_body(body, trailer = T.unsafe(nil)); end

  def update_local_window(frame); end
  def wait_for_input; end
  def window_updated(size); end
end

Async::HTTP::Protocol::HTTP2::TRAILER = T.let(T.unsafe(nil), String)
Async::HTTP::Protocol::HTTP2::VERSION = T.let(T.unsafe(nil), String)

# A server that supports both HTTP1.0 and HTTP1.1 semantics by detecting the version of the request.
module Async::HTTP::Protocol::HTTPS
  class << self
    def client(peer); end

    # Supported Application Layer Protocol Negotiation names:
    def names; end

    def protocol_for(peer); end
    def server(peer); end
  end
end

Async::HTTP::Protocol::HTTPS::HANDLERS = T.let(T.unsafe(nil), Hash)

# This is generated by server protocols.
class Async::HTTP::Protocol::Request < ::Protocol::HTTP::Request
  def connection; end

  # @return [Boolean]
  def hijack?; end

  def peer; end
  def remote_address; end
  def remote_address=(value); end
end

# Failed to send the request. The request body has NOT been consumed (i.e. #read) and you should retry the request.
class Async::HTTP::Protocol::RequestFailed < ::StandardError; end

# This is generated by client protocols.
class Async::HTTP::Protocol::Response < ::Protocol::HTTP::Response
  def connection; end

  # @return [Boolean]
  def hijack?; end

  def peer; end
  def remote_address; end
  def remote_address=(value); end
end

# Wraps a client, address and headers required to initiate a connectio to a remote host using the CONNECT verb.
# Behaves like a TCP endpoint for the purposes of connecting to a remote host.
class Async::HTTP::Proxy
  # @param client [Async::HTTP::Client] the client which will be used as a proxy server.
  # @param address [String] the address to connect to.
  # @param headers [Array] an optional list of headers to use when establishing the connection.
  # @return [Proxy] a new instance of Proxy
  def initialize(client, address, headers = T.unsafe(nil)); end

  # Returns the value of attribute client.
  def client; end

  # Close the underlying client connection.
  def close; end

  # Establish a TCP connection to the specified host.
  #
  # @return [Socket] a connected bi-directional socket.
  def connect(&block); end

  # @return [Async::HTTP::Endpoint] an endpoint that connects via the specified proxy.
  def wrap_endpoint(endpoint); end

  class << self
    # Construct a endpoint that will use the given client as a proxy for HTTP requests.
    #
    # @param client [Async::HTTP::Client] the client which will be used as a proxy server.
    # @param endpoint [Async::HTTP::Endpoint] the endpoint to connect to.
    # @param headers [Array] an optional list of headers to use when establishing the connection.
    def endpoint(client, endpoint, headers = T.unsafe(nil)); end

    # Prepare and endpoint which can establish a TCP connection to the remote system.
    #
    # @param client [Async::HTTP::Client] the client which will be used as a proxy server.
    # @param host [String] the hostname or address to connect to.
    # @param port [String] the port number to connect to.
    # @param headers [Array] an optional list of headers to use when establishing the connection.
    # @see Async::IO::Endpoint#tcp
    def tcp(client, host, port, headers = T.unsafe(nil)); end
  end
end

module Async::HTTP::Proxy::Client
  # Create a client that will proxy requests through the current client.
  def proxied_client(endpoint, headers = T.unsafe(nil)); end

  def proxied_endpoint(endpoint, headers = T.unsafe(nil)); end
  def proxy(endpoint, headers = T.unsafe(nil)); end
end

class Async::HTTP::Proxy::ConnectFailure < ::StandardError
  # @return [ConnectFailure] a new instance of ConnectFailure
  def initialize(response); end

  # Returns the value of attribute response.
  def response; end
end

Async::VERSION = T.let(T.unsafe(nil), String)
