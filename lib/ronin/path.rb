#
# Copyright (c) 2006-2012 Hal Brodigan (postmodern.mod3 at gmail.com)
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

require 'pathname'

module Ronin
  #
  # The {Path} class extends `Pathname` to allow representing directory
  # traversal paths.
  #
  # @api public
  #
  class Path < Pathname

    # The separator to join paths together with
    attr_accessor :separator

    #
    # Initializes a new Path.
    #
    # @param [String] path
    #   The path.
    #
    # @param [String] separator
    #   The directory separator to use.
    #
    def initialize(path,separator=File::SEPARATOR)
      @separator = separator

      super(path)
    end

    #
    # The root path.
    #
    # @return [Path]
    #   The root path.
    #
    def Path.root
      Path.new('/')
    end

    #
    # Creates a new path object for upward directory traversal.
    #
    # @param [Integer, Array, Range] n
    #   The number of directories to go up.
    #
    # @param [String] separator
    #   Path separator.
    #
    # @return [Path]
    #   The new path object.
    #
    # @raise [ArgumentError]
    #   A negative number was given as the first argument.
    #
    # @example Generate a relative path that goes up 7 directories:
    #   Path.up(7)
    #   # => #<Ronin::Path:../../../../../../..>
    #
    # @example Generate multiple relative paths, going up 1 to 3 directories:
    #   Path.up(1..3)
    #   # => [#<Ronin::Path:..>, #<Ronin::Path:../..>,
    #   #<Ronin::Path:../../..>]
    #
    def self.up(n,separator=File::SEPARATOR)
      case n
      when Integer
        if n == 0
          return separator
        elsif n < 0
          raise(ArgumentError,"negative argument")
        end

        path = new('..',separator)
        path.join(*(['..'] * (n-1)))
      when Enumerable
        n.map { |i| up(i) }
      else
        raise(ArgumentError,"The first argument of Path.up must be either an Integer or Enumerable")
      end
    end

    #
    # Joins directory names together with the path, but does not resolve
    # the resulting path.
    #
    # @param [Array] names
    #   The names to join together.
    #
    # @return [Path]
    #   The joined path.
    #
    # @example
    #   Path.up(7).join('etc/passwd')
    #   # => #<Ronin::Path:../../../../../../../etc/passwd>
    #
    def join(*names)
      joined_path = if root? then ''
                    else          self.to_s
                    end

      names.each do |name|
        name = name.to_s

        joined_path << @separator unless name.start_with?(@separator)
        joined_path << name       unless name == @separator
      end

      return self.class.new(joined_path,@separator)
    end

    alias / join

  end
end
