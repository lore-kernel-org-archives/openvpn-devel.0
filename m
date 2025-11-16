From: Gert Doering <gert@...1296...>
Date: Sun, 16 Nov 2025 19:33:30 +0100
Message-ID: <20251116183336.11447-1-gert@...1296...>
In-Reply-To: <gerrit.1761324750000.I34584f695ddca3b3e1f2bbcb4380ac91b09c1c8d@...2715...>
References: <gerrit.1761324750000.I34584f695ddca3b3e1f2bbcb4380ac91b09c1c8d@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] ssl: Fix conversion warning in
 tls_prepend_opcode_v1
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

From: Frank Lichtenheld <frank@...2641...>

Document assumption with ASSERT.

Change-Id: I34584f695ddca3b3e1f2bbcb4380ac91b09c1c8d
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1298
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1298
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index eb5c4fc..7b93ebc 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3970,24 +3970,24 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 tls_prepend_opcode_v1(const struct tls_multi *multi, struct buffer *buf)
 {
     struct key_state *ks = multi->save_ks;
-    uint8_t op;
 
     msg(D_TLS_DEBUG, __func__);
 
     ASSERT(ks);
+    ASSERT(ks->key_id <= P_KEY_ID_MASK);
 
-    op = (P_DATA_V1 << P_OPCODE_SHIFT) | ks->key_id;
+    uint8_t op = (P_DATA_V1 << P_OPCODE_SHIFT) | (uint8_t)ks->key_id;
     ASSERT(buf_write_prepend(buf, &op, 1));
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 tls_prepend_opcode_v2(const struct tls_multi *multi, struct buffer *buf)
 {

