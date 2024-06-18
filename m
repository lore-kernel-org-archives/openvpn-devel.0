From: Gert Doering <gert@...1296...>
Date: Tue, 18 Jun 2024 14:02:19 +0200
Message-ID: <20240618120219.5053-1-gert@...1296...>
In-Reply-To: <gerrit.1718364874000.Ia3883a26ac26df6bbb5353fb074a2e0f814737be@...2715...>
References: <gerrit.1718364874000.Ia3883a26ac26df6bbb5353fb074a2e0f814737be@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] mbedtls: Remove support for old TLS
 versions
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

From: Max Fillinger <maximilian.fillinger@...2507...>

Recent versions of mbedtls have dropped support for TLS 1.0 and 1.1.
Rather than checking which versions are supported, drop support for
everything before 1.2.

Change-Id: Ia3883a26ac26df6bbb5353fb074a2e0f814737be
Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/682
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index a68588e..ec9ec13 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1040,12 +1040,8 @@
 {
 #if defined(MBEDTLS_SSL_PROTO_TLS1_2)
     return TLS_VER_1_2;
-#elif defined(MBEDTLS_SSL_PROTO_TLS1_1)
-    return TLS_VER_1_1;
-#elif defined(MBEDTLS_SSL_PROTO_TLS1)
-    return TLS_VER_1_0;
 #else /* defined(MBEDTLS_SSL_PROTO_TLS1_2) */
-    #error "mbedtls is compiled without support for TLS 1.0, 1.1 and 1.2."
+    #error "mbedtls is compiled without support for TLS 1.2."
 #endif /* defined(MBEDTLS_SSL_PROTO_TLS1_2) */
 }
 
@@ -1067,20 +1063,6 @@
 
     switch (tls_ver)
     {
-#if defined(MBEDTLS_SSL_PROTO_TLS1)
-        case TLS_VER_1_0:
-            *major = MBEDTLS_SSL_MAJOR_VERSION_3;
-            *minor = MBEDTLS_SSL_MINOR_VERSION_1;
-            break;
-#endif
-
-#if defined(MBEDTLS_SSL_PROTO_TLS1_1)
-        case TLS_VER_1_1:
-            *major = MBEDTLS_SSL_MAJOR_VERSION_3;
-            *minor = MBEDTLS_SSL_MINOR_VERSION_2;
-            break;
-#endif
-
 #if defined(MBEDTLS_SSL_PROTO_TLS1_2)
         case TLS_VER_1_2:
             *major = MBEDTLS_SSL_MAJOR_VERSION_3;

