From: Arne Schwabe <arne@...1227...>
Date: Sat, 24 Dec 2022 20:42:45 +0100
Message-Id: <20221224194253.3202231-2-arne@...1227...>
In-Reply-To: <20221224194253.3202231-1-arne@...1227...>
References: <20221224194253.3202231-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/9] Rename TM_UNTRUSTED to TM_INITIAL
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl.c        | 16 ++++++++--------
 src/openvpn/ssl.h        |  2 +-
 src/openvpn/ssl_common.h |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 9e5480528..a5fb4fd22 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -890,8 +890,8 @@ session_index_name(int index)
         case TM_ACTIVE:
             return "TM_ACTIVE";
 
-        case TM_UNTRUSTED:
-            return "TM_UNTRUSTED";
+        case TM_INITIAL:
+            return "TM_INITIAL";
 
         case TM_LAME_DUCK:
             return "TM_LAME_DUCK";
@@ -1330,7 +1330,7 @@ tls_multi_init_finalize(struct tls_multi *multi, int tls_mtu)
 
     if (!multi->opt.single_session)
     {
-        tls_session_init(multi, &multi->session[TM_UNTRUSTED]);
+        tls_session_init(multi, &multi->session[TM_INITIAL]);
     }
 }
 
@@ -3250,7 +3250,7 @@ tls_multi_process(struct tls_multi *multi,
     if (multi->multi_state >= CAS_CONNECT_DONE)
     {
         /* Only generate keys for the TM_ACTIVE session. We defer generating
-         * keys for TM_UNTRUSTED until we actually trust it.
+         * keys for TM_INITIAL until we actually trust it.
          * For TM_LAME_DUCK it makes no sense to generate new keys. */
         struct tls_session *session = &multi->session[TM_ACTIVE];
         struct key_state *ks = &session->key[KS_PRIMARY];
@@ -3299,9 +3299,9 @@ tls_multi_process(struct tls_multi *multi,
      * verification failed.  A semi-trusted session can forward data on the
      * TLS control channel but not on the tunnel channel.
      */
-    if (TLS_AUTHENTICATED(multi, &multi->session[TM_UNTRUSTED].key[KS_PRIMARY]))
+    if (TLS_AUTHENTICATED(multi, &multi->session[TM_INITIAL].key[KS_PRIMARY]))
     {
-        move_session(multi, TM_ACTIVE, TM_UNTRUSTED, true);
+        move_session(multi, TM_ACTIVE, TM_INITIAL, true);
         msg(D_TLS_DEBUG_LOW, "TLS: tls_multi_process: untrusted session promoted to %strusted",
             tas == TLS_AUTHENTICATION_SUCCEEDED ? "" : "semi-");
 
@@ -3720,7 +3720,7 @@ tls_pre_decrypt(struct tls_multi *multi,
             print_link_socket_actual(from, &gc));
 
         new_link = true;
-        i = TM_UNTRUSTED;
+        i = TM_INITIAL;
         session->untrusted_addr = *from;
     }
     else
@@ -3731,7 +3731,7 @@ tls_pre_decrypt(struct tls_multi *multi,
         /*
          * Packet must belong to an existing session.
          */
-        if (i != TM_ACTIVE && i != TM_UNTRUSTED)
+        if (i != TM_ACTIVE && i != TM_INITIAL)
         {
             msg(D_TLS_ERRORS,
                 "TLS Error: Unroutable control packet received from %s (si=%d op=%s)",
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 55c672d44..bd27e57a0 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -159,7 +159,7 @@ struct tls_multi *tls_multi_init(struct tls_options *tls_options);
  * @ingroup control_processor
  *
  * This function initializes the \c TM_ACTIVE \c tls_session, and in
- * server mode also the \c TM_UNTRUSTED \c tls_session, associated with
+ * server mode also the \c TM_INITIAL \c tls_session, associated with
  * this \c tls_multi structure.  It also configures the control channel's
  * \c frame structure based on the data channel's \c frame given in
  * argument \a frame.
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 978a9fca0..7d9c2460b 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -512,7 +512,7 @@ struct tls_session
  *
  *  @{ */
 #define TM_ACTIVE    0          /**< Active \c tls_session. */
-#define TM_UNTRUSTED 1          /**< As yet un-trusted \c tls_session
+#define TM_INITIAL   1          /**< As yet un-trusted \c tls_session
                                  *   being negotiated. */
 #define TM_LAME_DUCK 2          /**< Old \c tls_session. */
 #define TM_SIZE      3          /**< Size of the \c tls_multi.session
-- 
2.37.1 (Apple Git-137.1)


