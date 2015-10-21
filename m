From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 21 Oct 2015 10:13:26 +0300
Message-Id: <1445411606-13369-1-git-send-email-lstipakov@...277...>
In-Reply-To: <56264F18.8000105@...277...>
References: <56264F18.8000105@...277...>
Subject: [Openvpn-devel] [PATCH v2] Replace variable length array with malloc
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
size of array to be compiler time constant. As a fix, use malloc/free.

v2:
 Replace OPENSSL_malloc with gc_malloc

Signed-off-by: Lev Stipakov <lstipakov@...277...>
---
 src/openvpn/ssl_openssl.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index c08d4fe..3c8d41f 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -141,12 +141,12 @@ key_state_export_keying_material(struct key_state_ssl *ssl,
     {
 #if (OPENSSL_VERSION_NUMBER >= 0x10001000)
       unsigned int size = session->opt->ekm_size;
-      unsigned char ekm[size];
+      struct gc_arena gc = gc_new();
+      unsigned char* ekm = (unsigned char*) gc_malloc(size, true, &gc);
 
       if (SSL_export_keying_material(ssl->ssl, ekm, sizeof(ekm),
           session->opt->ekm_label, session->opt->ekm_label_size, NULL, 0, 0))
        {
-         struct gc_arena gc = gc_new();
          unsigned int len = (size * 2) + 2;
 
          const char *key = format_hex_ex (ekm, size, len, 0, NULL, &gc);
@@ -154,14 +154,13 @@ key_state_export_keying_material(struct key_state_ssl *ssl,
 
          dmsg(D_TLS_DEBUG_MED, "%s: exported keying material: %s",
               __func__, key);
-
-         gc_free(&gc);
        }
       else
        {
          msg (M_WARN, "WARNING: Export keying material failed!");
          setenv_del (session->opt->es, "exported_keying_material");
        }
+      gc_free(&gc);
 #endif
     }
 }
-- 
1.9.1


