MIME-Version: 1.0
Date: Mon, 6 Jul 2015 17:54:35 +0530
Message-ID: <CANXi7D22CPWQSG74VtCAD0ni4V8eSO2dggQHMx9R7JPGGo=8fQ@...278...>
From: Arun Kumar <mailinform@...277...>
Subject: [Openvpn-devel] Why TCP connection closed error comes?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,
I installed openvpn and try to create a tap connection.
So, host1 and host2 both have br0 interface and tap0.
I created certificates as described and put it in /etc/openvpn dir.

When i run openvpn at both server and client side,
it shows following error,

Mon Jul  6 18:05:36 2015 TCPv4_CLIENT link local: [undef]
Mon Jul  6 18:05:36 2015 TCPv4_CLIENT link remote: [AF_INET]10.114.14.190:1194
Mon Jul  6 18:05:36 2015 Connection reset, restarting [0]
Mon Jul  6 18:05:36 2015 TCP/UDP: Closing socket
Mon Jul  6 18:05:36 2015 SIGUSR1[soft,connection-reset] received,
process restarting
Mon Jul  6 18:05:36 2015 Restart pause, 5 second(s)
Mon Jul  6 18:05:41 2015 NOTE: OpenVPN 2.1 requires '--script-security
2' or higher to call user-defined scripts or executables
Mon Jul  6 18:05:41 2015 Re-using SSL/TLS context
Mon Jul  6 18:05:41 2015 Control Channel MTU parms [ L:1575 D:168
EF:68 EB:0 ET:0 EL:0 ]
Mon Jul  6 18:05:41 2015 Socket Buffers: R=[87380->131072] S=[16384->131072]
Mon Jul  6 18:05:41 2015 Data Channel MTU parms [ L:1575 D:1450 EF:43
EB:4 ET:32 EL:0 ]
Mon Jul  6 18:05:41 2015 Local Options hash (VER=V4): '8a6c6b5b'
Mon Jul  6 18:05:41 2015 Expected Remote Options hash (VER=V4): '47106f19'
Mon Jul  6 18:05:41 2015 Attempting to establish TCP connection with
[AF_INET]10.114.14.190:1194 [nonblock]
Mon Jul  6 18:05:42 2015 TCP connection established with
[AF_INET]10.114.14.190:1194
Mon Jul  6 18:05:42 2015 TCPv4_CLIENT link local: [undef]
Mon Jul  6 18:05:42 2015 TCPv4_CLIENT link remote: [AF_INET]10.114.14.190:1194
Mon Jul  6 18:05:42 2015 Connection reset, restarting [0]


What is the problem and why it comes?.

Thanks,
Kumar raj

