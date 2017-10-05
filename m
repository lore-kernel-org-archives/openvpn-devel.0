From: David Sommerseth <davids@...515...>
Date: Fri,  6 Oct 2017 01:25:42 +0200
Message-Id: <20171005232542.30007-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH] man: Describe --proto options better
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

The --proto options changed a bit in OpenVPN v2.4.  This tries to
expand this section, explaining the new variants and how they
related to older OpenVPN versions.

Signed-off-by: David Sommerseth <davids@...515...>
---
 doc/openvpn.8 | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index a4189ac2..ca4c652e 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -413,10 +413,10 @@ Use protocol
 for communicating with remote host.
 .B p
 can be
-.B udp,
-.B tcp\-client,
+.B udp, udp4, udp6
+.B tcp\-client, tcp4\-client, tcp6\-client,
 or
-.B tcp\-server.
+.B tcp\-server, tcp4\-server, tcp6\-server.
 
 The default protocol is
 .B udp
@@ -445,6 +445,37 @@ option) and try again infinite or up to N retries (adjustable via the
 option).  Both TCP client and server will simulate
 a SIGUSR1 restart signal if either side resets the connection.
 
+When using just
+.B udp
+or
+.B tcp
+(not udp4/udp6/tcp4/tcp6) OpenVPN will deploy a dual-stack approach connecting
+to remote hosts and binding to local interfaces.  If a hostname resolves to
+both an IPv4 and IPv6 address, OpenVPN will most commonly try to connect using
+IPv6 first before trying the IPv4 address; this is decided by the operating
+system's resolver.  To enforce OpenVPN to only use either IPv4 or IPv6, the
+.B udp4/tcp4
+and
+.B udp6/tcp6
+variants needs to be used.
+
+A quick overview of what gives the most similar behaviour between OpenVPN 2.3
+and v2.4.
+
+.nf
+.ft 3
+.in +4
+.B \ OpenVPN 2.3\ \ \ \ \ OpenVPN 2.4
+==============================
+ udp             udp4
+ udp6            udp
+ tcp-server      tcp4-server
+ tcp6-server     tcp-server
+ tcp-client      tcp4-client
+ tcp6-client     tcp-client
+.in -4
+.fi
+
 OpenVPN is designed to operate optimally over UDP, but TCP capability is provided
 for situations where UDP cannot be used.
 In comparison with UDP, TCP will usually be
-- 
2.13.5


