#
# Copyright (c) 2006-2011 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# This file is part of Ronin Support.
#
# Ronin Support is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Ronin Support is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with Ronin Support.  If not, see <http://www.gnu.org/licenses/>.
#

require 'ronin/network/telnet'

require 'net/telnet'

module Net
  #
  # Creates a new Telnet connection.
  #
  # @param [String] host
  #   The host to connect to.
  #
  # @param [Hash] options
  #   Additional options.
  #
  # @option options [Integer] :port (Ronin::Network::Telnet.default_port)
  #   The port to connect to.
  #
  # @option options [Boolean] :binmode
  #   Indicates that newline substitution shall not be performed.
  #
  # @option options [String] :output_log
  #   The name of the file to write connection status messages and all
  #   received traffic to.
  #
  # @option options [String] :dump_log
  #   Similar to the `:output_log` option, but connection output is also
  #   written in hexdump format.
  #
  # @option options [Regexp] :prompt (Ronin::Network::Telnet.default_prompt)
  #   A regular expression matching the host command-line prompt sequence,
  #   used to determine when a command has finished.
  #
  # @option options [Boolean] :telnet (true)
  #   Indicates that the connection shall behave as a telnet connection.
  #
  # @option options [Boolean] :plain
  #   Indicates that the connection shall behave as a normal TCP
  #   connection.
  #
  # @option options [Integer] :timeout (Ronin::Network::Telnet.default_timeout)
  #   The number of seconds to wait before timing out both the initial
  #   attempt to connect to host, and all attempts to read data from the
  #   host.
  #
  # @option options [Integer] :wait_time
  #   The amount of time to wait after seeing what looks like a prompt.
  #
  # @option options [Net::Telnet, IO] :proxy (Ronin::Network::Telnet.proxy)
  #   A proxy object to used instead of opening a direct connection to the
  #   host.
  #
  # @option options [String] :user
  #   The user to login as.
  #
  # @option options [String] :password
  #   The password to login with.
  #
  # @yield [session]
  #   If a block is given, it will be passed the newly created Telnet
  #   session.
  #
  # @yieldparam [Net::Telnet] session
  #   The newly created Telnet session.
  #
  # @return [Net::Telnet]
  #   The Telnet session
  #
  # @example
  #   Net.telnet_connect('towel.blinkenlights.nl')
  #   # => #<Net::Telnet: ...>
  #
  def Net.telnet_connect(host,options={})
    host = host.to_s
    telnet_options = {}

    telnet_options['Host'] = host
    telnet_options['Port'] = (options[:port] || Ronin::Network::Telnet.default_port)
    telnet_options['Binmode'] = options[:binmode]
    telnet_options['Output_log'] = options[:output_log]
    telnet_options['Dump_log'] = options[:dump_log]
    telnet_options['Prompt'] = (options[:prompt] || Ronin::Network::Telnet.default_prompt)

    if (options[:telnet] && !options[:plain])
      telnet_options['Telnetmode'] = true
    end

    telnet_options['Timeout'] = (options[:timeout] || Ronin::Network::Telnet.default_timeout)
    telnet_options['Waittime'] = options[:wait_time]
    telnet_options['Proxy'] = (options[:proxy] || Ronin::Network::Telnet.proxy)

    user = options[:user]
    passwd = options[:passwd]

    session = Net::Telnet.new(telnet_options)
    session.login(user,passwd) if user

    yield session if block_given?
    return session
  end

  #
  # Starts a new Telnet session.
  #
  # @param [String] host
  #   The host to connect to.
  #
  # @param [Hash] options
  #   Additional options.
  #
  # @yield [session]
  #   If a block is given, it will be passed the newly created
  #   Telnet session. After the block has returned, the Telnet session
  #   will be closed.
  #
  # @yieldparam [Net::Telnet] session
  #   The newly created Telnet session.
  #
  # @return [nil]
  #
  # @example
  #   Net.telnet_session('towel.blinkenlights.nl') do |movie|
  #     movie.each_line { |line| puts line }
  #   end
  #
  # @see Net.telnet_session
  #
  def Net.telnet_session(host,options={})
    session = Net.telnet_connect(host,options)

    yield session if block_given?

    session.close
    return nil
  end
end
