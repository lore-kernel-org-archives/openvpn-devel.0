From: Gert Doering <gert@...1296...>
Date: Thu, 17 Apr 2025 15:46:30 +0200
Message-ID: <20250417134636.21279-1-gert@...1296...>
In-Reply-To: <gerrit.1744889440000.I4507be07cd5573b2117e837ef03187535a38a4b1@...2715...>
References: <gerrit.1744889440000.I4507be07cd5573b2117e837ef03187535a38a4b1@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] ssl_openssl.c: Prevent potential
 double-free
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

From: Lev Stipakov <lev@...515...>

Fixes a potential double-free issue in tls_ctx_load_cert_uri()
by explicitly nullifying the pointer immediately after calling OSSL_STORE_INFO_free(info).

This ensures that subsequent cleanup won't attempt to free the same pointer again.

GitHub: #726

Change-Id: I4507be07cd5573b2117e837ef03187535a38a4b1
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Antonio Quartulli <antonio@...2726...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/942
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@...2726...>

        
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index d1d5d3e..f7be50c 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1152,6 +1152,7 @@
         goto end;
     }
     OSSL_STORE_INFO_free(info);
+    info = NULL;
 
     /* iterate through the store and add extra certificates if any to the chain */
     while (!OSSL_STORE_eof(store_ctx))
@@ -1170,6 +1171,7 @@
             break;
         }
         OSSL_STORE_INFO_free(info);
+        info = NULL;
     }
 
 end:

