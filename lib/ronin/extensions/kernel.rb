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

require 'extlib'

module Kernel
  #
  # Calls the given block and ignores any raised exceptions.
  #
  # @yield []
  #   The block to be called.
  #
  # @return [Object, nil]
  #   The return-value of the given block. If `nil` is returned, an
  #   exception occurred and was ignored.
  #
  # @example
  #   attempt do
  #     Resolv.getaddress('might.not.exist.com')
  #   end
  #
  def attempt(&block)
    begin
      block.call() if block
    rescue Exception
      return nil
    end
  end

  #
  # Attempts to run the given block and catches any SyntaxError,
  # RuntimeError or StandardError exceptions.
  #
  # @param [Boolean] verbose
  #   Specifies wether a backtrace will be printed when an exception
  #   has been raised.
  #
  # @yield []
  #   The block to be called.
  #
  # @return [nil]
  #   An exception was ignored, or the block returned nil.
  #
  # @example
  #   catch_all do
  #     load 'suspicious.rb'
  #   end
  #
  def catch_all(verbose=true,&block)
    begin
      block.call() if block
    rescue Exception => e
      if verbose
        STDERR.puts "#{e.class}: #{e}"
        e.backtrace[0,5].each { |trace| STDERR.puts "\t#{trace}" }
      end

      return nil
    end
  end

  #
  # Safely requires the specified sub_path from within the specified
  # directory.
  #
  # @param [String] directory
  #   The directory to require the _sub_path_ within.
  #
  # @param [String] sub_path
  #   The relative path to require, specifically within the specified
  #   directory.
  #
  # @return [Boolean]
  #   Specifies wether or not the _sub_path_ has not been loaded before.
  #
  # @example
  #   require_within 'ronin/exploits/helpers', helper_name
  #
  def require_within(directory,sub_path)
    path = File.expand_path(File.join('',sub_path))
    require File.join(directory,path)
  end

  #
  # Requires the given path and finds the constant defined in the file.
  #
  # @param [String] path
  #   The path to require.
  #
  # @return [Class, Module, nil]
  #   The constant defined by the file. If `nil` is returned, then either
  #   the file could not be loaded or the constant could not be found.
  #
  # @example
  #   require_const 'ronin/exploits/exploit'
  #   # => Ronin::Exploits::Exploit
  #
  # @since 0.1.0
  #
  def require_const(path)
    begin
      require path
    rescue Gem::LoadError => e
      raise(e)
    rescue ::LoadError
      return nil
    end

    begin
      return Object.full_const_get(path.to_const_name)
    rescue NameError
      return nil
    end
  end
end
