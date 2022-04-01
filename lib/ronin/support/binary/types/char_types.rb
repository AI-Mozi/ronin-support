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

require 'ronin/support/binary/types/char_type'
require 'ronin/support/binary/types/string_type'

module Ronin
  module Support
    module Binary
      module Types
        module CharTypes
          # The `char` type.
          CHAR = CharType.new(signed: true, pack_string: 'Z')

          # The `unsigned char` type.
          UCHAR = CharType.new(signed: false, pack_string: 'a')

          # The null-terminated C string type.
          STRING = StringType.new
        end
      end
    end
  end
end
