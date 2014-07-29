From: Steffan Karger <steffan@...1856...>
Date: Tue, 29 Jul 2014 22:52:24 +0200
Message-Id: <1406667144-17674-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Fix frame size calculation for non-CBC
	modes.
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

CBC mode is the only mode that OpenVPN supports that needs padding. So,
only include the worst case padding size in the frame size calculation when
using CBC mode.

While doing so, rewrite crypto_adjust_frame_parameters() to be better
readable, and provide debug output (for high debug levels).

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index ef2bde1..2ba8487 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -403,11 +403,27 @@ crypto_adjust_frame_parameters(struct frame *frame,
 			       bool packet_id,
 			       bool packet_id_long_form)
 {
-  frame_add_to_extra_frame (frame,
-			    (packet_id ? packet_id_size (packet_id_long_form) : 0) +
-			    ((cipher_defined && use_iv) ? cipher_kt_iv_size (kt->cipher) : 0) +
-			    (cipher_defined ? cipher_kt_block_size (kt->cipher) : 0) + /* worst case padding expansion */
-			    kt->hmac_length);
+  size_t crypto_overhead = 0;
+
+  if (packet_id)
+    crypto_overhead += packet_id_size (packet_id_long_form);
+
+  if (cipher_defined)
+    {
+      if (use_iv)
+	crypto_overhead += cipher_kt_iv_size (kt->cipher);
+
+      if (cipher_kt_mode_cbc (kt->cipher))
+	/* worst case padding expansion */
+	crypto_overhead += cipher_kt_block_size (kt->cipher);
+    }
+
+  crypto_overhead += kt->hmac_length;
+
+  frame_add_to_extra_frame (frame, crypto_overhead);
+
+  msg(D_MTU_DEBUG, "%s: Adjusting frame parameters for crypto by %zu bytes",
+      __func__, crypto_overhead);
 }
 
 /*
-- 
1.9.1


