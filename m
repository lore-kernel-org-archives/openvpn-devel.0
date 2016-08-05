From: Selva Nair <selva.nair@...277...>
Date: Thu,  4 Aug 2016 23:39:54 -0400
Message-Id: <1470368394-2722-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Avoid format specifier %zu for Windows
	compatibility
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/crypto.c      |    4 ++--
 src/openvpn/options.c     |    4 ++--
 src/openvpn/ssl_mbedtls.c |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index d94896c..1236eae 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -738,8 +738,8 @@ crypto_adjust_frame_parameters(struct frame *frame,
 
   frame_add_to_extra_frame (frame, crypto_overhead);
 
-  msg(D_MTU_DEBUG, "%s: Adjusting frame parameters for crypto by %zu bytes",
-      __func__, crypto_overhead);
+  msg(D_MTU_DEBUG, "%s: Adjusting frame parameters for crypto by %d bytes",
+      __func__, (int) crypto_overhead);
 }
 
 size_t
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7e08fcd..e3fa643 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2992,7 +2992,7 @@ calc_options_string_link_mtu(const struct options *o, const struct frame *frame)
 	  o->replay, cipher_kt_mode_ofb_cfb (fake_kt.cipher));
       frame_finalize(&fake_frame, o->ce.link_mtu_defined, o->ce.link_mtu,
             o->ce.tun_mtu_defined, o->ce.tun_mtu);
-      msg (D_MTU_DEBUG, "%s: link-mtu %zu -> %d", __func__, link_mtu,
+      msg (D_MTU_DEBUG, "%s: link-mtu %d -> %d", __func__, (int) link_mtu,
 	  EXPANDED_SIZE (&fake_frame));
       link_mtu = EXPANDED_SIZE (&fake_frame);
     }
@@ -3061,7 +3061,7 @@ options_string (const struct options *o,
    */
 
   buf_printf (&out, ",dev-type %s", dev_type_string (o->dev, o->dev_type));
-  buf_printf (&out, ",link-mtu %zu", calc_options_string_link_mtu(o, frame));
+  buf_printf (&out, ",link-mtu %d", (int) calc_options_string_link_mtu(o, frame));
   buf_printf (&out, ",tun-mtu %d", PAYLOAD_SIZE (frame));
   buf_printf (&out, ",proto %s",  proto_remote (o->ce.proto, remote));
 
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index e20ec02..8a6e260 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1111,8 +1111,8 @@ print_details (struct key_state_ssl * ks_ssl, const char *prefix)
   cert = mbedtls_ssl_get_peer_cert (ks_ssl->ctx);
   if (cert != NULL)
     {
-      openvpn_snprintf (s2, sizeof (s2), ", %zu bit key",
-	  mbedtls_pk_get_bitlen (&cert->pk));
+      openvpn_snprintf (s2, sizeof (s2), ", %d bit key",
+	  (int) mbedtls_pk_get_bitlen (&cert->pk));
     }
 
   msg (D_HANDSHAKE, "%s%s", s1, s2);
-- 
1.7.10.4


