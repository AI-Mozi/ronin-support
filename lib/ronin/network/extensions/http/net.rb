#
# Ronin - A Ruby platform for exploit development and security research.
#
# Copyright (c) 2006-2010 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor,
# Boston, MA  02110-1301  USA
#

require 'ronin/network/http'
require 'ronin/network/ssl'

require 'uri/query_params'
require 'net/http'

begin
  require 'net/https'
rescue ::LoadError
end

module Net
  #
  # Starts a HTTP connection with the server.
  #
  # @param [Hash] options
  #   Additional options
  #
  # @option options [String, URI::HTTP] :url
  #   The full URL to request.
  #
  # @option options [String] :host
  #   The host the HTTP server is running on.
  #
  # @option options [Integer] :port (Net::HTTP.default_port)
  #   The port the HTTP server is listening on.
  #
  # @option options [String, Hash] :proxy (Ronin::Network::HTTP.proxy)
  #   A Hash of proxy settings to use when connecting to the HTTP server.
  #
  # @option options [String] :user
  #   The user to authenticate with when connecting to the HTTP server.
  #
  # @option options [String] :password
  #   The password to authenticate with when connecting to the HTTP server.
  #
  # @option options [Boolean, Hash] :ssl
  #   Enables SSL for the HTTP connection.
  #
  # @option :ssl [Symbol] :verify
  #   Specifies the SSL certificate verification mode.
  #   
  # @yield [session]
  #   If a block is given, it will be passed the newly created HTTP
  #   session object.
  #
  # @yieldparam [Net::HTTP] session
  #   The newly created HTTP session.
  #
  # @return [Net::HTTP]
  #   The HTTP session object.
  #
  def Net.http_connect(options={},&block)
    options = Ronin::Network::HTTP.expand_options(options)

    host = options[:host]
    port = options[:port]
    proxy = options[:proxy]

    sess = Net::HTTP::Proxy(
      proxy[:host],
      proxy[:port],
      proxy[:user],
      proxy[:password]
    ).new(host,port)

    if options[:ssl]
      sess.use_ssl = true
      sess.verify_mode = Ronin::Network::SSL.verify(options[:ssl][:verify])
    end

    sess.start()

    if block
      if block.arity == 2
        block.call(sess,options)
      else
        block.call(sess)
      end
    end

    return sess
  end

  #
  # Creates a new temporary HTTP session with the server.
  #
  # @param [Hash] options
  #   Additional options
  #
  # @option options [String, URI::HTTP] :url
  #   The full URL to request.
  #
  # @option options [String] :host
  #   The host the HTTP server is running on.
  #
  # @option options [Integer] :port (Net::HTTP.default_port)
  #   The port the HTTP server is listening on.
  #
  # @option options [String] :user
  #   The user to authenticate with when connecting to the HTTP server.
  #
  # @option options [String] :password
  #   The password to authenticate with when connecting to the HTTP server.
  #
  # @option options [String, Hash] :proxy (Ronin::Network::HTTP.proxy)
  #   A Hash of proxy settings to use when connecting to the HTTP server.
  #
  # @option options [Boolean, Hash] :ssl
  #   Enables SSL for the HTTP connection.
  #
  # @option :ssl [Symbol] :verify
  #   Specifies the SSL certificate verification mode.
  #   
  # @yield [session]
  #   If a block is given, it will be passed the newly created HTTP
  #   session object.
  #
  # @yieldparam [Net::HTTP] session
  #   The newly created HTTP session.
  #
  # @return [nil]
  #
  # @see Net.http_connect
  #
  def Net.http_session(options={},&block)
    Net.http_connect(options) do |sess,expanded_options|
      if block
        if block.arity == 2
          block.call(sess,expanded_options)
        else
          block.call(sess)
        end
      end

      sess.finish
    end

    return nil
  end

  #
  # Connects to the HTTP server and sends an HTTP Request.
  #
  # @param [Hash] options
  #   Additional options.
  #
  # @option options [Symbol, String] :method
  #   The HTTP method to use in the request.
  #
  # @option options [String] :path
  #   The path to request from the HTTP server.
  #
  # @option options [Hash] :headers
  #   The Hash of the HTTP headers to send with the request.
  #   May contain either Strings or Symbols, lower-case or camel-case keys.
  #
  # @yield [request, (options)]
  #   If a block is given, it will be passed the HTTP request object.
  #   If the block has an arity of 2, it will also be passed the expanded
  #   version of the given _options_.
  #
  # @yieldparam [Net::HTTP::Request] request
  #   The HTTP request object to use in the request.
  #
  # @yieldparam [Hash] options
  #   The expanded version of the given _options_.
  #
  # @return [Net::HTTP::Response]
  #   The response of the HTTP request.
  #
  # @see http_session
  #
  def Net.http_request(options={},&block)
    resp = nil

    Net.http_session(options) do |http,expanded_options|
      http_body = expanded_options.delete(:body)

      req = Ronin::Network::HTTP.request(expanded_options)

      if block
        if block.arity == 2
          block.call(req,expanded_options)
        else
          block.call(req)
        end
      end

      resp = http.request(req,http_body)
    end

    return resp
  end

  #
  # Performs an HTTP Copy request.
  #
  # @param [Hash] options
  #   Additional options.
  #
  # @yield [response]
  #   If a block is given, it will be passed the response received
  #   from the request.
  #
  # @yieldparam [Net::HTTP::Response] response
  #   The HTTP response object.
  #
  # @return [Net::HTTP::Response]
  #   The response of the HTTP request.
  #
  # @see http_request
  #
  def Net.http_copy(options={})
    resp = Net.http_request(options.merge(:method => :copy))

    yield resp if block_given?
    return resp
  end

  #
  # Performs an HTTP Delete request.
  #
  # @param [Hash] options
  #   Additional options.
  #
  # @yield [response]
  #   If a block is given, it will be passed the response received from
  #   the request.
  #
  # @yieldparam [Net::HTTP::Response] response
  #   The HTTP response object.
  #
  # @return [Net::HTTP::Response]
  #   The response of the HTTP request.
  #
  # @see http_request
  #
  def Net.http_delete(options={},&block)
    original_headers = options[:headers]

    # set the HTTP Depth header
    options[:headers] = {:depth => 'Infinity'}

    if original_headers
      options[:header].merge!(original_headers)
    end

    resp = Net.http_request(options.merge(:method => :delete))

    yield resp if block_given?
    return resp
  end

  #
  # Performs an HTTP Get request.
  #
  # @param [Hash] options
  #   Additional options.
  #
  # @yield [response]
  #   If a block is given, it will be passed the response received from
  #   the request.
  #
  # @yieldparam [Net::HTTP::Response] response
  #   The HTTP response object.
  #
  # @return [Net::HTTP::Response]
  #   The response of the HTTP request.
  #
  # @see http_request
  #
  def Net.http_get(options={},&block)
    resp = Net.http_request(options.merge(:method => :get))

    yield resp if block_given?
    return resp
  end

  #
  # Performs an HTTP Get request.
  #
  # @param [Hash] options
  #   Additional options.
  #
  # @yield [response]
  #   If a block is given, it will be passed the response received from
  #   the request.
  #
  # @yieldparam [Net::HTTP::Response] response
  #   The HTTP response object.
  #
  # @return [String]
  #   The body of the HTTP response.
  #
  # @see http_request
  #
  def Net.http_get_body(options={},&block)
    Net.http_get(options,&block).body
  end

  #
  # Performs an HTTP Head request.
  #
  # @param [Hash] options
  #   Additional options.
  #
  # @yield [response]
  #   If a block is given, it will be passed the response received from
  #   the request.
  #
  # @yieldparam [Net::HTTP::Response] response
  #   The HTTP response object.
  #
  # @return [Net::HTTP::Response]
  #   The response of the HTTP request.
  #
  # @see http_request
  #
  def Net.http_head(options={},&block)
    resp = Net.http_request(options.merge(:method => :head))

    yield resp if block_given?
    return resp
  end

  #
  # Checks if the response has an HTTP OK status code.
  #
  # @param [Hash] options
  #   Additional options.
  #
  # @return [Boolean]
  #   Specifies wether the response had an HTTP OK status code or not.
  #
  # @see http_request
  #
  def Net.http_ok?(options={})
    Net.http_head(options).code == 200
  end

  #
  # Sends a HTTP Head request and returns the HTTP Server header.
  #
  # @param [Hash] options
  #   Additional options.
  #
  # @return [String]
  #   The HTTP `Server` header.
  #
  # @see http_request
  #
  def Net.http_server(options={})
    Net.http_head(options)['server']
  end

  #
  # Sends an HTTP Head request and returns the HTTP X-Powered-By header.
  #
  # @param [Hash] options
  #   Additional options.
  #
  # @return [String]
  #   The HTTP `X-Powered-By` header.
  #
  # @see http_request
  #
  def Net.http_powered_by(options={})
    resp = Net.http_head(options)

    if resp.code != 200
      resp = Net.http_get(options)
    end

    return resp['x-powered-by']
  end

  #
  # Performs an HTTP Lock request.
  #
  # @param [Hash] options
  #   Additional options.
  #
  # @yield [response]
  #   If a block is given, it will be passed the response received from
  #   the request.
  #
  # @yieldparam [Net::HTTP::Response] response
  #   The HTTP response object.
  #
  # @return [Net::HTTP::Response]
  #   The response of the HTTP request.
  #
  # @see http_request
  #
  def Net.http_lock(options={},&block)
    resp = Net.http_request(options.merge(:method => :lock))

    yield resp if block_given?
    return resp
  end

  #
  # Performs an HTTP Mkcol request.
  #
  # @param [Hash] options
  #   Additional options.
  #
  # @yield [response]
  #   If a block is given, it will be passed the response received from
  #   the request.
  #
  # @yieldparam [Net::HTTP::Response] response
  #   The HTTP response object.
  #
  # @return [Net::HTTP::Response]
  #   The response of the HTTP request.
  #
  # @see http_request
  #
  def Net.http_mkcol(options={},&block)
    resp = Net.http_request(options.merge(:method => :mkcol))

    yield resp if block_given?
    return resp
  end

  #
  # Performs an HTTP Move request.
  #
  # @param [Hash] options
  #   Additional options.
  #
  # @yield [response]
  #   If a block is given, it will be passed the response received from
  #   the request.
  #
  # @yieldparam [Net::HTTP::Response] response
  #   The HTTP response object.
  #
  # @return [Net::HTTP::Response]
  #   The response of the HTTP request.
  #
  # @see http_request
  #
  def Net.http_move(options={},&block)
    resp = Net.http_request(options.merge(:method => :move))

    yield resp if block_given?
    return resp
  end

  #
  # Performs an HTTP Options request.
  #
  # @param [Hash] options
  #   Additional options.
  #
  # @yield [response]
  #   If a block is given, it will be passed the response received from
  #   the request.
  #
  # @yieldparam [Net::HTTP::Response] response
  #   The HTTP response object.
  #
  # @return [Net::HTTP::Response]
  #   The response of the HTTP request.
  #
  # @see http_request
  #
  def Net.http_options(options={},&block)
    resp = Net.http_request(options.merge(:method => :options))

    yield resp if block_given?
    return resp
  end

  #
  # Performs an HTTP Post request.
  #
  # @param [Hash] options
  #   Additional options.
  #
  # @option options [Hash, String] :form_data
  #   The form data to send with the HTTP Post request.
  #
  # @yield [response]
  #   If a block is given, it will be passed the response received from
  #   the request.
  #
  # @yieldparam [Net::HTTP::Response] response
  #   The HTTP response object.
  #
  # @return [Net::HTTP::Response]
  #   The response of the HTTP request.
  #
  # @see http_request
  #
  def Net.http_post(options={},&block)
    resp = Net.http_request(options.merge(:method => :post))

    yield resp if block_given?
    return resp
  end

  #
  # Performs an HTTP Post request.
  #
  # @param [Hash] options
  #   Additional options.
  #
  # @option options [Hash, String] :form_data
  #   The form data to send with the HTTP Post request.
  #
  # @yield [response]
  #   If a block is given, it will be passed the response received from
  #   the request.
  #
  # @yieldparam [Net::HTTP::Response] response
  #   The HTTP response object.
  #
  # @return [String]
  #   The body of the HTTP response.
  #
  # @see http_request
  #
  def Net.http_post_body(options={},&block)
    Net.http_post(options,&block).body
  end

  #
  # Performs an HTTP Propfind request.
  #
  # @param [Hash] options
  #   Additional options.
  #
  # @yield [response]
  #   If a block is given, it will be passed the response received from
  #   the request.
  #
  # @yieldparam [Net::HTTP::Response] response
  #   The HTTP response object.
  #
  # @return [Net::HTTP::Response]
  #   The response of the HTTP request.
  #
  # @see http_request
  #
  def Net.http_prop_find(options={},&block)
    original_headers = options[:headers]

    # set the HTTP Depth header
    options[:headers] = {:depth => '0'}

    if original_headers
      options[:header].merge!(original_headers)
    end

    resp = Net.http_request(options.merge(:method => :propfind))

    yield resp if block_given?
    return resp
  end

  #
  # Performs an HTTP Proppatch request.
  #
  # @param [Hash] options
  #   Additional options.
  #
  # @yield [response]
  #   If a block is given, it will be passed the response received from
  #   the request.
  #
  # @yieldparam [Net::HTTP::Response] response
  #   The HTTP response object.
  #
  # @return [Net::HTTP::Response]
  #   The response of the HTTP request.
  #
  # @see http_request
  #
  def Net.http_prop_patch(options={},&block)
    resp = Net.http_request(options.merge(:method => :proppatch))

    yield resp if block_given?
    return resp
  end

  #
  # Performs an HTTP Trace request.
  #
  # @param [Hash] options
  #   Additional options.
  #
  # @yield [response]
  #   If a block is given, it will be passed the response received from
  #   the request.
  #
  # @yieldparam [Net::HTTP::Response] response
  #   The HTTP response object.
  #
  # @return [Net::HTTP::Response]
  #   The response of the HTTP request.
  #
  # @see http_request
  #
  def Net.http_trace(options={},&block)
    resp = Net.http_request(options.merge(:method => :trace))

    yield resp if block_given?
    return resp
  end

  #
  # Performs an HTTP Unlock request.
  #
  # @param [Hash] options
  #   Additional options.
  #
  # @yield [response]
  #   If a block is given, it will be passed the response received from
  #   the request.
  #
  # @yieldparam [Net::HTTP::Response] response
  #   The HTTP response object.
  #
  # @return [Net::HTTP::Response]
  #   The response of the HTTP request.
  #
  # @see http_request
  #
  def Net.http_unlock(options={},&block)
    resp = Net.http_request(options.merge(:method => :unlock))

    yield resp if block_given?
    return resp
  end
end
