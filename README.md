# webservertest

Script initilize_webserver.sh is a rudamentary script to setup a linux server with nginx and load a default template for a simple webpage
This has been tested on Ubuntu 20.20 and Centos 8 

Script will currently do the following:
1. set the hostname to what is specified in the SERVERNAME variable 
2. install git and nginx, start nginx and enable start on boot
3. clone repo specified in WEBREPO variable and copy template file to index.html in webroot
4. update template file with current hostname and ip address

Future considerations would be to pass server name and repo as an argument and add additional error checking but for the purpose of this exercise and given the requirement to just setup 1 server with a specified hostname, this simpilier option was created.
