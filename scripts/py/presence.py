#!/usr/bin/env python3
import signal
import sys
from pypresence import Presence
import time
client_id = "842383650418982953"
pid = 9999
todo ="idle"
state =str(sys.argv[1])
details =str(sys.argv[2])
large_image =str(sys.argv[3])
large_text =str(sys.argv[4]) if len(sys.argv) > 7 else "large_text = mpv Media Player"
small_image =str(sys.argv[5])
small_text =str(sys.argv[6]) if len(sys.argv) > 9 else "small_text = Idle"
periodic_timer =15
try:
	RPC = Presence(client_id,pipe=0)
	RPC.connect()
	RPC.update(state=state, details=details, large_image=large_image, large_text=large_text, small_image=small_image, small_text=small_text)
	while True:
		time.sleep(15)
except:
	sys.exit()
