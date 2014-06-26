From: James Bekkema <james@...1918...>
Message-Id: <A1005665-126D-45D5-A6F2-75ED0EAE30FE@...1918...>
Date: Thu, 26 Jun 2014 21:40:39 +1000
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: [Openvpn-devel] [PATCH] Fix socket-flag/TCP_NODELAY on Mac OS X
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi All,

OpenVPN 2.3.4 will currently throw a warning of "NOTE: setsockopt TCP_NODEL=
AY=3D1 failed (No kernel support)=94 when attempting to use the TCP_NODELAY=
 socket option on Mac OS X/Darwin. Kernel support is there, however the req=
uired header file where TCP_NODELAY is defined is not being included. This =
patch simply alters syshead.h to include <netinet/tcp.h> on Darwin platform=
s.


--- src/openvpn/syshead.h.orig	2014-05-01 21:12:22.000000000 +1000
+++ src/openvpn/syshead.h	2014-06-26 17:43:30.000000000 +1000
@@ -349,6 +349,14 @@
=20
 #endif /* TARGET_DRAGONFLY */
=20
+#ifdef TARGET_DARWIN
+
+#ifdef HAVE_NETINET_TCP_H
+#include <netinet/tcp.h>
+#endif
+
+#endif /* TARGET_DARWIN */
+
 #ifdef WIN32
 #include <iphlpapi.h>
 #include <ntddndis.h>


Tested under 10.7 to 10.10dp2. "Socket flags: TCP_NODELAY=3D1 succeeded=94 =
when running with debug enabled. In addition the latest beta version of Vis=
cosity is using a copy of OpenVPN with this patch applied: no issues have b=
een reported from testers thus far.

Regards,
James

--
James Bekkema
SparkLabs Developer
http://www.sparklabs.com
http://www.twitter.com/sparklabs
support@...1918...


