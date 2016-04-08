# Patient-Monitor-Demo
GUI development for data acquisition and storage of location and health data of patients in a hospital, for remote monitoring
---------------------------------------------------------------------------------------------------------
PUBLICATION: Published in the Advances In Intelligent Systems & Computing (AISC) book series of Springer.
WIRELESS SENSOR NETWORK BASED PATIENT HEALTH MONITORING AND TRACKING SYSTEM
---------------------------------------------------------------------------------------------------------
Read Me
WIRELESS SENSOR NETWORK BASED PATIENT HEALTH MONITORING AND TRACKING SYSTEM
Submitted By:
Amitabh Yadav (B.Tech. EE 3rd Year 2013-17)
University of Petroleum and Energy Studies, Dehradun (INDIA)

Mentored By:
Mr. Vivek Kaundal (Dept. of Electronics, Instrumentation and Control Engineering, UPES, Dehradun)
Mr. Abhishek Sharma (Dept. of Electronics, Instrumentation and Control Engineering, UPES, Dehradun)

Software Installation (For windows x86 and 64-bit)
1. Install Matlab.
2. Copy the files phm.m and phm.fig in the 'bin' folder.
3. Launch Matlab as Administrator. This is important, as in certain systems, due to limited user rights the software does not allow to write (create database) a file in C:\ drive
4. In the command window, type: 
>>edit phm.m
On line number 84, change the COM port number, as identified by your system. (you need to install the drivers for serial-to-TTL converter to identify the COM port)
save and close the file
5. In the command window, type:
>>phm
6. GUI launches.
7. Click "Connect" to begin sampling data.

--END--
Thankyou.
--
This project is developed under the RISE initiative by UPES. We heartily acknowledge and thank UPES for its support to develop the prototype of the system.
