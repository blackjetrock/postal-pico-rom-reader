EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L ajm:2364 U1
U 1 1 63BB1BC9
P 3500 2450
F 0 "U1" H 3550 2625 50  0000 C CNN
F 1 "2364" H 3550 2534 50  0000 C CNN
F 2 "Package_DIP:DIP-24_W15.24mm" H 3500 2450 50  0001 C CNN
F 3 "" H 3500 2450 50  0001 C CNN
	1    3500 2450
	1    0    0    -1  
$EndComp
Text Notes 3700 1825 0    50   ~ 0
Pin 21 is A12 or CS\ndepending on whether ROM\nis 2332 or 2364
$Comp
L rp2040:Pico U2
U 1 1 63BB3827
P 7875 2900
F 0 "U2" H 7875 4115 50  0000 C CNN
F 1 "Pico" H 7875 4024 50  0000 C CNN
F 2 "rp2040:RPi_Pico_SMD_TH" V 7875 2900 50  0001 C CNN
F 3 "" H 7875 2900 50  0001 C CNN
	1    7875 2900
	1    0    0    -1  
$EndComp
Text GLabel 7175 1950 0    50   Input ~ 0
D0
Text GLabel 7175 2050 0    50   Input ~ 0
D1
Text GLabel 7175 2250 0    50   Input ~ 0
D2
Text GLabel 7175 2350 0    50   Input ~ 0
D3
Text GLabel 7175 2450 0    50   Input ~ 0
D4
Text GLabel 7175 2550 0    50   Input ~ 0
D5
Text GLabel 7175 2750 0    50   Input ~ 0
D6
Text GLabel 7175 2850 0    50   Input ~ 0
D7
Text GLabel 8575 3850 2    50   Input ~ 0
A8
Text GLabel 8575 3750 2    50   Input ~ 0
A9
Text GLabel 8575 3550 2    50   Input ~ 0
A10
Text GLabel 8575 3450 2    50   Input ~ 0
A11
Text GLabel 8575 3350 2    50   Input ~ 0
A12
Text GLabel 8575 3250 2    50   Input ~ 0
CS1
Text GLabel 2700 3300 0    50   Input ~ 0
D0
Text GLabel 2700 3400 0    50   Input ~ 0
D1
Text GLabel 2700 3500 0    50   Input ~ 0
D2
Text GLabel 4375 3600 2    50   Input ~ 0
D3
Text GLabel 4375 3500 2    50   Input ~ 0
D4
Text GLabel 4375 3400 2    50   Input ~ 0
D5
Text GLabel 4375 3300 2    50   Input ~ 0
D6
Text GLabel 4375 3200 2    50   Input ~ 0
D7
$Comp
L power:GND #PWR0101
U 1 1 63BB7683
P 3075 3675
F 0 "#PWR0101" H 3075 3425 50  0001 C CNN
F 1 "GND" H 3080 3502 50  0000 C CNN
F 2 "" H 3075 3675 50  0001 C CNN
F 3 "" H 3075 3675 50  0001 C CNN
	1    3075 3675
	1    0    0    -1  
$EndComp
Wire Wire Line
	3075 3675 3075 3600
Wire Wire Line
	3075 3600 3150 3600
