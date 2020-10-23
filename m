From: Arne Schwabe <arne@...1227...>
Date: Fri, 23 Oct 2020 14:02:57 +0200
Message-Id: <20201023120259.29783-5-arne@...1227...>
In-Reply-To: <20201023120259.29783-1-arne@...1227...>
References: <20201023113244.26295-1-arne@...1227...>
 <20201023120259.29783-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 6/8] Rename DECRYPT_KEY_ENABLED to
 TLS_AUTHENTICATED
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

The macro's name suggests that the key is enabled and being used. But
the macro actually something different but similar enough that the name
was probably right at some point.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl.c        |  6 +++---
 src/openvpn/ssl_verify.c |  2 +-
 src/openvpn/ssl_verify.h | 13 ++++++++++---
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e59dba31..e4f43a86 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3216,7 +3216,7 @@ tls_multi_process(struct tls_multi *multi,
      * verification failed.  A semi-trusted session can forward data on the
      * TLS control channel but not on the tunnel channel.
      */
-    if (DECRYPT_KEY_ENABLED(multi, &multi->session[TM_UNTRUSTED].key[KS_PRIMARY]))
+    if (TLS_AUTHENTICATED(multi, &multi->session[TM_UNTRUSTED].key[KS_PRIMARY]))
     {
         move_session(multi, TM_ACTIVE, TM_UNTRUSTED, true);
         msg(D_TLS_DEBUG_LOW, "TLS: tls_multi_process: untrusted session promoted to %strusted",
@@ -3301,7 +3301,7 @@ handle_data_channel_packet(struct tls_multi *multi,
          * passive side is the server which only listens for the connections, the
          * active side is the client which initiates connections).
          */
-        if (DECRYPT_KEY_ENABLED(multi, ks)
+        if (TLS_AUTHENTICATED(multi, ks)
             && key_id == ks->key_id
             && (ks->authenticated == KS_AUTH_TRUE)
             && (floated || link_socket_actual_match(from, &ks->remote_addr)))
@@ -3628,7 +3628,7 @@ tls_pre_decrypt(struct tls_multi *multi,
          * Remote is requesting a key renegotiation
          */
         if (op == P_CONTROL_SOFT_RESET_V1
-            && DECRYPT_KEY_ENABLED(multi, ks))
+            && TLS_AUTHENTICATED(multi, ks))
         {
             if (!read_control_auth(buf, &session->tls_wrap, from,
                                    session->opt))
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 4172e2fd..98985c51 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -948,7 +948,7 @@ tls_authentication_status(struct tls_multi *multi, const int latency)
     for (int i = 0; i < KEY_SCAN_SIZE; ++i)
     {
         struct key_state *ks = get_key_scan(multi, i);
-        if (DECRYPT_KEY_ENABLED(multi, ks))
+        if (TLS_AUTHENTICATED(multi, ks))
         {
             active++;
             if (ks->authenticated > KS_AUTH_FALSE)
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index b3fe25d2..7e8b9710 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -95,15 +95,22 @@ enum tls_auth_status
 enum tls_auth_status
 tls_authentication_status(struct tls_multi *multi, const int latency);
 
-/** Check whether the \a ks \c key_state is ready to receive data channel
- *   packets.
+/** Check whether the \a ks \c key_state has finished the key exchange part
+ *  of the OpenVPN hand shake. This is that the key_method_2read/write
+ *  handshakes have been completed and certificate verification have
+ *  been completed.
+ *
+ * connect/deferred auth might still pending. Also data-channel keys might
+ * not have been created since they are delayed until PUSH_REPLY for NCP
+ * clients.
+ *
  *   @ingroup data_crypto
  *
  *   If true, it is safe to assume that this session has been authenticated
  *   by TLS.
  *
  *   @note This macro only works if S_SENT_KEY + 1 == S_GOT_KEY. */
-#define DECRYPT_KEY_ENABLED(multi, ks) ((ks)->state >= (S_GOT_KEY - (multi)->opt.server))
+#define TLS_AUTHENTICATED(multi, ks) ((ks)->state >= (S_GOT_KEY - (multi)->opt.server))
 
 /**
  * Remove the given key state's auth control file, if it exists.
-- 
2.26.2


