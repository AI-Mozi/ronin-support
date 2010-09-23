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

require 'ronin/network/smtp/email'

module Ronin
  module Network
    module SMTP
      # Default smtp port
      DEFAULT_PORT = 25

      #
      # @return [Integer]
      #   The default Ronin SMTP port.
      #
      def SMTP.default_port
        @default_port ||= DEFAULT_PORT
      end

      #
      # Sets the default Ronin SMTP port.
      #
      # @param [Integer] port
      #   The new default Ronin SMTP port.
      #
      def SMTP.default_port=(port)
        @default_port = port
      end

      #
      # Creates a properly formatted email.
      #
      # @yield [email]
      #   If a block is given, it will be passed the newly created Email
      #   object.
      #
      # @yieldparam [Ronin::Network::Email::SMTP] email
      #   The new Email object.
      #
      # @return [String]
      #   Formatted SMTP email.
      #
      # @see Ronin::Network::SMTP::Email
      #
      def SMTP.message(options={},&block)
        Email.new(options,&block).to_s
      end
    end
  end
end
