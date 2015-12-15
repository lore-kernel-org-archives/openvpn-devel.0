From: samuli@...515...
Date: Tue, 15 Dec 2015 16:40:32 +0200
Message-Id: <1450190432-23460-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Updates to Changes.rst
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

From: Samuli Sepp=C3=A4nen <samuli@...515...>

This patch is for the "master" branch

Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 Changes.rst | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 41629bd..61e1e59 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -1,10 +1,13 @@
-Version 2.4.0
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
+Overview of changes in 2.4
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
=20
 New features
 ------------
=20
+Windows DNS leak fix
+    This feature allows blocking all out-of-tunnel communication on TCP/UD=
P port
+    53 (except for OpenVPN itself), preventing DNS Leaks on Windows 8.1 an=
d 10.
+
 keying-material-exporter
     Keying Material Exporter [RFC-5705] allow additional keying material t=
o be
     derived from existing TLS channel.
@@ -34,18 +37,16 @@ LZ4 Compression
     compression.
=20
=20
-User-visible Changes
---------------------
+Behavioral changes
+------------------
 - proto udp and proto tcp specify to use IPv4 and IPv6. The new
   options proto udp4 and tcp4 specify to use IPv4 only.
=20
 - connect-timeout specifies now the timeout until the first TLS packet
   is received (identical to server-poll-timeout) and this timeout now
-  includes the removed socks proxy timeout and http proxy timeout.
-
-  In --static mode connect-timeout specifies the timeout for TCP and
-  proxy connection establishment
-
+  includes the removed socks proxy timeout and http proxy timeout. In --st=
atic
+  mode connect-timeout specifies the timeout for TCP and proxy connection
+  establishment
=20
 - connect-retry now specifies the maximum number of unsucessfully
   trying all remote/connection entries before exiting.
--=20
2.1.0


