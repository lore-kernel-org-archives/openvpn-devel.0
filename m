From: Gert Doering <gert@...1296...>
Date: Wed, 15 Nov 2023 16:17:40 +0100
Message-ID: <20231115151740.23948-1-gert@...1296...>
In-Reply-To: <gerrit.1699630545000.If4e1c4af9831eb1090ccb3a3c4d3e76b413f0708@...2715...>
References: <gerrit.1699630545000.If4e1c4af9831eb1090ccb3a3c4d3e76b413f0708@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] Disable TLS 1.3 support with mbed TLS
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

As of version 3.5.0 the TLS-Exporter function is not yet implemented in
mbed TLS, and the exporter_master_secret is not exposed to the
application either. Falling back to an older PRF when claiming to use
TLS1.3 seems like false advertising.

Change-Id: If4e1c4af9831eb1090ccb3a3c4d3e76b413f0708
Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/403
This mail reflects revision 5 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/README.mbedtls b/README.mbedtls
index 9b75c2b..ed9d369 100644
--- a/README.mbedtls
+++ b/README.mbedtls
@@ -43,19 +43,5 @@
 
 *************************************************************************
 
-Mbed TLS 3 supports the TLS 1.3 protocol, but the implementation is not yet
-complete. Therefore, using TLS 1.3 in the mbed TLS build of OpenVPN is not yet
-supported.
-
-Nevertheless, here are some pointers to make it work with mbed TLS 3.5.0:
-
- * The stock configuration of mbed TLS does not support TLS 1.3. To enable it,
-   uncomment `#define MBEDTLS_SSL_PROTO_TLS1_3` in your mbedtls_config.h before
-   compiling the library.
- * An OpenVPN client with mbed TLS cannot connect to a server with OpenSSL
-   using TLS 1.3.
- * An OpenVPN client with OpenSSL *can* connect to a server using mbed TLS with
-   TLS 1.3, but *only* if `#define MBEDTLS_SSL_TLS1_3_COMPATIBILITY_MODE` has
-   been uncommented in mbedtls_config.h.
-
-Note that none of these limitations apply to TLS 1.2.
+Mbed TLS 3 has implemented (parts of) the TLS 1.3 protocol, but we have disabled
+support in OpenVPN because the TLS-Exporter function is not yet implemented.
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 5168484..9c9167d 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1037,17 +1037,15 @@
 int
 tls_version_max(void)
 {
-#if defined(MBEDTLS_SSL_PROTO_TLS1_3)
-    return TLS_VER_1_3;
-#elif defined(MBEDTLS_SSL_PROTO_TLS1_2)
+#if defined(MBEDTLS_SSL_PROTO_TLS1_2)
     return TLS_VER_1_2;
 #elif defined(MBEDTLS_SSL_PROTO_TLS1_1)
     return TLS_VER_1_1;
 #elif defined(MBEDTLS_SSL_PROTO_TLS1)
     return TLS_VER_1_0;
-#else /* if defined(MBEDTLS_SSL_PROTO_TLS1_3) */
-    #error "mbedtls is compiled without support for any version of TLS."
-#endif
+#else /* defined(MBEDTLS_SSL_PROTO_TLS1_2) */
+    #error "mbedtls is compiled without support for TLS 1.0, 1.1 and 1.2."
+#endif /* defined(MBEDTLS_SSL_PROTO_TLS1_2) */
 }
 
 /**
@@ -1089,13 +1087,6 @@
             break;
 #endif
 
-#if defined(MBEDTLS_SSL_PROTO_TLS1_3)
-        case TLS_VER_1_3:
-            *major = MBEDTLS_SSL_MAJOR_VERSION_3;
-            *minor = MBEDTLS_SSL_MINOR_VERSION_4;
-            break;
-#endif
-
         default:
             msg(M_FATAL, "%s: invalid or unsupported TLS version %d", __func__, tls_ver);
             break;

