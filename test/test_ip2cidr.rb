require 'test/unit'
require 'ip2cidr'

class IPToCIDRTest < Test::Unit::TestCase
  def test_ipstring_to_long
    assert_equal 0xc0a80001, IPToCIDR.ipstring_to_long("192.168.0.1").to_s(16)
    assert_equal 0xffffffff, IPToCIDR.ipstring_to_long("255.255.255.255").to_s(16)
    assert_equal 0x00000000, IPToCIDR.ipstring_to_long("0.0.0.0").to_s(16)
    assert_equal 0xfefefefe, IPToCIDR.ipstring_to_long("254.254.254.254").to_s(16)
    assert_equal 0x18ff0701, IPToCIDR.ipstring_to_long("24.255.7.1").to_s(16)
    assert_equal 0xc23f0f60, IPToCIDR.ipstring_to_long("194.63.15.96").to_s(16)
    assert_equal 0x2ef653ca, IPToCIDR.ipstring_to_long("46.246.83.202").to_s(16)
  end

  def test_long_to_ip_string
    assert_equal "192.168.0.1",     IPToCIDR.long_to_ip_string(0xc0a80001)
    assert_equal "255.255.255.255", IPToCIDR.long_to_ip_string(0xffffffff)
    assert_equal "0.0.0.0",         IPToCIDR.long_to_ip_string(0x00000000)
    assert_equal "254.254.254.254", IPToCIDR.long_to_ip_string(0xfefefefe)
    assert_equal "24.255.7.1",      IPToCIDR.long_to_ip_string(0x18ff0701)
    assert_equal "194.63.15.96",    IPToCIDR.long_to_ip_string(0xc23f0f60)
    assert_equal "46.246.83.202",   IPToCIDR.long_to_ip_string(0x2ef653ca)
	end

  def test_iprange_to_cidr
    test2 = ["192.168.0.0/13", "192.176.0.0/12", "192.192.0.0/10", "193.0.0.0/8", "194.0.0.0/7", 
             "196.0.0.0/6", "200.0.0.0/5", "208.0.0.0/4", "224.0.0.0/4", "240.0.0.0/5", "248.0.0.0/6", 
             "252.0.0.0/7", "254.0.0.0/8", "255.0.0.0/9", "255.128.0.0/11", "255.160.0.0/13", "255.168.0.0/29"]
    
    test4 = ["0.168.0.1/32", "0.168.0.2/31", "0.168.0.4/30", "0.168.0.8/29", "0.168.0.16/28",
             "0.168.0.32/27", "0.168.0.64/26", "0.168.0.128/25", "0.168.1.0/24", 
             "0.168.2.0/23", "0.168.4.0/22", "0.168.8.0/21", "0.168.16.0/20", 
             "0.168.32.0/19", "0.168.64.0/18", "0.168.128.0/17", "0.169.0.0/16", 
             "0.170.0.0/15", "0.172.0.0/14", "0.176.0.0/12", "0.192.0.0/10", 
             "1.0.0.0/8", "2.0.0.0/7", "4.0.0.0/6", "8.0.0.0/5", "16.0.0.0/4", 
             "32.0.0.0/3", "64.0.0.0/2", "128.0.0.0/2", "192.0.0.0/3", "224.0.0.0/4", 
             "240.0.0.0/5", "248.0.0.0/6", "252.0.0.0/7", "254.0.0.0/24"]

    assert_equal "192.168.0.0/29",  IPToCIDR.iprange_to_cidr("192.168.0.0", "192.168.0.7")
    assert_equal test2,             IPToCIDR.iprange_to_cidr("192.168.0.0", "255.168.0.7")
    assert_equal "192.168.0.1/32",  IPToCIDR.iprange_to_cidr("192.168.0.1", "192.168.0.1")
    assert_equal test4,             IPToCIDR.iprange_to_cidr("0.168.0.1",   "254.0.0.255")
  end
end