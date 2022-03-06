#
# Copyright (c) 2006-2022 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# This file is part of ronin-support.
#
# ronin-support is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# ronin-support is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with ronin-support.  If not, see <https://www.gnu.org/licenses/>.
#

require 'ronin/support/network/ip'
require 'ronin/support/network/mixins/dns'
require 'ronin/support/network/mixins/tcp'
require 'ronin/support/network/mixins/udp'
require 'ronin/support/network/mixins/ssl'
require 'ronin/support/network/mixins/unix'
require 'ronin/support/network/http'
require 'ronin/support/network/mixins/ftp'
require 'ronin/support/network/mixins/pop3'
require 'ronin/support/network/mixins/imap'
require 'ronin/support/network/mixins/smtp'
require 'ronin/support/network/mixins/esmtp'

module Ronin
  module Support
    module Network
      module Mixin
        include IP
        include Mixins::DNS
        include Mixins::TCP
        include Mixins::UDP
        include Mixins::SSL
        include Mixins::UNIX
        include HTTP
        include Mixins::FTP
        include Mixins::SMTP
        include Mixins::ESMTP
        include Mixins::POP3
        include Mixins::IMAP
      end
    end
  end
end
