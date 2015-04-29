class IPToCIDR
  # ipstring_to_long 
  # Convert an ip address in string format to integer.
  def ipstring_to_long(ipstring)
    ipstring = ipstring.split(".")
    longip = Array.new(4)
    for i in 0..3
      longip[i] = ipstring[i].to_i
    end
    #return longip
    return (longip[0] << 24) + (longip[1] << 16) + 
           (longip[2] << 8) + longip[3]
  end

  # long_to_ip_string
  # Convert an ip address in integer format to string.
  def long_to_ip_string(longip)
    ipstring = ""
    ipstring = (longip >> 24).to_s + "." + 
               ((longip & 0x00FFFFFF)>> 16).to_s + "." + 
               ((longip & 0x0000FFFF) >> 8).to_s + "." + 
               (longip & 0x000000FF).to_s
    return ipstring
  end

  # iprange_to_cidr
  # Return a list of cidr addresses given a range of ip 
  # addresses.
  def self.iprange_to_cidr(startip, endip)
    cidr2mask = [0x00000000, 0x80000000, 0xC0000000, 
                 0xE0000000, 0xF0000000, 0xF8000000, 
                 0xFC000000, 0xFE000000, 0xFF000000, 
                 0xFF800000, 0xFFC00000, 0xFFE00000, 
                 0xFFF00000, 0xFFF80000, 0xFFFC0000, 
                 0xFFFE0000, 0xFFFF0000, 0xFFFF8000, 
                 0xFFFFC000, 0xFFFFE000, 0xFFFFF000, 
                 0xFFFFF800, 0xFFFFFC00, 0xFFFFFE00, 
                 0xFFFFFF00, 0xFFFFFF80, 0xFFFFFFC0, 
                 0xFFFFFFE0, 0xFFFFFFF0, 0xFFFFFFF8, 
                 0xFFFFFFFC, 0xFFFFFFFE, 0xFFFFFFFF]
    startaddr =  ipstring_to_long(startip)
    endaddr = ipstring_to_long (endip)
    cidrlist = Array.new

    while endaddr >= startaddr
      maxsize = 32
      while maxsize > 0
        mask = cidr2mask[maxsize - 1]
        maskedbase = startaddr & mask

        break if maskedbase != startaddr

        maxsize -= 1
      end

      x = Math.log(endaddr - startaddr + 1) / Math.log(2)
      maxdiff = 32 - x.floor
      maxsize = maxdiff if maxsize < maxdiff

      cidrlist.push(long_to_ip_string(startaddr) + "/" + maxsize.to_s)
      startaddr += 2**(32 - maxsize)
    end

    return cidrlist
  end
end