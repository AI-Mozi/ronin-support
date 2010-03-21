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

class Array

  #
  # Calculates the power-set of the Array.
  #
  # @return [Array]
  #   The power set of the array.
  #
  # @example
  #   [1,2,3].power_set
  #   # => [[], [3], [2], [2, 3], [1], [1, 3], [1, 2], [1, 2, 3]]
  #
  # @see http://johncarrino.net/blog/2006/08/11/powerset-in-ruby/
  #
  def power_set
    inject([[]]) do |power_set,element|
      sub_set = []

      power_set.each do |i|
        sub_set << i
        sub_set << i + [element]
      end

      sub_set
    end
  end

end
