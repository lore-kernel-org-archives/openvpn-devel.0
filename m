Message-ID: <3F9C22EC.2060507@...61...>
From: Julien TOUCHE <julien.touche@...61...>
MIME-Version: 1.0
Subject: [Openvpn-devel] tcp vpn
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sun Oct 26 11:44:04 2003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello

i've setup a vpn between
linux 2.4 <-> winxp (1.5b12 both)
tcp-server -  tcp-client

works well
but it seems that when the client stops, the server died

Sun Oct 26 18:53:50 2003 0: OpenVPN 1.5_beta12 i586-pc-linux-gnu [SSL]
[LZO] built on Oct 14 2003
Sun Oct 26 18:53:50 2003 1: Static Encrypt: Cipher 'BF-CBC' initialized
with 128 bit key
Sun Oct 26 18:53:50 2003 2: Static Encrypt: Using 160 bit message digest
'SHA1' for HMAC authentication
Sun Oct 26 18:53:50 2003 3: Static Decrypt: Cipher 'BF-CBC' initialized
with 128 bit key
Sun Oct 26 18:53:50 2003 4: Static Decrypt: Using 160 bit message digest
'SHA1' for HMAC authentication
Sun Oct 26 18:53:50 2003 5: LZO compression initialized
Sun Oct 26 18:53:50 2003 6: TUN/TAP device tun9 opened
Sun Oct 26 18:53:50 2003 7: /sbin/ifconfig tun9 10.0.2.5 pointopoint
10.0.2.6 mtu 1500
Sun Oct 26 18:53:50 2003 8: Data Channel MTU parms [ L:1547 D:1547 EF:47
EB:19 ET:0 ]
Sun Oct 26 18:53:50 2003 9: Local Options hash (VER=V3): '282853c2'
Sun Oct 26 18:53:50 2003 10: Expected Remote Options hash (VER=V3):
'30cfa287'
Sun Oct 26 18:53:50 2003 11: GID set to nogroup
Sun Oct 26 18:53:50 2003 12: UID set to nobody
Sun Oct 26 18:53:50 2003 13: Listening for incoming TCP connection on
[undef]:16889
Sun Oct 26 18:53:51 2003 14: TCP connection established with
129.129.200.79:2873
Sun Oct 26 18:53:51 2003 15: TCPv4_SERVER link local (bound): [undef]:16889
Sun Oct 26 18:53:51 2003 16: TCPv4_SERVER link remote: 129.129.200.79:2873
Sun Oct 26 18:53:51 2003 17: Peer Connection Initiated with
129.129.200.79:2873
Sun Oct 26 18:54:20 2003 18: Connection reset, restarting [-1]
Sun Oct 26 18:54:20 2003 19: Closing TCP/UDP socket
Sun Oct 26 18:54:20 2003 20: Closing TUN/TAP device
Sun Oct 26 18:54:20 2003 21: OpenVPN 1.5_beta12 i586-pc-linux-gnu [SSL]
[LZO] built on Oct 14 2003
Sun Oct 26 18:54:20 2003 22: Static Encrypt: Cipher 'BF-CBC' initialized
with 128 bit key
Sun Oct 26 18:54:20 2003 23: Static Encrypt: Using 160 bit message
digest 'SHA1' for HMAC authentication
Sun Oct 26 18:54:20 2003 24: Static Decrypt: Cipher 'BF-CBC' initialized
with 128 bit key
Sun Oct 26 18:54:20 2003 25: Static Decrypt: Using 160 bit message
digest 'SHA1' for HMAC authentication
Sun Oct 26 18:54:20 2003 26: LZO compression initialized
Sun Oct 26 18:54:20 2003 27: Note: Cannot open TUN/TAP dev /dev/net/tun:
Permission denied (errno=13)
Sun Oct 26 18:54:20 2003 28: Note: Attempting fallback to kernel 2.2
TUN/TAP interface
Sun Oct 26 18:54:20 2003 29: Cannot open TUN/TAP dev /dev/tun9: No such
file or directory (errno=2)
Sun Oct 26 18:54:20 2003 30: Exiting


nothing have changed, and i need to reboot openvpn at hand.
and it works
ideas ?

one side question, multiple route are supported in config file, right ?

regards

		Julien

note: i have also test a link with udp but i get this
Sun Oct 26 16:48:13 2003 119: UDPv4 link local (bound): [undef]:16889
Sun Oct 26 16:48:13 2003 120: UDPv4 link remote: 129.129.200.79:16889
WWWWWWWWRSun Oct 26 16:49:31 2003 121: Peer Connection Initiated with
129.129.200.79:16889
WRWWRWWRWWRWSun Oct 26 16:50:13 2003 122: NOTE: failed to obtain options
consistency info from peer -- this could occur if the remote peer is
running a version of OpenVPN before 1.5-beta8 or if there is a network
connectivity problem, and will not necessarily prevent OpenVPN from
running (300 bytes received from peer, 84 bytes authenticated data
channel traffic) -- you can disable the options consistency check with
--disable-occ.
RWRWrWrWRWRwrWRwrWRWrWRwrWRwrWRWRWRWRWRWR

and ping doesn't work.






