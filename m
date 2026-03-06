From: Gert Doering <gert@...1296...>
Date: Fri,  6 Mar 2026 17:30:04 +0100
Message-ID: <20260306163010.2437-1-gert@...1296...>
In-Reply-To: <gerrit.1771008284000.Ibc7a6d8c61b9e584bf5d2d13fb5072b7a28fc53b@...2715...>
References: <gerrit.1771008284000.Ibc7a6d8c61b9e584bf5d2d13fb5072b7a28fc53b@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] tls_crypt: Avoid a sign-compare warning
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

We already checked that this isn't negative
so just use a cast.

Change-Id: Ibc7a6d8c61b9e584bf5d2d13fb5072b7a28fc53b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1524
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1524
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index c2b6268..70889dc 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -206,11 +206,6 @@
     return false;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 bool
 tls_crypt_unwrap(const struct buffer *src, struct buffer *dst, struct crypto_options *opt)
 {
@@ -728,7 +723,7 @@
             msg(M_FATAL, "ERROR: failed to base64 decode provided metadata");
             goto cleanup;
         }
-        if (decoded_len > TLS_CRYPT_V2_MAX_METADATA_LEN - 1)
+        if ((unsigned int)decoded_len > TLS_CRYPT_V2_MAX_METADATA_LEN - 1)
         {
             msg(M_FATAL, "ERROR: metadata too long (%d bytes, max %u bytes)", decoded_len,
                 TLS_CRYPT_V2_MAX_METADATA_LEN - 1);
@@ -801,7 +796,3 @@
 
     gc_free(&gc);
 }
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif

