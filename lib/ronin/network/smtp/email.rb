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

module Ronin
  module Network
    module SMTP
      #
      # Represents an Email to be sent over {SMTP}.
      #
      class Email

        # Sender of the email
        attr_accessor :from

        # Recipient of the email
        attr_accessor :to

        # Subject of the email
        attr_accessor :subject

        # Date of the email
        attr_accessor :date

        # Unique message-id string
        attr_accessor :message_id

        # Body of the email
        attr_accessor :body

        #
        # Creates a new Email object.
        #
        # @param [Hash] options
        #   Additional options.
        #
        # @option options [String] :from
        #   The address the email is from.
        #
        # @option options [String] :to
        #   The address that the email should be sent to.
        #
        # @option options [String] :subject
        #   The subject of the email.
        #
        # @option options [String] :message_id
        #   Message-ID of the email.
        #
        # @option options [String, Time] :date (Time.now)
        #   The date the email was sent on.
        #
        # @option options [String, Array<String>] :body
        #   The body of the email.
        #
        # @yield [email]
        #   If a block is given, it will be passed the newly created email
        #   object.
        #
        # @yieldparam [Email] email
        #   The newly created email object.
        #
        # @api public
        #
        def initialize(options={})
          @from = options[:from]
          @to = options[:to]
          @subject = options[:subject]
          @date = options.fetch(:date,Time.now)
          @message_id = options[:message_id]
          @body = []

          if options[:body].kind_of?(Array)
            @body += options[:body]
          else
            @body << options[:body]
          end

          yield self if block_given?
        end

        #
        # Formats the email into a SMTP message.
        #
        # @return [String]
        #   Properly formatted SMTP message.
        #
        # @see http://www.ruby-doc.org/stdlib/libdoc/net/smtp/rdoc/classes/Net/SMTP.html
        #
        # @api public
        #
        def to_s
          address = lambda { |info|
            case info
            when Array
              "#{info[0]} <#{info[1]}>"
            when Hash
              "#{info[:name]} <#{info[:email]}>"
            else
              info
            end
          }

          message = []

          if @from
            message << "From: #{address[@from]}"
          end

          if @to
            message << "To: #{address[@to]}"
          end

          if @subject
            message << "Subject: #{@subject}"
          end

          if @date
            message << "Date: #{@date}"
          end

          if @message_id
            message << "Message-Id: <#{@message_id}>"
          end

          message << ''
          message += @body

          return message.join("\n")
        end

      end
    end
  end
end
