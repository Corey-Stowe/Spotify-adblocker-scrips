# Run this script as root 

import time 
from datetime import datetime as dt 

# change hosts path according to your OS 
hosts_path = "/private/etc/hosts"
# localhost's IP 
redirect = "0.0.0.0"

# websites That you want to block 
website_list =
["adclick.g.doublecklick.net","googleads.g.doubleclick.net",
     "http://www.googleadservices.com","pubads.g.doubleclick.net",
     "securepubads.g.doubleclick.net","pagead2.googlesyndication.com",
     "spclient.wg.spotify.com","audio2.spotify.com",
     "upgrade.spotify.com", "www.spotify-desktop.com",
     "sto3-accesspoint-a88.sto3.spotify.net","upgrade.scdn.co",
     "prod.spotify.map.fastlylb.net"]
while True: 

	# time of your work 
	if dt(dt.now().year, dt.now().month, dt.now().day,8) 
	< dt.now() < dt(dt.now().year, dt.now().month, dt.now().day,16): 
		print("Working hours...") 
		with open(hosts_path, 'r+') as file: 
			content = file.read() 
			for website in website_list: 
				if website in content: 
					pass
				else: 
					# mapping hostnames to your localhost IP address 
					file.write(redirect + " " + website + "\n") 
	else: 
		with open(hosts_path, 'r+') as file: 
			content=file.readlines() 
			file.seek(0) 
			for line in content: 
				if not any(website in line for website in website_list): 
					file.write(line) 

			# removing hostnmes from host file 
			file.truncate() 

		print("Fun hours...") 
	time.sleep(5) 
