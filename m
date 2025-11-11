From: Gert Doering <gert@...1296...>
Date: Tue, 11 Nov 2025 16:32:24 +0100
Message-ID: <20251111153230.29865-1-gert@...1296...>
In-Reply-To: <gerrit.1762529900000.I31024f93d9d9d0f678fb39d4758a7e870bf00873@...2715...>
References: <gerrit.1762529900000.I31024f93d9d9d0f678fb39d4758a7e870bf00873@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] openssl_compat: Avoid conversion warning
 for SSL_get_negotiated_group
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

SSL_get_negotiated_group is documented to return
int and SSL_group_to_name definitely expects an int.

But SSL_get_negotiated_group is actually a macro
implemented by SSL_ctrl, which does return a long.
So to avoid the conversion warning we need the cast.

Change-Id: I31024f93d9d9d0f678fb39d4758a7e870bf00873
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1359
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1359
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index fb3c9b1..b9af132 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -194,21 +194,12 @@
           LIBRESSL_VERSION_NUMBER > 0x3050400fL) */
 
 #if OPENSSL_VERSION_NUMBER < 0x30200000L && OPENSSL_VERSION_NUMBER >= 0x30000000L
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static inline const char *
 SSL_get0_group_name(SSL *s)
 {
-    int nid = SSL_get_negotiated_group(s);
+    int nid = (int)SSL_get_negotiated_group(s);
     return SSL_group_to_name(s, nid);
 }
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
 #endif
 
 /* Introduced in OpenSSL 3.6.0 */

