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

require 'ipaddr'

class IPAddr

  include Enumerable

  #
  # Iterates over each IP address within the IP Address range. Supports
  # both IPv4 and IPv6 address ranges.
  #
  # @param [String] cidr_or_glob
  #   The IP address range to iterate over.
  #   May be in standard CIDR notation or globbed format.
  #
  # @yield [ip]
  #   The block which will be passed each IP address contained within the
  #   IP address range.
  #
  # @yieldparam [String] ip
  #   An IP address within the IP address range.
  #
  # @return [nil]
  #
  # @example Enumerate through a CIDR range
  #   IPAddr.each('10.1.1.1/24') do |ip|
  #     puts ip
  #   end
  #
  # @example Enumerate through a globbed IP range
  #   IPAddr.each('10.1.1-5.*') do |ip|
  #     puts ip
  #   end
  #
  # @example Enumerate through a globbed IPv6 range
  #   IPAddr.each('::ff::02-0a::c3') do |ip|
  #     puts ip
  #   end
  #
  def IPAddr.each(cidr_or_glob,&block)
    unless (cidr_or_glob.include?('*') || cidr_or_glob.include?('-'))
      return IPAddr.new(cidr_or_glob).each(&block)
    end

    return enum_for(:each,cidr_or_glob) unless block

    if cidr_or_glob.include?('::')
      prefix = if cidr_or_glob =~ /^::/
                 '::'
               else
                 ''
               end

      separator = '::'
      base = 16

      format = lambda { |address|
        prefix + address.map { |i| '%.2x' % i }.join('::')
      }
    else
      separator = '.'
      base = 10

      format = lambda { |address| address.join('.') }
    end

    ranges = cidr_or_glob.split(separator).map { |segment|
      if segment == '*'
        (1..254)
      elsif segment.include?('-')
        start, stop = segment.split('-',2).map { |i| i.to_i(base) }

        (start..stop)
      elsif !(segment.empty?)
        segment.to_i(base)
      end
    }.compact

    expand_range = lambda { |address,remaining|
      if remaining.empty?
        block.call(format.call(address))
      else
        n = remaining.first
        remaining = remaining[1..-1]

        if n.kind_of?(Range)
          n.each { |i| expand_range.call(address + [i], remaining) }
        else
          expand_range.call(address + [n], remaining)
        end
      end
    }

    expand_range.call([], ranges)
    return nil
  end

  #
  # Iterates over each IP address that is included in the addresses
  # netmask. Supports both IPv4 and IPv6 addresses.
  #
  # @yield [ip]
  #   The block which will be passed every IP address covered be the
  #   netmask of the IPAddr object.
  #
  # @yieldparam [String] ip
  #   An IP address.
  #
  # @example
  #   netblock = IPAddr.new('10.1.1.1/24')
  #
  #   netblock.each do |ip|
  #     puts ip
  #   end
  #
  def each(&block)
    return enum_for(:each) unless block

    case @family
    when Socket::AF_INET
      family_mask = IN4MASK
    when Socket::AF_INET6
      family_mask = IN6MASK
    end

    (0..((~@mask_addr) & family_mask)).each do |i|
      block.call(_to_string(@addr | i))
    end

    return self
  end

end
