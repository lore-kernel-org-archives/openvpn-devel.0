From: Gert Doering <gert@...1296...>
Date: Wed, 11 Sep 2024 12:49:41 +0200
Message-ID: <20240911104941.19429-1-gert@...1296...>
In-Reply-To: <gerrit.1726024745000.I2bfa9ffbd17d0599014d38b2a2fd319766cdb1e3@...2715...>
References: <gerrit.1726024745000.I2bfa9ffbd17d0599014d38b2a2fd319766cdb1e3@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Do not stop reading from file/uri when
 OPENSSL_STORE_load() returns error
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

From: Selva Nair <selva.nair@...277...>

OPENSSL_STORE_load() can error and return NULL even when the file or URI
still has readable objects left.

Fix by iterating until OPENSSL_STORE_eof(). Also clear such errors to avoid
misleading messages printed at the end by crypto_print_openssl_errors().

Change-Id: I2bfa9ffbd17d0599014d38b2a2fd319766cdb1e3
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/742
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 0d845f4..5fd6572 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -813,6 +813,15 @@
     }
     return 0;
 }
+
+static void
+clear_ossl_store_error(OSSL_STORE_CTX *store_ctx)
+{
+    if (OSSL_STORE_error(store_ctx))
+    {
+        ERR_clear_error();
+    }
+}
 #endif /* defined(HAVE_OPENSSL_STORE_API) */
 
 /**
@@ -864,7 +873,19 @@
     {
         goto end;
     }
-    info = OSSL_STORE_load(store_ctx);
+    while (1)
+    {
+        info = OSSL_STORE_load(store_ctx);
+        if (info || OSSL_STORE_eof(store_ctx))
+        {
+            break;
+        }
+        /* OPENSSL_STORE_load can return error and still have usable objects to follow.
+         * ref: man OPENSSL_STORE_open
+         * Clear error and recurse through the file if info = NULL and eof not reached
+         */
+        clear_ossl_store_error(store_ctx);
+    }
     if (!info)
     {
         goto end;
@@ -1099,7 +1120,19 @@
         goto end;
     }
 
-    info = OSSL_STORE_load(store_ctx);
+    while (1)
+    {
+        info = OSSL_STORE_load(store_ctx);
+        if (info || OSSL_STORE_eof(store_ctx))
+        {
+            break;
+        }
+        /* OPENSSL_STORE_load can return error and still have usable objects to follow.
+         * ref: man OPENSSL_STORE_open
+         * Clear error and recurse through the file if info = NULL and eof not reached.
+         */
+        clear_ossl_store_error(store_ctx);
+    }
     if (!info)
     {
         goto end;
@@ -1120,9 +1153,14 @@
     OSSL_STORE_INFO_free(info);
 
     /* iterate through the store and add extra certificates if any to the chain */
-    info = OSSL_STORE_load(store_ctx);
-    while (info && !OSSL_STORE_eof(store_ctx))
+    while (!OSSL_STORE_eof(store_ctx))
     {
+        info = OSSL_STORE_load(store_ctx);
+        if (!info)
+        {
+            clear_ossl_store_error(store_ctx);
+            continue;
+        }
         x = OSSL_STORE_INFO_get1_CERT(info);
         if (x && SSL_CTX_add_extra_chain_cert(tls_ctx->ctx, x) != 1)
         {
@@ -1131,7 +1169,6 @@
             break;
         }
         OSSL_STORE_INFO_free(info);
-        info = OSSL_STORE_load(store_ctx);
     }
 
 end:

