MIME-Version: 1.0
From: JuanJo Ciarlante <jjo+ml@...410...>
Date: Thu, 12 Nov 2009 13:46:56 +0100
Message-ID: <7bb795fd0911120446ya4c49ddp3c15f37ee13c3775@...278...>
Subject: [Openvpn-devel] [PATCH] openvpn over ipv6 support v0.4.10,
	rebased to 2.1_rc21
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,
I rebased the latest incarnation of the ipv6 patch (0.4.10)
to openvpn 2.1_rc21 release.

Changes from v0.4.9..v0.4.10:
* All platforms:
 - implemented redirect-gateway support for ipv4 on ipv6 endpoints
 - several src cleanups (no actual code changes)
 - doc updates
* win32:
 - expanded usage of proto_is_udp(), proto_is_tcp()
 - replaced some memset(&obj, 0, sizeof obj) by openvpn's CLEAR(obj)
* openbsd:
 - there's no IFF_MULTICAST, #ifdef'd around it (not specific to ipv6-patch)

Available from my git repo[1], also as patch over 2.1_rc21 [2].
There's also a win32 x-compiled binary (YMMV), built
w/openssl-0.9.8l from source [3].

[1] http://github.com/jjo/openvpn-ipv6/
[2] http://cloud.github.com/downloads/jjo/openvpn-ipv6/openvpn-2.1_rc21-ipv6-0.4.10.uncached.patch.gz
     mehh... there is some staleness in github that keeps serving a
failed 1st upload,
     I temp added the ".uncached"; will let it "drain" and try to
serve the orig filename
     in a few hours.
[3] http://cloud.github.com/downloads/jjo/openvpn-ipv6/openvpn.exe-2.1_rc21-ipv6-0.4.10.zip

-- 
--JuanJo ; echo jAjo@...1263... | sed 's/[SPAM]//g'

