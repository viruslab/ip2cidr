# ip2cidr

## Introduction

A simple Ruby gem for converting a range of IP addresses to a list of CIDR blocks.

## Installation

Install the gem on the command line using

```
gem install ip2cidr
```

## Usage

Using the class:

```
$  irb
>> require "ip2cidr"
>> IPToCIDR.solveCIDR("192.168.0.1", "192.168.0.16")
=> ["192.168.0.1/32", "192.168.0.2/31", "192.168.0.4/30", "192.168.0.8/29", "192.168.0.16/32"]
```

Using the binary file:

```
$ ip2cidr 192.168.0.1 192.168.0.16
192.168.0.1/32
192.168.0.2/31
192.168.0.4/30
192.168.0.8/29
192.168.0.16/32
```

This gem cannot use either 0.0.0.0 or 255.255.255.255 as inputs and will return an ArgumentError if the are used as inputs.

## Authors

Carlo Niño A. Bitoon, Kirk Gandril B. Madraga, John Patrick Suelto