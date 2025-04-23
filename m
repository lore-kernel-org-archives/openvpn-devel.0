From: walter.openvpn@...2889...
Date: Wed, 23 Apr 2025 19:58:43 +0200
Message-Id: <20250423175843.104553-1-walter.openvpn@...2889...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] multi.c: Allow floating to a new IP right
 after connection setup
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

From: Walter Doekes <walter+github@...2889...>

When you're connected to a VPN which is used as the default gateway, a
connection to a second VPN will cause a tunnel-in-tunnel. If the
administrator of the second VPN wants to avoid that, by pushing its IP
as net_gateway, this means that the client's source IP switches right
after connect:

  the source IP switches from the first-VPN-exit-IP to the
  regular-ISP-exit-IP

In openvpn 2.5 and below, this worked fine. Since openvpn 2.6, this
triggers the "Disallow float to an address taken by another client"
code. The root cause for this change of behaviour is as of yet
unexplained.

This change allows one to switch to the new IP, if it is still in an
unconnected state. That makes the use-case mentioned above work again.

Github: closes OpenVPN/openvpn#704
---
 src/openvpn/multi.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index a2d3fd10..8a219ef2 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3236,8 +3236,22 @@ multi_process_float(struct multi_context *m, struct multi_instance *mi,
         struct tls_multi *m1 = mi->context.c2.tls_multi;
         struct tls_multi *m2 = ex_mi->context.c2.tls_multi;
 
+	/* if the new connection is fresh and the old one is already connected, this
+	 * might be a legitimate move to a new IP by the original client;
+	 * for example when the server IP is pushed as net_gateway to escape from
+	 * a double VPN. */
+	if (m1->multi_state == CAS_CONNECT_DONE && m2->multi_state == CAS_NOT_CONNECTED
+		&& m1->locked_cert_hash_set && !m2->locked_cert_hash_set)
+        {
+            msg(M_INFO, "peer %" PRIu32 " (%s) floating from %s to %s (m2 still setting up) state=%d/%d",
+                m1->peer_id,
+                tls_common_name(m1, false),
+                mroute_addr_print(&mi->real, &gc),
+                print_link_socket_actual(&m->top.c2.from, &gc),
+                m1->multi_state, m2->multi_state);
+        }
         /* do not float if target address is taken by client with another cert */
-        if (!cert_hash_compare(m1->locked_cert_hash_set, m2->locked_cert_hash_set))
+        else if (!cert_hash_compare(m1->locked_cert_hash_set, m2->locked_cert_hash_set))
         {
             msg(D_MULTI_LOW, "Disallow float to an address taken by another client %s",
                 multi_instance_string(ex_mi, false, &gc));
-- 
2.34.1


