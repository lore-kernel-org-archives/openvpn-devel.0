From: Christian Hesse <list@...1798...>
Date: Wed, 28 Dec 2016 14:07:21 +0100
Message-Id: <20161228130721.683-1-list@...1798...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/1] fix timeout in non-TLS mode with systemd
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
To: OpenVPN Development <openvpn-devel@lists.sourceforge.net>
Cc: Christian Hesse <mail@...1798...>

From: Christian Hesse <mail@...1798...>

In non-TLS configuration we wait for the remote peer to connect
before issuing "Initialization Sequence Completed". So prevent to
time out by telling systemd service manager we are ready for now.
Status will be "Non-TLS mode, ready for now. Waiting for peer..."
and changes once the remote peer connects.

This fixes #801 (static key tunnels impossible to start via systemd)

Tested-by: Mantas Mikul=C4=97nas <grawity@...277...>
Signed-off-by: Christian Hesse <mail@...1798...>
---
 src/openvpn/openvpn.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 888acda..ae948f9 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -30,6 +30,10 @@
=20
 #include "syshead.h"
=20
+#ifdef ENABLE_SYSTEMD
+#include <systemd/sd-daemon.h>
+#endif
+
 #include "init.h"
 #include "forward.h"
 #include "multi.h"
@@ -73,6 +77,21 @@ tunnel_point_to_point(struct context *c)
         return;
     }
=20
+#ifdef ENABLE_SYSTEMD
+    /* In non-TLS configuration we wait for the remote peer to connect
+     * before issuing "Initialization Sequence Completed". So prevent to
+     * time out by telling systemd service manager we are ready for now.
+     * Status will be "Non-TLS mode, ready for now. Waiting for peer..."
+     * and changes once the remote peer connects. */
+    if (c->options.tls_client =3D=3D false
+        && c->options.tls_server =3D=3D false)
+    {
+        sd_notifyf(0, "READY=3D1\n"
+                   "STATUS=3DNon-TLS mode, ready for now. Waiting for peer=
...\n"
+                   "MAINPID=3D%lu", (unsigned long) getpid());
+    }
+#endif
+
     /* main event loop */
     while (true)
     {
--=20
2.11.0


