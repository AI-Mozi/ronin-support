#
# Ronin Support - A support library for Ronin.
#
# Copyright (c) 2010 Hal Brodigan (postmodern.mod3 at gmail.com)
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

begin
  require 'active_support/inflector'
rescue LoadError
  begin
    require 'extlib/inflection'
  rescue LoadError
    raise(LoadError,"unable to load 'active_support/inflector' or 'extlib/inflection'",caller)
  end
end

module Ronin
  module Support
    # The inflector that Ronin will use.
    Inflector = if Object.const_defined?(:ActiveSupport)
                  ActiveSupport::Inflector
                else
                  Extlib::Inflection
                end
  end
end
