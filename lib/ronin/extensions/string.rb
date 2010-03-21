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

class String

  #
  # Returns the common prefix of the string and the specified other
  # string. If no common prefix can be found an empty string will be
  # returned.
  #
  def common_prefix(other)
    min_length = [length, other.length].min

    min_length.times do |i|
      if self[i] != other[i]
        return self[0...i]
      end
    end

    return self[0...min_length]
  end

  #
  # Returns the common postfix of the string and the specified other
  # string. If no common postfix can be found an empty string will be
  # returned.
  #
  def common_postfix(other)
    min_length = [length, other.length].min

    (min_length - 1).times do |i|
      index = (length - i - 1)
      other_index = (other.length - i - 1)

      if self[index] != other[other_index]
        return self[(index + 1)..-1]
      end
    end

    return ''
  end

  #
  # Returns the uncommon substring within the specified other string,
  # which does not occur within the string. If no uncommon substring can be
  # found, an empty string will be returned.
  #
  def uncommon_substring(other)
    prefix = common_prefix(other)
    postfix = self[prefix.length..-1].common_postfix(other[prefix.length..-1])

    return self[prefix.length...(length - postfix.length)]
  end

  #
  # Dumps the string as a C-style string.
  #
  # @return [String]
  #   The C-style encoded version of the String.
  #
  # @example
  #   "hello\x00\073\x90\r\n".dump
  #   # => "hello\0;\x90\r\n"
  #
  def dump
    c_string = ''

    each_byte do |b|
      c_string << case b
                  when 0x00
                    "\\0"
                  when 0x07
                    "\\a"
                  when 0x08
                    "\\b"
                  when 0x09
                    "\\t"
                  when 0x0a
                    "\\n"
                  when 0x0b
                    "\\v"
                  when 0x0c
                    "\\f"
                  when 0x0d
                    "\\r"
                  when 0x22
                    "\\\""
                  when 0x5c
                    "\\\\"
                  when (0x20..0x7e)
                    b.chr
                  else
                    ("\\x%.2x" % b)
                  end
    end

    return "\"#{c_string}\""
  end

  alias inspect dump

end
