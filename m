From: Gert Doering <gert@...1296...>
Date: Thu, 27 Mar 2025 12:33:50 +0100
Message-ID: <20250327113356.11233-1-gert@...1296...>
In-Reply-To: <gerrit.1742992852000.I8bbb6ffdac7d0029dbf3c13e62c11b61813c15ef@...2715...>
References: <gerrit.1742992852000.I8bbb6ffdac7d0029dbf3c13e62c11b61813c15ef@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Fix compatibility with mbedTLS 2.28.10+
 and 3.6.3+
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

From release notes:
In TLS clients, if mbedtls_ssl_set_hostname() has not been called,
mbedtls_ssl_handshake() now fails with
MBEDTLS_ERR_SSL_CERTIFICATE_VERIFICATION_WITHOUT_HOSTNAME
if certificate-based authentication of the server is attempted.
This is because authenticating a server without knowing what name
to expect is usually insecure. To restore the old behavior, either
call mbedtls_ssl_set_hostname() with NULL as the hostname [...]

Change-Id: I8bbb6ffdac7d0029dbf3c13e62c11b61813c15ef
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: MaxF <max@...2606...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/918
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
MaxF <max@...2606...>

        
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 92b52fe..e15c391 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1246,6 +1246,10 @@
     ALLOC_OBJ_CLEAR(ks_ssl->ctx, mbedtls_ssl_context);
     mbedtls_ssl_init(ks_ssl->ctx);
     mbed_ok(mbedtls_ssl_setup(ks_ssl->ctx, ks_ssl->ssl_config));
+    /* We do verification in our own callback depending on the
+     * exact configuration. We do not rely on the default hostname
+     * verification. */
+    ASSERT(mbed_ok(mbedtls_ssl_set_hostname(ks_ssl->ctx, NULL)));
 
 #if HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB
     /* Initialize keying material exporter, new style. */

