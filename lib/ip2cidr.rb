require "ip2cidr/iphandling"

class IPToCIDR
  def self.solveCIDR(startip, endip)
    cidr = IPHandling.new
    cidr.iprange_to_cidr(startip,endip)
  end
end