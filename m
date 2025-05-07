From: Walter Doekes <walter.openvpn@...2889...>
Date: Wed,  7 May 2025 09:44:38 +0200
Message-Id: <20250507074438.1326755-1-walter.openvpn@...2889...>
In-Reply-To: <1e8ccfd451cbf9e6d090bd6a6886e366.squirrel@...2890...>
References: <1e8ccfd451cbf9e6d090bd6a6886e366.squirrel@...2890...>
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
To: openvpn-devel@lists.sourceforge.net, Arne Schwabe <arne@...1227...>
Cc: Walter Doekes <walter.openvpn@...2889...>, Walter Doekes <walter+github@...2889...>

From: Walter Doekes <walter+github@...2889...>

When you're connected to a VPN which is used as the default gateway, a
connection to a second VPN will cause a tunnel-in-tunnel traffic. If the
administrator of the second VPN wants to avoid that, by pushing its IP
as net_gateway, this means that the client's source IP switches right
after connect:

  the client source IP switches, from
  - the first-VPN-exit-IP, to the
  - regular-ISP-exit-IP

In openvpn 2.5 and below, this worked fine. Since openvpn 2.6,
specifially b364711486, this triggers the "Disallow float to an address
taken by another client" code. Since that change, the traffic from the
second source IP creates a second connection, which now needs special
handling in the check-floating-IP code.

This change allows one to switch to the new IP, if it is still in an
unconnected state. That makes the use-case mentioned above work again.

Github: closes OpenVPN/openvpn#704
Signed-off-by: Walter Doekes <walter+github@...2889...>
---
 src/openvpn/multi.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index a2d3fd10..51a00b71 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3236,8 +3236,21 @@ multi_process_float(struct multi_context *m, struct multi_instance *mi,
         struct tls_multi *m1 = mi->context.c2.tls_multi;
         struct tls_multi *m2 = ex_mi->context.c2.tls_multi;
 
+        /* if the new connection is fresh and the old one is already connected, this
+         * might be a legitimate move to a new IP by the original client;
+         * for example when the server IP is pushed as net_gateway to escape from
+         * a double VPN. */
+        if (m1->multi_state == CAS_CONNECT_DONE
+            && m2->multi_state == CAS_NOT_CONNECTED
+            && m1->locked_cert_hash_set
+            && !m2->locked_cert_hash_set
+            && session_id_equal(&m1->session[TM_ACTIVE].session_id,
+                          &m2->session[TM_ACTIVE].session_id))
+        {
+            /* allow this case */
+        }
         /* do not float if target address is taken by client with another cert */
-        if (!cert_hash_compare(m1->locked_cert_hash_set, m2->locked_cert_hash_set))
+        else if (!cert_hash_compare(m1->locked_cert_hash_set, m2->locked_cert_hash_set))
         {
             msg(D_MULTI_LOW, "Disallow float to an address taken by another client %s",
                 multi_instance_string(ex_mi, false, &gc));
-- 
2.34.1


