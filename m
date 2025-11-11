From: Gert Doering <gert@...1296...>
Date: Tue, 11 Nov 2025 18:25:23 +0100
Message-ID: <20251111172531.7754-1-gert@...1296...>
In-Reply-To: <gerrit.1761324750000.If3331a2d0477634af077b4c29963dbec6d04e17b@...2715...>
References: <gerrit.1761324750000.If3331a2d0477634af077b4c29963dbec6d04e17b@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] pkcs11: Avoid some conversion warnings
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

Since we translate between different APIs
casts are unavoidable. Make sure they are safe.

Change-Id: If3331a2d0477634af077b4c29963dbec6d04e17b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1296
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1296
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index 9afb181..14118a9 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -53,18 +53,17 @@
 }
 #endif
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static void
-__mysleep(const unsigned long usec)
+__mysleep(unsigned long usec)
 {
 #if defined(_WIN32)
     Sleep(usec / 1000);
 #else
-    usleep(usec);
+    if (usec > UINT_MAX)
+    {
+        usec = UINT_MAX;
+    }
+    usleep((useconds_t)usec);
 #endif
 }
 
@@ -528,7 +527,13 @@
         goto cleanup;
     }
 
-    if (openvpn_base64_encode(certificate_blob, certificate_blob_size, &internal_base64) == -1)
+    if (certificate_blob_size > INT_MAX)
+    {
+        msg(M_WARN, "PKCS#11: Invalid certificate size %zu", certificate_blob_size);
+        goto cleanup;
+    }
+
+    if (openvpn_base64_encode(certificate_blob, (int)certificate_blob_size, &internal_base64) == -1)
     {
         msg(M_WARN, "PKCS#11: Cannot encode certificate");
         goto cleanup;
@@ -563,10 +568,6 @@
     return success;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 int
 tls_ctx_use_pkcs11(struct tls_root_ctx *const ssl_ctx, bool pkcs11_id_management,
                    const char *const pkcs11_id)

