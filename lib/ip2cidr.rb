require "ip2cidr/iphandling"

# The main IPToCIDR driver
class IPToCIDR
  # Converts IP Range to IP CIDR blocks
  # 
  # Example:
  #   >> IPToCIDR.solveCIDR("172.254.6.1","192.168.254.254")
  #   => 192.168.254.0/24
  # Arguments:
  #   startip: (String)
  #   endip:   (String)

  def self.solveCIDR(startip, endip)
    cidr = IPHandling.new

    # Check if IP Starting Address is valid
    raise ArgumentError, 'IP address is not valid' unless startip.split(".").length == 4
    
    # Check if Ending IP Address is valid
    raise ArgumentError, 'IP address is not valid' unless endip.split(".").length == 4
   
    raise ArgumentError, 'Special IP address error' if 
      (startip == "0.0.0.0") || (endip == "0.0.0.0") || 
        (startip == "255.255.255.255") || (endip == "255.255.255.255")

    
    cidr.iprange_to_cidr(startip, endip)
  end
end