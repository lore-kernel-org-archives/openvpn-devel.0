From: Frank Lichtenheld <frank@...2641...>
Date: Mon,  8 Apr 2024 14:49:33 +0200
Message-Id: <20240408124933.243991-1-frank@...2641...>
In-Reply-To: <gerrit.1700479678000.I0ad48915004ddee587e97c8ed190ba8ee989e48d@...2715...>
References: <gerrit.1700479678000.I0ad48915004ddee587e97c8ed190ba8ee989e48d@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v6] Allow the TLS session to send out TLS
 alerts
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

From: Arne Schwabe <arne@...1227...>

Previous OpenVPN versions shut down the TLS control channel immediately
when encountering an error. This also meant that we would not send out
TLS alerts to notify a client about potential problems like mismatching
TLS versions or having no common cipher.

This commit adds a new key_state S_ERROR_PRE which still allows to
send out the remaining TLS packets of the control session which are
typically the alert message and then going to S_ERROR. We do not
wait for retries. So this is more a one-shot notify but that is
acceptable in this situation.

Sending out alerts is a slight compromise in security as alerts give
out a bit of information that otherwise is not given
out. But since all other consumers TLS implementations are already doing this
and TLS implementations (nowadays) are very careful not to leak (sensitive)
information by alerts and since the user experience is much better with
alerts, this compromise is worth it.

Change-Id: I0ad48915004ddee587e97c8ed190ba8ee989e48d
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/449
This mail reflects revision 6 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/Changes.rst b/Changes.rst
index 69c811d..52ff8db 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -1,5 +1,14 @@
 Overview of changes in 2.7
 ==========================
+New features
+------------
+TLS alerts
+    OpenVPN 2.7 will send out TLS alerts to peers informing them if the TLS
+    session shuts down or when the TLS implementation informs the peer about
+    an error in the TLS session (e.g. mismatching TLS versions). This improves
+    the user experience as the client shows an error instead of running into
+    a timeout when the server just stops responding completely.
+
 Deprecated features
 -------------------
 ``secret`` support has been removed by default.
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 33c8670..f287e4d 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -690,6 +690,9 @@
         case S_ERROR:
             return "S_ERROR";
 
+        case S_ERROR_PRE:
+            return "S_ERROR_PRE";
+
         case S_GENERATED_KEYS:
             return "S_GENERATED_KEYS";
 
@@ -2683,6 +2686,25 @@
 }
 
 static bool
+check_outgoing_ciphertext(struct key_state *ks, struct tls_session *session,
+                          bool *continue_tls_process)
+{
+    /* Outgoing Ciphertext to reliable buffer */
+    if (ks->state >= S_START)
+    {
+        struct buffer *buf = reliable_get_buf_output_sequenced(ks->send_reliable);
+        if (buf)
+        {
+            if (!write_outgoing_tls_ciphertext(session, continue_tls_process))
+            {
+                return false;
+            }
+        }
+    }
+    return true;
+}
+
+static bool
 tls_process_state(struct tls_multi *multi,
                   struct tls_session *session,
                   struct buffer *to_link,
@@ -2706,7 +2728,7 @@
     }
 
     /* Are we timed out on receive? */
-    if (now >= ks->must_negotiate && ks->state < S_ACTIVE)
+    if (now >= ks->must_negotiate && ks->state >= S_UNDEF && ks->state < S_ACTIVE)
     {
         msg(D_TLS_ERRORS,
             "TLS Error: TLS key negotiation failed to occur within %d seconds (check your network connectivity)",
@@ -2760,6 +2782,16 @@
         return false;
     }
 
+    if (ks->state == S_ERROR_PRE)
+    {
+        /* When we end up here, we had one last chance to send an outstanding
+         * packet that contained an alert. We do not ensure that this packet
+         * has been successfully delivered  (ie wait for the ACK etc)
+         * but rather stop processing now */
+        ks->state = S_ERROR;
+        return false;
+    }
+
     /* Write incoming ciphertext to TLS object */
     struct reliable_entry *entry = reliable_get_entry_sequenced(ks->rec_reliable);
     if (entry)
@@ -2840,29 +2872,31 @@
             dmsg(D_TLS_DEBUG, "Outgoing Plaintext -> TLS");
         }
     }
