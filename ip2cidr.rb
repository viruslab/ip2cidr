ip_list = []
string = "1"
ip_number = 1
flag = 0




#converts and IP address to binary
def ip2binary(ip_string)
	a = "" 
	ip_string = ip_string.split(".")
	ip_string.each {|x| a << "%08b" % x.to_i}
	return a
end

def getcidr(ip_first, ip_last)

	a = ip_first
	b = ip_last

	puts a
	puts b
	xor = (a.to_i(2) ^ b.to_i(2)).to_s(2)
	puts xor
	cidr = 32 - (xor.length)
	return cidr

end

#IP2CIDR
def ip2cidr(ip_1, ip_2)

	bit_value = [1,2,4,8,16,32,64,128]
	temp_ip = (ip_1 < ip_2) ? ip_1 : ip_2
	cidr_list = []
	counter = 0
	i = 0
	
	puts ip_1
	puts ip_2

	elements = (ip_1.to_i(2) - ip_2.to_i(2)).abs + 1

	temp_elements = elements

	while true

		while elements > bit_value[i]
			i += 1

		end
			puts "elements>> #{elements}"
			
		if elements == bit_value[i]
		
			temp_elements = bit_value[i]
			elements = elements - temp_elements	
			temp_ip_last = temp_ip			

				while counter < temp_elements - 1
				temp_ip_last = "%08b" % (temp_ip_last.to_i(2) + 1)
				counter += 1
				end
				puts temp_ip
				puts temp_ip_last
				cidr_list << getcidr(temp_ip, temp_ip_last)

			break
		end
			
		if elements != bit_value[i]

			puts "bit_value>> #{bit_value[i-1]}"
			temp_elements = bit_value[i-1]
			puts "temp_elements>> #{temp_elements}"
			elements = elements - temp_elements	
			temp_ip_last = temp_ip

			while counter < temp_elements - 1
				temp_ip_last = "%032b" % (temp_ip_last.to_i(2) + 1)
				counter += 1
			end
				puts temp_ip
				puts temp_ip_last
				cidr_list << getcidr(temp_ip, temp_ip_last)
 
		else
			cidr_list << 32
			break

		end
		i = 0
		counter = 0
	end

	return cidr_list


end	

#converts binary to CIDR
def converttoip(ipaddress)
	a = ""
	ipaddress = ipaddress.scan(/......../)

	ipaddress.each {|x| a << x.to_i(2).to_s + "."}
	return a[0...-1]
end


def checkifvalid(ip_string)
	index = 0
	flag = 0
	count = ip_string.count "."

	if count == 3

		ip_string = ip_string.split(".")
		
		while index < 4
			if ip_string[index].to_i > 255
				flag += 1
			end
			index += 1
		end

		if flag == 0 
			return 1
		end
	end
	
	return 0
end



puts "please enter IP addresses below. '0' to terminate "

while ip_list.length < 2

	print "IP Address number #{ip_number}: "
	STDOUT.flush  
	
	string = gets.chomp
	flag = checkifvalid(string)	

		if flag == 0
			print "The IP Address is either invalid or reserved \n"

		else
			ip_list << ip2binary(string)
			ip_number += 1
		end	
end



puts "RESULT:  #{ip2cidr(ip_list[0],ip_list[1])}"
