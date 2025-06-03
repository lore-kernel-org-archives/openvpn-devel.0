From: Gert Doering <gert@...1296...>
Date: Tue,  3 Jun 2025 16:06:24 +0200
Message-ID: <20250603140631.11696-1-gert@...1296...>
In-Reply-To: <gerrit.1747746380000.If5e832866b312a2f8a1ce6b4e00d40e3dcf63681@...2715...>
References: <gerrit.1747746380000.If5e832866b312a2f8a1ce6b4e00d40e3dcf63681@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] mbedtls: Allow TLS 1.3 if available
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

We need mbedtls_ssl_export_keying_material() to support TLS 1.3. The
workaround we use for TLS 1.2 does not work for TLS 1.3.

Change-Id: If5e832866b312a2f8a1ce6b4e00d40e3dcf63681
Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
Acked-by: Gert Doering <gert@...1296...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1042
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>
Frank Lichtenheld <frank@...2641...>

        
diff --git a/README.mbedtls b/README.mbedtls
index c4f3924..a1012e9 100644
--- a/README.mbedtls
+++ b/README.mbedtls
@@ -26,5 +26,9 @@
 
 *************************************************************************
 
-Mbed TLS 3 has implemented (parts of) the TLS 1.3 protocol, but we have disabled
-support in OpenVPN because the TLS-Exporter function is not yet implemented.
+Mbed TLS 3 has implemented TLS 1.3, but support in OpenVPN requires the
+function mbedtls_ssl_export_keying_material() which is currently not in
+any released version. It is available when building mbed TLS from source
+(mbedtls-3.6 or development branch).
+
+Without this function, only TLS 1.2 is available.
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 0159166..b78439c 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1048,11 +1048,14 @@
 int
 tls_version_max(void)
 {
-#if defined(MBEDTLS_SSL_PROTO_TLS1_2)
+    /* We need mbedtls_ssl_export_keying_material() to support TLS 1.3. */
+#if defined(MBEDTLS_SSL_PROTO_TLS1_3) && defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
+    return TLS_VER_1_3;
+#elif defined(MBEDTLS_SSL_PROTO_TLS1_2)
     return TLS_VER_1_2;
-#else /* defined(MBEDTLS_SSL_PROTO_TLS1_2) */
-    #error "mbedtls is compiled without support for TLS 1.2."
-#endif /* defined(MBEDTLS_SSL_PROTO_TLS1_2) */
+#else
+    #error mbedtls is compiled without support for TLS 1.2 or 1.3
+#endif
 }
 
 /**