-
-    /* Outgoing Ciphertext to reliable buffer */
-    if (ks->state >= S_START)
+    if (!check_outgoing_ciphertext(ks, session, &continue_tls_process))
     {
-        buf = reliable_get_buf_output_sequenced(ks->send_reliable);
-        if (buf)
-        {
-            if (!write_outgoing_tls_ciphertext(session, &continue_tls_process))
-            {
-                goto error;
-            }
-        }
+        goto error;
     }
 
     return continue_tls_process;
 error:
     tls_clear_error();
-    ks->state = S_ERROR;
+
+    /* Shut down the TLS session but do a last read from the TLS
+     * object to be able to read potential TLS alerts */
+    key_state_ssl_shutdown(&ks->ks_ssl);
+    check_outgoing_ciphertext(ks, session, &continue_tls_process);
+
+    /* Put ourselves in the pre error state that will only send out the
+     * control channel packets but nothing else */
+    ks->state = S_ERROR_PRE;
+
     msg(D_TLS_ERRORS, "TLS Error: TLS handshake failed");
     INCR_ERROR;
-    return false;
-
+    return true;
 }
+
+
+
 /*
  * This is the primary routine for processing TLS stuff inside the
  * the main event loop.  When this routine exits
@@ -2970,7 +3004,7 @@
     }
 
     /* When should we wake up again? */
-    if (ks->state >= S_INITIAL)
+    if (ks->state >= S_INITIAL || ks->state == S_ERROR_PRE)
     {
         compute_earliest_wakeup(wakeup,
                                 reliable_send_timeout(ks->send_reliable));
@@ -3123,7 +3157,7 @@
              session_id_print(&ks->session_id_remote, &gc),
              print_link_socket_actual(&ks->remote_addr, &gc));
 
-        if (ks->state >= S_INITIAL && link_socket_actual_defined(&ks->remote_addr))
+        if ((ks->state >= S_INITIAL || ks->state == S_ERROR_PRE) &&  link_socket_actual_defined(&ks->remote_addr))
         {
             struct link_socket_actual *tla = NULL;
 
@@ -3201,7 +3235,8 @@
             {
                 msg(D_TLS_ERRORS, "TLS Error: generate_key_expansion failed");
                 ks->authenticated = KS_AUTH_FALSE;
-                ks->state = S_ERROR;
+                key_state_ssl_shutdown(&ks->ks_ssl);
+                ks->state = S_ERROR_PRE;
             }
 
             /* Update auth token on the client if needed on renegotiation
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index b9466ce..a4d4dd4 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -363,6 +363,13 @@
                         const struct tls_root_ctx *ssl_ctx, bool is_server, struct tls_session *session);
 
 /**
+ * Sets a TLS session to be shutdown state, so the TLS library will generate
+ * a shutdown alert.
+ */
+void
+key_state_ssl_shutdown(struct key_state_ssl *ks_ssl);
+
+/**
  * Free the SSL channel part of the given key state.
  *
  * @param ks_ssl        The SSL channel's state info to free
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 925660b..ff455b3 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -74,7 +74,10 @@
  *
  * @{
  */
-#define S_ERROR          -1     /**< Error state.  */
+#define S_ERROR         (-2)     /**< Error state.  */
+#define S_ERROR_PRE     (-1)     /**< Error state but try to send out alerts
+                                  *  before killing the keystore and moving
+                                  *  it to S_ERROR */
 #define S_UNDEF           0     /**< Undefined state, used after a \c
                                  *   key_state is cleaned up. */
 #define S_INITIAL         1     /**< Initial \c key_state state after
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index cc88484..5e6726c 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1276,6 +1276,14 @@
                         ssl_bio_read, NULL);
 }
 
+
+void
+key_state_ssl_shutdown(struct key_state_ssl *ks_ssl)
+{
+    mbedtls_ssl_send_alert_message(ks_ssl->ctx, MBEDTLS_SSL_ALERT_LEVEL_FATAL,
+                                   MBEDTLS_SSL_ALERT_MSG_CLOSE_NOTIFY);
+}
+
 void
 key_state_ssl_free(struct key_state_ssl *ks_ssl)
 {
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index c30e6a9..552d751 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1962,6 +1962,12 @@
 }
 
 void
+key_state_ssl_shutdown(struct key_state_ssl *ks_ssl)
+{
+    SSL_set_shutdown(ks_ssl->ssl, SSL_SENT_SHUTDOWN | SSL_RECEIVED_SHUTDOWN);
+}
+
+void
 key_state_ssl_free(struct key_state_ssl *ks_ssl)
 {
     if (ks_ssl->ssl)