Text GLabel 7175 3850 0    50   Input ~ 0
A7
Text GLabel 7175 3750 0    50   Input ~ 0
A6
Text GLabel 7175 3550 0    50   Input ~ 0
A5
Text GLabel 7175 3450 0    50   Input ~ 0
A4
Text GLabel 7175 3350 0    50   Input ~ 0
A3
Text GLabel 7175 3250 0    50   Input ~ 0
A2
Text GLabel 7175 3050 0    50   Input ~ 0
A1
Text GLabel 7175 2950 0    50   Input ~ 0
A0
Text GLabel 2700 2500 0    50   Input ~ 0
A7
Text GLabel 2700 2600 0    50   Input ~ 0
A6
Text GLabel 2700 2700 0    50   Input ~ 0
A5
Text GLabel 2700 2800 0    50   Input ~ 0
A4
Text GLabel 2700 2900 0    50   Input ~ 0
A3
Text GLabel 2700 3000 0    50   Input ~ 0
A2
Text GLabel 2700 3100 0    50   Input ~ 0
A1
Text GLabel 2700 3200 0    50   Input ~ 0
A0
Text GLabel 4375 2600 2    50   Input ~ 0
A8
Text GLabel 4375 2700 2    50   Input ~ 0
A9
Text GLabel 4375 3000 2    50   Input ~ 0
A10
Text GLabel 4375 3100 2    50   Input ~ 0
A11
Text GLabel 4375 2800 2    50   Input ~ 0
A12
Text GLabel 4375 2900 2    50   Input ~ 0
CS1
Text GLabel 8575 1950 2    50   Input ~ 0
VCC
Text GLabel 4875 2500 2    50   Input ~ 0
VCC
$Comp
L Device:R_Small R1
U 1 1 63BBA30E
P 2950 2500
F 0 "R1" V 2754 2500 50  0000 C CNN
F 1 "R_Small" V 2845 2500 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" H 2950 2500 50  0001 C CNN
F 3 "~" H 2950 2500 50  0001 C CNN
	1    2950 2500
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R2
U 1 1 63BBA8C7
P 2950 2600
F 0 "R2" V 2754 2600 50  0000 C CNN
F 1 "R_Small" V 2845 2600 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" H 2950 2600 50  0001 C CNN
F 3 "~" H 2950 2600 50  0001 C CNN
	1    2950 2600
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R3
U 1 1 63BBB540
P 2950 2700
F 0 "R3" V 2754 2700 50  0000 C CNN
F 1 "R_Small" V 2845 2700 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" H 2950 2700 50  0001 C CNN
F 3 "~" H 2950 2700 50  0001 C CNN
	1    2950 2700
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R4
U 1 1 63BBB546
P 2950 2800
F 0 "R4" V 2754 2800 50  0000 C CNN
F 1 "R_Small" V 2845 2800 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" H 2950 2800 50  0001 C CNN
F 3 "~" H 2950 2800 50  0001 C CNN
	1    2950 2800
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R5
U 1 1 63BBC5BC
P 2950 2900
F 0 "R5" V 2754 2900 50  0000 C CNN
F 1 "R_Small" V 2845 2900 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" H 2950 2900 50  0001 C CNN
F 3 "~" H 2950 2900 50  0001 C CNN
	1    2950 2900
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R6
U 1 1 63BBC5C2
P 2950 3000
F 0 "R6" V 2754 3000 50  0000 C CNN
F 1 "R_Small" V 2845 3000 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" H 2950 3000 50  0001 C CNN
F 3 "~" H 2950 3000 50  0001 C CNN
	1    2950 3000
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R7
U 1 1 63BBC5C8
P 2950 3100
F 0 "R7" V 2754 3100 50  0000 C CNN
F 1 "R_Small" V 2845 3100 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" H 2950 3100 50  0001 C CNN
F 3 "~" H 2950 3100 50  0001 C CNN
	1    2950 3100
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R8
U 1 1 63BBC5CE
P 2950 3200
F 0 "R8" V 2754 3200 50  0000 C CNN
F 1 "R_Small" V 2845 3200 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" H 2950 3200 50  0001 C CNN
F 3 "~" H 2950 3200 50  0001 C CNN
	1    2950 3200
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R9
U 1 1 63BBD5A4
P 2950 3300
F 0 "R9" V 2754 3300 50  0000 C CNN
F 1 "R_Small" V 2845 3300 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" H 2950 3300 50  0001 C CNN
F 3 "~" H 2950 3300 50  0001 C CNN
	1    2950 3300
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R10
U 1 1 63BBD5AA
P 2950 3400
F 0 "R10" V 2754 3400 50  0000 C CNN
F 1 "R_Small" V 2845 3400 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" H 2950 3400 50  0001 C CNN
F 3 "~" H 2950 3400 50  0001 C CNN
	1    2950 3400
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R11
U 1 1 63BBD5B0
P 2950 3500
F 0 "R11" V 2754 3500 50  0000 C CNN
F 1 "R_Small" V 2845 3500 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" H 2950 3500 50  0001 C CNN
F 3 "~" H 2950 3500 50  0001 C CNN
	1    2950 3500
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R12
U 1 1 63BC2B80
P 4175 2600
F 0 "R12" V 3979 2600 50  0000 C CNN
F 1 "R_Small" V 4070 2600 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" H 4175 2600 50  0001 C CNN
F 3 "~" H 4175 2600 50  0001 C CNN
	1    4175 2600
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R13
U 1 1 63BC2B86
P 4175 2700
F 0 "R13" V 3979 2700 50  0000 C CNN
F 1 "R_Small" V 4070 2700 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" H 4175 2700 50  0001 C CNN
F 3 "~" H 4175 2700 50  0001 C CNN
	1    4175 2700
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R14
U 1 1 63BC2B8C
P 4175 2800
F 0 "R14" V 3979 2800 50  0000 C CNN
F 1 "R_Small" V 4070 2800 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" H 4175 2800 50  0001 C CNN
F 3 "~" H 4175 2800 50  0001 C CNN
	1    4175 2800
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R15
U 1 1 63BC2B92
P 4175 2900
F 0 "R15" V 3979 2900 50  0000 C CNN
F 1 "R_Small" V 4070 2900 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" H 4175 2900 50  0001 C CNN
F 3 "~" H 4175 2900 50  0001 C CNN
	1    4175 2900
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R16
U 1 1 63BC2B98
P 4175 3000
F 0 "R16" V 3979 3000 50  0000 C CNN
F 1 "R_Small" V 4070 3000 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" H 4175 3000 50  0001 C CNN
F 3 "~" H 4175 3000 50  0001 C CNN
	1    4175 3000
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R17
U 1 1 63BC2B9E
P 4175 3100
F 0 "R17" V 3979 3100 50  0000 C CNN
F 1 "R_Small" V 4070 3100 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" H 4175 3100 50  0001 C CNN
F 3 "~" H 4175 3100 50  0001 C CNN
	1    4175 3100
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R18
U 1 1 63BC2BA4
P 4175 3200
F 0 "R18" V 3979 3200 50  0000 C CNN
F 1 "R_Small" V 4070 3200 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" H 4175 3200 50  0001 C CNN
F 3 "~" H 4175 3200 50  0001 C CNN
	1    4175 3200
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R19
U 1 1 63BC2BAA
P 4175 3300
F 0 "R19" V 3979 3300 50  0000 C CNN
F 1 "R_Small" V 4070 3300 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" H 4175 3300 50  0001 C CNN
F 3 "~" H 4175 3300 50  0001 C CNN
	1    4175 3300
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R20
U 1 1 63BC2BB0
P 4175 3400
F 0 "R20" V 3979 3400 50  0000 C CNN
F 1 "R_Small" V 4070 3400 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" H 4175 3400 50  0001 C CNN
F 3 "~" H 4175 3400 50  0001 C CNN
	1    4175 3400
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R21
U 1 1 63BC2BB6
P 4175 3500
F 0 "R21" V 3979 3500 50  0000 C CNN
F 1 "R_Small" V 4070 3500 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" H 4175 3500 50  0001 C CNN
F 3 "~" H 4175 3500 50  0001 C CNN
	1    4175 3500
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R22
U 1 1 63BC2BBC
P 4175 3600
F 0 "R22" V 3979 3600 50  0000 C CNN
F 1 "R_Small" V 4070 3600 50  0000 C CNN
F 2 "Resistor_SMD:R_0805_2012Metric_Pad1.20x1.40mm_HandSolder" H 4175 3600 50  0001 C CNN
F 3 "~" H 4175 3600 50  0001 C CNN
	1    4175 3600
	0    1    1    0   
