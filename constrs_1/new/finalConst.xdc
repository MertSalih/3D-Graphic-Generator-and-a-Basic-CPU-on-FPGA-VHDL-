# This file is a general .xdc for the Basys3 rev B board 
# To use it in a project: 
# - uncomment the lines corresponding to used pins 
# - rename the used ports (in each line, after get_ports) according to the top level signal names in the project 
# Clock signal 
 set_property PACKAGE_PIN W5 [get_ports clk]
 set_property IOSTANDARD LVCMOS33 [get_ports clk] 
 create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk] 

 


 

##VGA Connector
set_property PACKAGE_PIN G19 [get_ports {Rout[0]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {Rout[0]}]
set_property PACKAGE_PIN H19 [get_ports {Rout[1]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {Rout[1]}]
set_property PACKAGE_PIN J19 [get_ports {Rout[2]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {Rout[2]}]
set_property PACKAGE_PIN N19 [get_ports {Rout[3]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {Rout[3]}]
set_property PACKAGE_PIN N18 [get_ports {Bout[0]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {Bout[0]}]
set_property PACKAGE_PIN L18 [get_ports {Bout[1]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {Bout[1]}]
set_property PACKAGE_PIN K18 [get_ports {Bout[2]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {Bout[2]}]
set_property PACKAGE_PIN J18 [get_ports {Bout[3]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {Bout[3]}]
set_property PACKAGE_PIN J17 [get_ports {Gout[0]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {Gout[0]}]
set_property PACKAGE_PIN H17 [get_ports {Gout[1]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {Gout[1]}]
set_property PACKAGE_PIN G17 [get_ports {Gout[2]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {Gout[2]}]
set_property PACKAGE_PIN D17 [get_ports {Gout[3]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {Gout[3]}]
set_property PACKAGE_PIN P19 [get_ports Hsy]						
	set_property IOSTANDARD LVCMOS33 [get_ports Hsy]
set_property PACKAGE_PIN R19 [get_ports Vsy]						
	set_property IOSTANDARD LVCMOS33 [get_ports Vsy]

 # LEDs 
 set_property PACKAGE_PIN U16 [get_ports {datareg1[0]}] 
 set_property IOSTANDARD LVCMOS33 [get_ports {datareg1[0]}] 
 set_property PACKAGE_PIN E19 [get_ports {datareg1[1]}] 
 set_property IOSTANDARD LVCMOS33 [get_ports {datareg1[1]}] 
 set_property PACKAGE_PIN U19 [get_ports {datareg1[2]}] 
 set_property IOSTANDARD LVCMOS33 [get_ports {datareg1[2]}] 
 set_property PACKAGE_PIN V19 [get_ports {datareg1[3]}] 
 set_property IOSTANDARD LVCMOS33 [get_ports {datareg1[3]}] 
 set_property PACKAGE_PIN W18 [get_ports {datareg1[4]}] 
 set_property IOSTANDARD LVCMOS33 [get_ports {datareg1[4]}] 
 set_property PACKAGE_PIN U15 [get_ports {datareg1[5]}] 
 set_property IOSTANDARD LVCMOS33 [get_ports {datareg1[5]}] 
 set_property PACKAGE_PIN U14 [get_ports {datareg1[6]}] 
 set_property IOSTANDARD LVCMOS33 [get_ports {datareg1[6]}] 
 set_property PACKAGE_PIN V14 [get_ports {datareg1[7]}] 
 set_property IOSTANDARD LVCMOS33 [get_ports {datareg1[7]}] 
 set_property PACKAGE_PIN V13 [get_ports {datareg2[0]}] 
 set_property IOSTANDARD LVCMOS33 [get_ports {datareg2[0]}] 
 set_property PACKAGE_PIN V3 [get_ports {datareg2[1]}] 
 set_property IOSTANDARD LVCMOS33 [get_ports {datareg2[1]}] 
 set_property PACKAGE_PIN W3 [get_ports {datareg2[2]}] 
 set_property IOSTANDARD LVCMOS33 [get_ports {datareg2[2]}] 
 set_property PACKAGE_PIN U3 [get_ports {datareg2[3]}] 
 set_property IOSTANDARD LVCMOS33 [get_ports {datareg2[3]}] 
 set_property PACKAGE_PIN P3 [get_ports {datareg2[4]}] 
 set_property IOSTANDARD LVCMOS33 [get_ports {datareg2[4]}] 
 set_property PACKAGE_PIN N3 [get_ports {datareg2[5]}] 
 set_property IOSTANDARD LVCMOS33 [get_ports {datareg2[5]}] 
 set_property PACKAGE_PIN P1 [get_ports {datareg2[6]}] 
 set_property IOSTANDARD LVCMOS33 [get_ports {datareg2[6]}] 
 set_property PACKAGE_PIN L1 [get_ports {datareg2[7]}]
set_property IOSTANDARD LVCMOS33  [get_ports {datareg2[7]}] 


#Sch name = JB1
set_property PACKAGE_PIN A14 [get_ports {data[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {data[0]}]
#Sch name = JB2
set_property PACKAGE_PIN A16 [get_ports {clkout[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {clkout[0]}]


#Sch name = JB3
set_property PACKAGE_PIN B15 [get_ports {load[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {load[0]}]

##Sch name = JB7
set_property PACKAGE_PIN A15 [get_ports {data[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {data[1]}]
##Sch name = JB8
set_property PACKAGE_PIN A17 [get_ports {clkout[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {clkout[1]}]
##Sch name = JB9
set_property PACKAGE_PIN C15 [get_ports {load[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {load[1]}]