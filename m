From: Nielsen <nielsen@...505...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030600020107080405070506"
Message-Id: <20051125055507.4638B70DD66@...506...>
Subject: [Openvpn-devel] [PATCH] Openvpn --pass-tos on FreeBSD
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
Date: Thu Nov 24 21:42:00 2005
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------030600020107080405070506
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

The attached patch makes the --pass-tos option work on FreeBSD. If
included in OpenVPN a configure test would probably be necessary.

This is one of several things we modified in OpenVPN while evaluating it
for deployment. Thought I'd share the fixes.

Cheers,
Nate Nielsen

--------------030600020107080405070506
Content-Type: text/x-patch;
 name="openvpn-tos-freebsd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="openvpn-tos-freebsd.patch"

diff -U3 ../openvpn-2.0.orig/socket.h ./socket.h
--- ../openvpn-2.0.orig/socket.h	Sun Apr 10 21:43:58 2005
+++ ./socket.h	Tue Aug  9 16:47:40 2005
@@ -748,7 +755,11 @@
 link_socket_set_tos (struct link_socket *ls)
 {
   if (ls && ls->ptos_defined)
-    setsockopt (ls->sd, IPPROTO_IP, IP_TOS, &ls->ptos, sizeof (ls->ptos));
+    {
+      int tos = ls->ptos;
+      setsockopt (ls->sd, IPPROTO_IP, IP_TOS, &tos, sizeof (tos));
+    }
+
 }
 
 #endif


--------------030600020107080405070506--


