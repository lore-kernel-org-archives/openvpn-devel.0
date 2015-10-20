From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 20 Oct 2015 16:22:59 +0300
Message-Id: <1445347379-29943-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Replace variable length array with malloc
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Commit https://github.com/OpenVPN/openvpn/commit/685e486e8b8f70c25f09590c24762ff734f94a51
introduced a variable length array. Although C99 supports that, MSVS 2013 still requires
size of array to be compiler time constant. As a fix, use OPENSSL_malloc/free.

Signed-off-by: Lev Stipakov <lstipakov@...277...>
---
 src/openvpn/ssl_openssl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index c08d4fe..1b4b1da 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -141,7 +141,10 @@ key_state_export_keying_material(struct key_state_ssl *ssl,
     {
 #if (OPENSSL_VERSION_NUMBER >= 0x10001000)
       unsigned int size = session->opt->ekm_size;
-      unsigned char ekm[size];
+      unsigned char* ekm = OPENSSL_malloc(size);
+
+      if (ekm == NULL)
+	crypto_msg (M_FATAL, "Failed to allocate memory for export key material.");
 
       if (SSL_export_keying_material(ssl->ssl, ekm, sizeof(ekm),
           session->opt->ekm_label, session->opt->ekm_label_size, NULL, 0, 0))
@@ -162,6 +165,8 @@ key_state_export_keying_material(struct key_state_ssl *ssl,
          msg (M_WARN, "WARNING: Export keying material failed!");
          setenv_del (session->opt->es, "exported_keying_material");
        }
+
+      OPENSSL_free(ekm);
 #endif
     }
 }
-- 
1.9.1