$EndComp
Wire Wire Line
	3950 2500 4875 2500
Wire Wire Line
	2700 2500 2850 2500
Wire Wire Line
	2700 2600 2850 2600
Wire Wire Line
	2700 2700 2850 2700
Wire Wire Line
	2700 2800 2850 2800
Wire Wire Line
	2700 2900 2850 2900
Wire Wire Line
	2700 3000 2850 3000
Wire Wire Line
	2700 3100 2850 3100
Wire Wire Line
	2700 3200 2850 3200
Wire Wire Line
	2700 3300 2850 3300
Wire Wire Line
	2700 3400 2850 3400
Wire Wire Line
	2700 3500 2850 3500
Wire Wire Line
	3950 2600 4075 2600
Wire Wire Line
	3950 2700 4075 2700
Wire Wire Line
	3950 2800 4075 2800
Wire Wire Line
	3950 2900 4075 2900
Wire Wire Line
	3950 3000 4075 3000
Wire Wire Line
	3950 3100 4075 3100
Wire Wire Line
	3950 3200 4075 3200
Wire Wire Line
	3950 3300 4075 3300
Wire Wire Line
	3950 3400 4075 3400
Wire Wire Line
	3950 3500 4075 3500
Wire Wire Line
	3950 3600 4075 3600
