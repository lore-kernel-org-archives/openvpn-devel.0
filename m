From: Gert Doering <gert@...1296...>
Date: Mon,  9 Dec 2024 20:49:57 +0100
Message-ID: <20241209194957.358-1-gert@...1296...>
In-Reply-To: <gerrit.1733766865000.If472398d4ff8323de485f084a07160b365dfc501@...2715...>
References: <gerrit.1733766865000.If472398d4ff8323de485f084a07160b365dfc501@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Fix memory leak in ntlm_support
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

Not really important but prevents running the NTLM
t_client tests with ASAN enabled.

Change-Id: If472398d4ff8323de485f084a07160b365dfc501
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Lev Stipakov <lstipakov@...277...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/826
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@...277...>

        
diff --git a/tests/ntlm_support.c b/tests/ntlm_support.c
index ccf8962..18d555a 100644
--- a/tests/ntlm_support.c
+++ b/tests/ntlm_support.c
@@ -33,11 +33,11 @@
 int
 main(void)
 {
-#if defined(ENABLE_CRYPTO_OPENSSL)
-    crypto_load_provider("legacy");
-    crypto_load_provider("default");
-#endif
 #ifdef NTLM
+#if defined(ENABLE_CRYPTO_OPENSSL)
+    provider_t *legacy = crypto_load_provider("legacy");
+    provider_t *def = crypto_load_provider("default");
+#endif
     if (!md_valid("MD4"))
     {
         msg(M_FATAL, "MD4 not supported");
@@ -46,6 +46,10 @@
     {
         msg(M_FATAL, "MD5 not supported");
     }
+#if defined(ENABLE_CRYPTO_OPENSSL)
+    crypto_unload_provider("legacy", legacy);
+    crypto_unload_provider("default", def);
+#endif
 #else  /* ifdef NTLM */
     msg(M_FATAL, "NTLM support not compiled in");
 #endif

