# ipstring2long 
# Convert an ip address in string format to integer.
def ipstring2long(ipstring)
  ipstring = ipstring.split(".")
  longip = Array.new(4)
  for i in 0..3
    longip[i] = ipstring[i].to_i
  end
  #return longip
  return (longip[0] << 24) + (longip[1] << 16) + 
         (longip[2] << 8) + longip[3]
end

# long2ipstring
# Convert an ip address in integer format to string.
def long2ipstring(longip)
  ipstring = ""
  ipstring = (longip >> 24).to_s + "." + 
             ((longip & 0x00FFFFFF)>> 16).to_s + "." + 
             ((longip & 0x0000FFFF) >> 8).to_s + "." + 
             (longip & 0x000000FF).to_s
  return ipstring
end

# iprange2cidr
# Return a list of cidr addresses given a range of ip 
# addresses.
def iprange2cidr(startip, endip)
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
  startaddr =  ipstring2long(startip)
  endaddr = ipstring2long (endip)
  cidrlist = Array.new

  while endaddr >= startaddr
    maxsize = 32
    while maxsize > 0
      mask = cidr2mask[maxsize - 1]
      maskedbase = startaddr & mask

      if maskedbase != startaddr
         break
      end

      maxsize -= 1
    end

    x = Math.log(endaddr - startaddr + 1) / Math.log(2)
    maxdiff = 32 - x.floor
    if maxsize < maxdiff
      maxsize = maxdiff 
    end

    cidrlist.push(long2ipstring(startaddr) + "/" + maxsize.to_s)
    startaddr += 2**(32 - maxsize)
  end

  return cidrlist
end

# TEST CASES
puts "TEST CASES:\n\n"

# Test cases for ipstring2long
puts "Test cases for ipstring2long."
puts ipstring2long("192.168.0.1").to_s(16)
puts ipstring2long("255.255.255.255").to_s(16)
puts ipstring2long("0.0.0.0").to_s(16)
puts ipstring2long("254.254.254.254").to_s(16)
puts ipstring2long("24.255.7.1").to_s(16)
puts ipstring2long("194.63.15.96").to_s(16)
puts ipstring2long("46.246.83.202").to_s(16)
puts ""

# Test cases for long2ipstring
puts "Test cases for long2ipstring"
puts long2ipstring(0xc0a80001)
puts long2ipstring(0xffffffff)
puts long2ipstring(0x00000000)
puts long2ipstring(0xfefefefe)
puts long2ipstring(0x18ff0701)
puts long2ipstring(0xc23f0f60)
puts long2ipstring(0x2ef653ca)
puts ""

# Test cases for iprange2cidr
puts "Test cases for iprange2cidr"
puts iprange2cidr("192.168.0.0", "192.168.0.7")
puts ""
puts iprange2cidr("192.168.0.0", "255.168.0.7")
puts ""
puts iprange2cidr("192.168.0.1", "192.168.0.1")
puts ""
puts iprange2cidr("0.168.0.1", "254.0.0.255")
puts ""