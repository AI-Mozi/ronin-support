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

require 'ronin/network/smtp/email'

require 'net/smtp'

module Net
  #
  # @see Ronin::Network::SMTP.message
  #
  def Net.smtp_message(options={},&block)
    Ronin::Network::SMTP.message(options,&block)
  end

  #
  # Creates a connection to the SMTP server.
  #
  # @param [String] host
  #   The host to connect to.
  #
  # @param [Hash] options
  #   Additional options.
  #
  # @option options [Integer] :port (Ronin::Network::SMTP.default_port)
  #   The port to connect to.
  #
  # @option options [String] :helo
  #   The HELO domain.
  #
  # @option options [Symbol] :auth
  #   The type of authentication to use. Can be either `:login`, `:plain`,
  #   or `:cram_md5`.
  #
  # @option options [String] :user
  #   The user-name to authenticate with.
  #
  # @option options [String] :password
  #   The password to authenticate with.
  #
  # @yield [session]
  #   If a block is given, it will be passed an SMTP session object.
  #
  # @yieldparam [Net::SMTP] session
  #   The SMTP session.
  #
  # @return [Net::SMTP]
  #   The SMTP session.
  #
  def Net.smtp_connect(host,options={})
    host = host.to_s
    port = (options[:port] || Ronin::Network::SMTP.default_port)

    helo = options[:helo]

    auth = options[:auth]
    user = options[:user]
    password = options[:password]

    session = Net::SMTP.start(host,port,helo,user,password,auth)

    yield session if block_given?
    return session
  end

  #
  # Starts a session with the SMTP server.
  #
  # @param [String] host
  #   The host to connect to.
  #
  # @param [Hash] options
  #   Additional options.
  #
  # @yield [session]
  #   If a block is given, it will be passed an SMTP session object.
  #   After the block has returned, the session will be closed.
  #
  # @yieldparam [Net::SMTP] session
  #   The SMTP session.
  #
  # @see Net.smtp_connect
  #
  def Net.smtp_session(host,options={})
    session = Net.smtp_connect(host,options)

    yield session if block_given?

    session.finish
    return nil
  end
end
