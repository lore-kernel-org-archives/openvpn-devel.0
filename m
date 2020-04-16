From: Arne Schwabe <arne@...1227...>
Date: Thu, 16 Apr 2020 13:39:29 +0200
Message-Id: <20200416113930.15192-2-arne@...1227...>
In-Reply-To: <20200416113930.15192-1-arne@...1227...>
References: <20200416113930.15192-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v2 2/3] Minor style change to improve code
 style
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

These are small manual changes that are done to improve the code
style and also make the result of uncrustify better without mixing
manual changes/automatic changes into a single commit.

- Make prototype and function identical for gc_addspecial. Also fixes
  uncrustify misparsing the embedded function pointer decleration
- Disallow uncrustify to reformat link_socket_init_phase1, which it
  messes up
- Format the the parameters of a call of  mbedtls_ssl_tls_prf to
  be more inline with the rest of our function calls with multiple
  arguments

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/buffer.c      | 2 +-
 src/openvpn/socket.h      | 4 +++-
 src/openvpn/ssl_mbedtls.c | 8 ++++----
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 8575e295..b32bc8b2 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -474,7 +474,7 @@ x_gc_freespecial(struct gc_arena *a)
 }
 
 void
-gc_addspecial(void *addr, void (free_function)(void *), struct gc_arena *a)
+gc_addspecial(void *addr, void (*free_function)(void *), struct gc_arena *a)
 {
     ASSERT(a);
     struct gc_entry_special *e;
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index e95547d1..38e5138d 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -296,7 +296,8 @@ int openvpn_connect(socket_descriptor_t sd,
 /*
  * Initialize link_socket object.
  */
-
+/* *INDENT-OFF* uncrustify misparses this function declarion because of
+ * embedded #if/#endif tell it to skip this section */
 void
 link_socket_init_phase1(struct link_socket *sock,
                         const char *local_host,
@@ -327,6 +328,7 @@ link_socket_init_phase1(struct link_socket *sock,
                         int mark,
                         struct event_timeout *server_poll_timeout,
                         unsigned int sockflags);
+/* Reenable uncrustify *INDENT-ON* */
 
 void link_socket_init_phase2(struct link_socket *sock,
                              const struct frame *frame,
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 4f194ad7..d585111b 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -209,10 +209,10 @@ int mbedtls_ssl_export_keys_cb(void *p_expkey, const unsigned char *ms,
     memcpy(client_server_random + 32, server_random, 32);
 
     const size_t ms_len = sizeof(ks_ssl->ctx->session->master);
-    int ret = mbedtls_ssl_tls_prf(
-            tls_prf_type, ms, ms_len, session->opt->ekm_label,
-            client_server_random, sizeof(client_server_random),
-            ks_ssl->exported_key_material, session->opt->ekm_size);
+    int ret = mbedtls_ssl_tls_prf(tls_prf_type, ms, ms_len,
+                                  session->opt->ekm_label, client_server_random,
+                                  sizeof(client_server_random), ks_ssl->exported_key_material,
+                                  session->opt->ekm_size);
 
     if (!mbed_ok(ret))
     {
-- 
2.26.0


