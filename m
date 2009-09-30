From: Marcel =?iso-8859-1?q?Pennewi=DF?= <mailinglists@...1145...>
Date: Wed, 30 Sep 2009 19:41:01 +0200
References: <7bb795fd0909251436v2369d6d5q674e63e0621fcd56@...278...>
In-Reply-To: <7bb795fd0909251436v2369d6d5q674e63e0621fcd56@...278...>
MIME-Version: 1.0
Message-Id: <200909301941.01923.mailinglists@...1145...>
Subject: Re: [Openvpn-devel] [PATCH] openvpn over ipv6 support -v0.4.6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Friday 25 September 2009 23:36:19 JuanJo Ciarlante wrote:
> Hi,
>
> I'm(back) working on openvpn/ipv6 endpoint support, aka udp6/tcp6,
> please refer to README.ipv6[1] and TODO.ipv6[2] for more details.

OpenVPN 2.1-rc19 crashs on Gentoo (Xen DomU, AMD64( using tcp6-server with

Sep 30 19:42:00 larissa openvpn[25441]: Assertion failed at socket.c:1620
Sep 30 19:42:00 larissa openvpn[25441]: Exiting

and segfaulted using "tcp-server"

Sep 30 19:39:09 larissa openvpn[25238]: segfault at 0000000000000002 rip 
00002b3486469fd0 rsp 00007fff254e9c98 error 4
Sep 30 19:39:09 larissa openvpn[25238]: MULTI: multi_create_instance called
Sep 30 19:39:09 larissa openvpn[25238]: Re-using SSL/TLS context
Sep 30 19:39:09 larissa openvpn[25238]: LZO compression initialized
Sep 30 19:39:09 larissa openvpn[25238]: Control Channel MTU parms [ L:1576 
D:140 EF:40 EB:0 ET:0 EL:0 ]
Sep 30 19:39:09 larissa openvpn[25238]: Data Channel MTU parms [ L:1576 D:1450 
EF:44 EB:135 ET:32 EL:0 AF:3/1 ]
Sep 30 19:39:09 larissa openvpn[25238]: Local Options hash 
(VER=V4): '3e6d1056'
Sep 30 19:39:09 larissa openvpn[25238]: Expected Remote Options hash 
(VER=V4): '31fdf004'
Sep 30 19:39:09 larissa openvpn[25238]: TCP connection established with 
[AF_INET]141.24.41.188:60913
Sep 30 19:39:09 larissa openvpn[25238]: Socket Buffers: R=[131072->131072] 
S=[131072->131072]

Any ideas?

Marcel

