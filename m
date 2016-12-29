From: Christian Hesse <list@...1798...>
Date: Thu, 29 Dec 2016 19:57:27 +0100
Message-Id: <20161229185727.17020-2-list@...1798...>
In-Reply-To: <20161229185727.17020-1-list@...1798...>
References: <20161228185700.GJ78624@...1296...>
	<20161229185727.17020-1-list@...1798...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 2/2] fix timeout in non-TLS mode with
	systemd
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

v2: Rebase on "move systemd specific code to platform.c" (commit
    46e647933030da848774656029c4c4a1f204e2f1).

Tested-by: Mantas Mikul=C4=97nas <grawity@...277...>
Signed-off-by: Christian Hesse <mail@...1798...>
---
 src/openvpn/openvpn.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 888acda..ddcb9ed 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -73,6 +73,18 @@ tunnel_point_to_point(struct context *c)
         return;
     }
=20
+    /* In non-TLS configuration we wait for the remote peer to connect
+     * before issuing "Initialization Sequence Completed". So prevent to
+     * time out by telling systemd service manager we are ready for now.
+     * Status will be "Non-TLS mode, ready for now. Waiting for peer..."
+     * and changes once the remote peer connects. */
+    if (c->options.tls_client =3D=3D false
+        && c->options.tls_server =3D=3D false)
+    {
+        platform_notify("READY=3D1",
+                        "STATUS=3DNon-TLS mode, ready for now. Waiting for=
 peer...");
+    }
+
     /* main event loop */
     while (true)
     {
--=20
2.11.0


