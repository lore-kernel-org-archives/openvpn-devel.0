Mime-Version: 1.0 (Apple Message framework v552)
From: =?ISO-8859-1?Q?Marc_Br=FCnink?= <mbruen@...487...>
Message-Id: <8ECE85B9-4A29-11DA-9F53-000A959A666C@...487...>
Subject: [Openvpn-devel] [bug report] DOS: openvpn 2.0.2 segfaults on Solaris 9.
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon Oct 31 08:16:20 2005
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi list,

I'm posting this there in case someone already fixed it or is disposed 
to fix it :-)
First of all: OpenVPN is great! Thanks for your work!.
Second of all: I've encounterd a reproducible bug :-(
I'm running
OpenVPN 2.0.2 sparc-sun-solaris2.9 [SSL] [LZO] built on Oct 17 2005
on a
SunOS sun 5.9 Generic_112233-12 sun4u sparc SUNW,Sun-Fire-V240
machine. OpenVPN is running in tcp server mode. Everything works 
perfect unless I do a portscan on this machine. Then OpenVPN simply 
segfaults.
I'm using
nmap -T Aggressive <ipaddress> -p 1194


Mon Oct 31 17:08:03 2005 us=485855 PO_WAIT[0,0] fd=3 rev=0x00000001 
rwflags=0x0001 arg=0x00000001 [scalable]
Mon Oct 31 17:08:03 2005 us=485945 MULTI: REAP range 16 -> 32
Mon Oct 31 17:08:03 2005 us=485973 MULTI: multi_create_instance called
Mon Oct 31 17:08:03 2005 us=486033 PO_INIT maxevents=4 flags=0x00000002
Mon Oct 31 17:08:03 2005 us=486059 Re-using SSL/TLS context
Mon Oct 31 17:08:03 2005 us=486091 MTU DYNAMIC mtu=0, flags=1, 0 -> 140
Mon Oct 31 17:08:03 2005 us=486108 TLS: tls_session_init: entry
Mon Oct 31 17:08:03 2005 us=486221 PID packet_id_init seq_backtrack=0 
time_backtrack=0
Mon Oct 31 17:08:03 2005 us=486364 PID packet_id_init seq_backtrack=0 
time_backtrack=0
Mon Oct 31 17:08:03 2005 us=486398 TLS: tls_session_init: new session 
object, sid=d9b0a377 97bb2ba0
Mon Oct 31 17:08:03 2005 us=486415 TLS: tls_session_init: entry
Mon Oct 31 17:08:03 2005 us=486437 PID packet_id_init seq_backtrack=0 
time_backtrack=0
Mon Oct 31 17:08:03 2005 us=486503 PID packet_id_init seq_backtrack=0 
time_backtrack=0
Mon Oct 31 17:08:03 2005 us=486530 TLS: tls_session_init: new session 
object, sid=e7b0b371 1f6a5f51
Mon Oct 31 17:08:03 2005 us=486558 Control Channel MTU parms [ L:1543 
D:140 EF:40 EB:0 ET:0 EL:0 ]
Mon Oct 31 17:08:03 2005 us=486583 MTU DYNAMIC mtu=1450, flags=2, 1543 
-> 1450
Mon Oct 31 17:08:03 2005 us=486609 Data Channel MTU parms [ L:1543 
D:1450 EF:43 EB:4 ET:0 EL:0 ]
Mon Oct 31 17:08:03 2005 us=486688 Local Options String: 'V4,dev-type 
tun,link-mtu 1543,tun-mtu 1500,proto TCPv4_SERVER,cipher BF-CBC,auth 
SHA1,keysize 128,key-method 2,tls-server'
Mon Oct 31 17:08:03 2005 us=486712 Expected Remote Options String: 
'V4,dev-type tun,link-mtu 1543,tun-mtu 1500,proto TCPv4_CLIENT,cipher 
BF-CBC,auth SHA1,keysize 128,key-method 2,tls-client'
Mon Oct 31 17:08:03 2005 us=486775 Local Options hash (VER=V4): 
'7e068940'
Mon Oct 31 17:08:03 2005 us=486809 Expected Remote Options hash 
(VER=V4): 'db02a8f8'
Mon Oct 31 17:08:03 2005 us=486832 STREAM: RESET
Mon Oct 31 17:08:03 2005 us=486848 STREAM: INIT maxlen=1543
Mon Oct 31 17:08:03 2005 us=486932 TCP: accept(3) failed: Software 
caused connection abort (errno=130)
Mon Oct 31 17:08:03 2005 us=486962 PID packet_id_free
Mon Oct 31 17:08:03 2005 us=487030 PID packet_id_free
Mon Oct 31 17:08:03 2005 us=487048 PID packet_id_free
Mon Oct 31 17:08:03 2005 us=487063 PID packet_id_free
Mon Oct 31 17:08:03 2005 us=487115 PID packet_id_free
Mon Oct 31 17:08:03 2005 us=487130 PID packet_id_free
Mon Oct 31 17:08:03 2005 us=487146 PID packet_id_free
Mon Oct 31 17:08:03 2005 us=487159 PID packet_id_free
Mon Oct 31 17:08:03 2005 us=487179 PID packet_id_free
Mon Oct 31 17:08:03 2005 us=487206 MULTI: multi_close_instance called


If you need further information or need someone to test code -> Drop me 
a line. I would love to see this bug fixed, because it's actually a 
pretty easy DOS and prohibits the use of OpenVPN on a production 
machine.


Many thanks
Marc




