#!/usr/bin/python2.7
# -*- coding: utf-8 -*-


import re
import base64
from termcolor import colored


def banner():
	print colored("""
===============================================================================

#####                          #######           #     #
#     #  ####  #####  #####     #     # ######    #     #   ##    ####  #    #
#       #    # #    # #    #    #     # #         #     #  #  #  #    # #   #
#       #    # #    # #    #    #     # #####     ####### #    # #      ####
#       #    # #####  #####     #     # #         #     # ###### #      #  #
#     # #    # #   #  #         #     # #         #     # #    # #    # #   #
#####   ####  #    # #         ####### #         #     # #    #  ####  #    #

		   ____                             __  __      _
		  |  _ \ _____      _____ _ __     |  \/  | ___| |_ ___ _ __
		  | |_) / _ \ \ /\ / / _ \ '__|____| |\/| |/ _ \ __/ _ \ '__|
		  |  __/ (_) \ V  V /  __/ | |_____| |  | |  __/ ||  __/ |
		  |_|   \___/ \_/\_/ \___|_|       |_|  |_|\___|\__\___|_|





This script  is a PowerShell Command & Script base64 Converter.
===============================================================================
""","cyan")


def powershell_encode(data):
	# blank command will store our fixed unicode variable
	blank_command = ""
	powershell_command = ""
	# Remove weird chars that could have been added by ISE
	n = re.compile(u'(\xef|\xbb|\xbf)')
	# loop through each character and insert null byte
	for char in (n.sub("", data)):
		# insert the nullbyte
		blank_command += char + "\x00"
	# assign powershell command as the new one
	powershell_command = blank_command
	# base64 encode the powershell command
	powershell_command = base64.b64encode(powershell_command)
	return powershell_command

def metasploit():
	print colored("[*]PowerShell command & script convert to base64","yellow")
	choice = raw_input("1 - Convert a command\n2 - Specify PS1 file to convert\n: ")
	if choice == "1":
		ans_command = raw_input("Write your PowerShell command: ")
		final_command = ans_command
	elif choice == "2":
		ans_file = raw_input("Write your PS1 file path: ")
		file = open(ans_file)
		final_command = file.read()
	x = powershell_encode(final_command)
	print colored("\n[*]Наша команда для PowerShell:","yellow")
	print colored("powershell.exe -NoP -NonI -W 1 -Exec Bypass -enc " + x,"red")

banner()
metasploit()