Wire Wire Line
	3050 2500 3150 2500
Wire Wire Line
	3050 2600 3150 2600
Wire Wire Line
	3050 2700 3150 2700
Wire Wire Line
	3050 2800 3150 2800
Wire Wire Line
	3050 2900 3150 2900
Wire Wire Line
	3050 3000 3150 3000
Wire Wire Line
	3050 3100 3150 3100
Wire Wire Line
	3050 3200 3150 3200
Wire Wire Line
	3050 3300 3150 3300
Wire Wire Line
	3050 3400 3150 3400
Wire Wire Line
	3050 3500 3150 3500
Wire Wire Line
	4275 2600 4375 2600
Wire Wire Line
	4275 2700 4375 2700
Wire Wire Line
	4275 2800 4375 2800
Wire Wire Line
	4275 2900 4375 2900
Wire Wire Line
	4275 3000 4375 3000
Wire Wire Line
	4275 3100 4375 3100
Wire Wire Line
	4275 3200 4375 3200
Wire Wire Line
	4275 3300 4375 3300
Wire Wire Line
	4275 3400 4375 3400
Wire Wire Line
	4275 3500 4375 3500
Wire Wire Line
	4275 3600 4375 3600
$Comp
L Connector:Conn_01x03_Female J1
U 1 1 63BD2BBE
P 7875 4700
F 0 "J1" V 7721 4848 50  0000 L CNN
F 1 "Conn_01x03_Female" V 7812 4848 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical" H 7875 4700 50  0001 C CNN
F 3 "~" H 7875 4700 50  0001 C CNN
	1    7875 4700
	0    1    1    0   
$EndComp
Wire Wire Line
	7775 4050 7775 4500
Wire Wire Line
	7875 4050 7875 4500
Wire Wire Line
	7975 4500 7975 4050
$Comp
L power:GND #PWR0102
U 1 1 63BD9A4B
P 6700 4075
F 0 "#PWR0102" H 6700 3825 50  0001 C CNN
F 1 "GND" H 6705 3902 50  0000 C CNN
F 2 "" H 6700 4075 50  0001 C CNN
F 3 "" H 6700 4075 50  0001 C CNN
	1    6700 4075
	1    0    0    -1  
$EndComp
Wire Wire Line
	7175 2150 6700 2150
Wire Wire Line
	6700 2150 6700 2650
Wire Wire Line
	7175 3650 6700 3650
Connection ~ 6700 3650
Wire Wire Line
	6700 3650 6700 4075
Wire Wire Line
	7175 3150 6700 3150
Connection ~ 6700 3150
Wire Wire Line
	6700 3150 6700 3650
Wire Wire Line
	7175 2650 6700 2650
Connection ~ 6700 2650
Wire Wire Line
	6700 2650 6700 3150
$Comp
L power:GND #PWR0103
U 1 1 63BDF9EC
P 9275 4050
F 0 "#PWR0103" H 9275 3800 50  0001 C CNN
F 1 "GND" H 9280 3877 50  0000 C CNN
F 2 "" H 9275 4050 50  0001 C CNN
F 3 "" H 9275 4050 50  0001 C CNN
	1    9275 4050
	1    0    0    -1  
$EndComp
Wire Wire Line
	8575 3650 9275 3650
Wire Wire Line
	9275 3650 9275 4050
Wire Wire Line
	9275 3150 9275 3650
Connection ~ 9275 3650
Wire Wire Line
	8575 2150 9275 2150
Wire Wire Line
	9275 2150 9275 2650
Connection ~ 9275 3150
Wire Wire Line
	8575 2650 9275 2650
Connection ~ 9275 2650
Wire Wire Line
	9275 2650 9275 3150
Wire Wire Line
	8575 3150 9275 3150
$EndSCHEMATC
