From: "James Yonan" <jim@...41...>
Message-ID: <twig.1063739039.66173@...41...>
In-Reply-To: <946499570EB7294690F512C1EF182F881EB899@...102...>
Subject: [Openvpn-devel] RE: [Openvpn-users] Windows tun driver
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
Date: Tue Sep 16 12:05:06 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Bert Shuler <bshuler@...103...>, James Yonan <jim@...41...>, Inode <inode@...101...>
Cc: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

Bert Shuler <bshuler@...103...> said:

> James:
> Are you aware of a Windows tun project? While most windows users may
> prefer tap, I am interested in the point-to-point nature of the tun
> device. When setting up many routed connections, it seems that each TAP
> connection will use 1 ip and waste 2 others. I can also live without
> broadcast traffic and non-IP protocols.

While I do believe that the majority of Windows users will prefer a tap
interface, I say this simply because in my experience _most_ Windows users
prefer the option that is the easiest to configure.  Once you stop
automatically routing broadcasts and non-IP protocols, then you have to start
doing more configuration on Windows, i.e. setting up WINS servers and clients,
configuring samba differently, etc.

Having said that, I will agree that having a tun driver would be cool, and
that in many if not most circumstances, it is technically a better choice --
it is more scalable, it offers finer gradation of access control, it is more
universal across *nix platforms, etc. -- as long as you don't need to route
non-IP protocols.

The real problem is that very few open source developers are interested in
developing drivers for Windows, so there are not many choices available.  To
my knowledge there are three:  TAP-Win32, CIPE-Win32, and WinPcap, and none of
them provide tun capabilities.

James


