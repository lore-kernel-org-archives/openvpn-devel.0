From: Gert Doering <gert@...1296...>
Date: Tue, 26 Aug 2025 20:41:38 +0200
Message-ID: <20250826184148.21534-1-gert@...1296...>
In-Reply-To: <gerrit.1753289942000.Ia5e0aad8a97d38f8d309a29ecfe3c578edff9595@...2715...>
References: <gerrit.1753289942000.Ia5e0aad8a97d38f8d309a29ecfe3c578edff9595@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v7] ssl_openssl: Fix type of sslopts
 argument to SSL_CTX_set_options
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

The argument changed type in OpenSSL 3.0.

Change-Id: Ia5e0aad8a97d38f8d309a29ecfe3c578edff9595
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1101
This mail reflects revision 7 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 1948d12..aa1ac11 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -308,7 +308,7 @@
     ASSERT(NULL != ctx);
 
     /* process SSL options */
-    long sslopt = SSL_OP_SINGLE_DH_USE | SSL_OP_NO_TICKET;
+    uint64_t sslopt = SSL_OP_SINGLE_DH_USE | SSL_OP_NO_TICKET;
 #ifdef SSL_OP_CIPHER_SERVER_PREFERENCE
     sslopt |= SSL_OP_CIPHER_SERVER_PREFERENCE;
 #endif

