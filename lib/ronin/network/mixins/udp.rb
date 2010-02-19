#
# Ronin - A Ruby platform for exploit development and security research.
#
# Copyright (c) 2006-2010 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#

require 'ronin/network/udp'

require 'parameters'

module Ronin
  module Network
    module Mixins
      module UDP
        include Parameters

        # UDP host
        parameter :host,
                  :type => String,
                  :description => 'UDP host'

        # UDP port
        parameter :port,
                  :type => Integer,
                  :description => 'UDP port'

        # UDP local host
        parameter :local_host,
                  :type => String,
                  :description => 'UDP local host'

        # UDP local port
        parameter :local_port,
                  :type => Integer,
                  :description => 'UDP local port'

        # UDP server host
        parameter :server_host,
                  :type => String,
                  :description => 'UDP server host'

        # UDP server port
        parameter :server_port,
                  :type => Integer,
                  :description => 'UDP server port'

        protected

        #
        # Opens a UDP connection to the host and port specified by the
        # `host` and `port` instance methods . If the `local_host` and
        # `local_port` instance methods are set, they will be used for
        # the local host and port of the UDP connection.
        #
        # @yield [socket]
        #   If a block is given, it will be passed the newly created socket.
        #
        # @yieldparam [UDPsocket] socket
        #   The newly created UDPSocket object.
        #
        # @return [UDPSocket]
        #   The newly created UDPSocket object.
        #
        # @example
        #   udp_connect
        #   # => UDPSocket
        #
        # @example
        #   udp_connect do |sock|
        #     puts sock.readlines
        #   end
        #
        # @since 0.3.0
        #
        def udp_connect(&block)
          print_info "Connecting to #{self.host}:#{self.port} ..."

          return ::Net.udp_connect(self.host,self.port,self.local_host,self.local_port,&block)
        end

        #
        # Connects to the host and port specified by the `host` and `port`
        # instance methods, then sends the given data. If the
        # `local_host` and `local_port` instance methods are set, they
        # will be used for the local host and port of the UDP connection.
        #
        # @param [String] data
        #   The data to send through the connection.
        #
        # @yield [socket]
        #   If a block is given, it will be passed the newly created socket.
        #
        # @yieldparam [UDPsocket] socket
        #   The newly created UDPSocket object.
        #
        # @return [UDPSocket]
        #   The newly created UDPSocket object.
        #
        # @since 0.3.0
        #
        def udp_connect_and_send(data,&block)
          print_info "Connecting to #{self.host}:#{self.port} ..."
          print_debug "Sending data: #{data.inspect}"

          return ::Net.udp_connect_and_send(data,self.host,self.port,self.local_host,self.local_port,&block)
        end

        #
        # Creates a UDP session to the host and port specified by the
        # `host` and `port` instance methods. If the `local_host` and
        # `local_port` instance methods are set, they will be used for
        # the local host and port of the UDP connection.
        #
        # @yield [socket]
        #   If a block is given, it will be passed the newly created socket.
        #   After the block has returned, the socket will then be closed.
        #
        # @yieldparam [UDPsocket] socket
        #   The newly created UDPSocket object.
        #
        # @return [nil]
        #
        # @since 0.3.0
        #
        def udp_session(&block)
          print_info "Connecting to #{self.host}:#{self.port} ..."

          ::Net.udp_session(self.host,self.port,self.local_host,self.local_port,&block)

          print_info "Disconnected from #{self.host}:#{self.port}"
          return nil
        end

        #
        # Creates a new UDPServer object listening on `server_host` and
        # `server_port` instance methods.
        #
        # @yield [server]
        #   The given block will be passed the newly created server.
        #
        # @yieldparam [UDPServer] server
        #   The newly created server.
        #
        # @return [UDPServer]
        #   The newly created server.
        #
        # @example
        #   udp_server
        #
        # @since 0.3.0
        #
        def udp_server(&block)
          if self.server_host
            print_info "Listening on #{self.server_host}:#{self.server_port} ..."
          else
            print_info "Listening on #{self.server_port} ..."
          end

          return ::Net.udp_server(self.server_port,self.server_host,&block)
        end

        #
        # Creates a new temporary UDPServer object listening on the
        # `server_host` and `server_port` instance methods.
        #
        # @yield [server]
        #   The given block will be passed the newly created server.
        #   When the block has finished, the server will be closed.
        #
        # @yieldparam [UDPServer] server
        #   The newly created server.
        #
        # @return [nil]
        #
        # @example
        #   udp_server_session do |server|
        #     data, sender = server.recvfrom(1024)
        #   end
        #
        # @since 0.3.0
        #
        def udp_server_session(&block)
          if self.server_host
            print_info "Listening on #{self.server_host}:#{self.server_port} ..."
          else
            print_info "Listening on #{self.server_port} ..."
          end

          ::Net.udp_server_session(&block)

          if self.server_host
            print_info "Closed #{self.server_host}:#{self.server_port}"
          else
            print_info "Closed #{self.server_port}"
          end

          return nil
        end
      end
    end
  end
end
