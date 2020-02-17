From: Arne Schwabe <arne@...1227...>
Date: Mon, 17 Feb 2020 12:55:20 +0100
Message-Id: <20200217115522.20068-2-arne@...1227...>
In-Reply-To: <20200217115522.20068-1-arne@...1227...>
References: <20200217115522.20068-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v3 2/5] Implement dynamic NCP negotiation
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

Our current NCP version is flawed in the way that it can only indicate support for
AES-256-GCM and AES-128-GCM. While configuring client and server with different
ncp-cipher configuration directive works, the server will blindly push the first
cipher of that list to the client if the client sends IV_NCP=2.

This patches introduces IV_CIPHER sent from the client to the server that
contains the full list of cipers that the client is willing to support (*).
The server will then pick the first ciphr of its own ncp-cipher list that
the client indicates support for.

We choose a textual representation of the ciphers instead of a binary sinc
a binary would mean that we would need to have a central place to maintain
a mapping between binary and the actual cipher name. Also the normal
ncp-cipher list is quite short, so this should not be problem. It also provides
the freedom to negioate new ciphers from SSL libraries without the need to
upgrade OpenVPN/its binary cipher table.

* the client/server will also accpt the cipher specifid in --cipher but eventually
we want to get rid of --ciper. So this patch keeps a reasonable backwards
compatbility (especially poor man's NCP) but does not encourage to use --cipher
for negotiation in documentation or warning messages.

Patch V2: Remove #include "ssl_ncp.h" Note to compile on windows the patch
          "Add strsep compat function" should be applied first

Patch V3: Use string_alloc with gc instead strdup()

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/openvpn.8            |  10 +++-
 src/openvpn/init.c       |   1 -
 src/openvpn/push.c       |  31 +++++++----
 src/openvpn/ssl.c        | 110 +++++++++++++++++++++++++++++++++++++--
 src/openvpn/ssl.h        |  34 ++++++++++++
 src/openvpn/ssl_common.h |   1 -
 6 files changed, 169 insertions(+), 18 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index b8f2f042..d631ebe7 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -3117,6 +3117,11 @@ IV_NCP=2 \-\- negotiable ciphers, client supports
 pushed by the server, a value of 2 or greater indicates client
 supports AES\-GCM\-128 and AES\-GCM\-256.
 
+IV_CIPHERS=<ncp\-ciphers> \-\- the client pushes the list of configured
+ciphers with the
+\.B -\-\ncp\-ciphers
+option to the server.
+
 IV_GUI_VER=<gui_id> <version> \-\- the UI version of a UI if one is
 running, for example "de.blinkt.openvpn 0.5.47" for the
 Android app.
@@ -4374,7 +4379,8 @@ is a colon\-separated list of ciphers, and defaults to
 
 For servers, the first cipher from
 .B cipher_list
-will be pushed to clients that support cipher negotiation.
+that is also supported by the client will be pushed to clients
+that support cipher negotiation.
 
 Cipher negotiation is enabled in client\-server mode only.  I.e. if
 .B \-\-mode
@@ -4398,7 +4404,7 @@ NCP server (v2.4+) with "\-\-cipher BF\-CBC" and "\-\-ncp\-ciphers
 AES\-256\-GCM:AES\-256\-CBC" set can either specify "\-\-cipher BF\-CBC" or
 "\-\-cipher AES\-256\-CBC" and both will work.
 
-Note, for using NCP with a OpenVPN 2.4 server this list must include
+Note, for using NCP with a OpenVPN 2.4 peer this list must include
 the AES\-256\-GCM and AES\-128\-GCM ciphers.
 .\"*********************************************************
 .TP
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 5c2f801a..9363769f 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2826,7 +2826,6 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     to.replay_time = options->replay_time;
     to.tcp_mode = link_socket_proto_connection_oriented(options->ce.proto);
     to.config_ciphername = c->c1.ciphername;
-    to.config_authname = c->c1.authname;
     to.config_ncp_ciphers = options->ncp_ciphers;
     to.ncp_enabled = options->ncp_enabled;
     to.transition_window = options->transition_window;
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 368b6920..8b634051 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -429,7 +429,7 @@ prepare_push_reply(struct context *c, struct gc_arena *gc,
     prepare_auth_token_push_reply(tls_multi, gc, push_list);
 
     /* Push cipher if client supports Negotiable Crypto Parameters */
-    if (tls_peer_info_ncp_ver(peer_info) >= 2 && o->ncp_enabled)
+    if (o->ncp_enabled)
     {
         /* if we have already created our key, we cannot *change* our own
          * cipher -> so log the fact and push the "what we have now" cipher
@@ -445,17 +445,30 @@ prepare_push_reply(struct context *c, struct gc_arena *gc,
         }
         else
         {
-            /* Push the first cipher from --ncp-ciphers to the client.
-             * TODO: actual negotiation, instead of server dictatorship. */
-            char *push_cipher = string_alloc(o->ncp_ciphers, &o->gc);
-            o->ciphername = strtok(push_cipher, ":");
+            /*
+             * Push the first cipher from --ncp-ciphers to the client that
+             * the client announces to be supporting.
+             */
+            char *push_cipher = ncp_get_best_cipher(o->ncp_ciphers, o->ciphername,
+                                                    peer_info,
+                                                    tls_multi->remote_ciphername,
+                                                    &o->gc);
+
+            if (push_cipher)
+            {
+                o->ciphername = push_cipher;
+            }
+            else
+            {
+                const char *peer_ciphers = tls_peer_ncp_list(peer_info, gc);
+                msg(M_INFO, "PUSH: No common cipher between server and client."
+                    "Expect this connection not to work. "
+                    "Server ncp-ciphers: '%s', client supported ciphers '%s'",
+                    o->ncp_ciphers, peer_ciphers);
+            }
         }
         push_option_fmt(gc, push_list, M_USAGE, "cipher %s", o->ciphername);
     }
-    else if (o->ncp_enabled)
-    {
-        tls_poor_mans_ncp(o, tls_multi->remote_ciphername);
-    }
 
     return true;
 }
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index b8351737..64786d0b 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1934,6 +1934,80 @@ tls_item_in_cipher_list(const char *item, const char *list)
     return token != NULL;
 }
 
+const char *
+tls_peer_ncp_list(const char *peer_info, struct gc_arena *gc)
+{
+    /* Check if the peer sends the IV_CIPHERS list */
+    const char *ncp_ciphers_start;
+    if (peer_info && (ncp_ciphers_start = strstr(peer_info, "IV_CIPHERS=")))
+    {
+        ncp_ciphers_start += strlen("IV_CIPHERS=");
+        const char *ncp_ciphers_end = strstr(ncp_ciphers_start, "\n");
+        if (!ncp_ciphers_end)
+        {
+            /* IV_CIPHERS is at end of the peer_info list and no '\n'
+             * follows */
+            ncp_ciphers_end = ncp_ciphers_start + strlen(ncp_ciphers_start);
+        }
+
+        char *ncp_ciphers_peer = string_alloc(ncp_ciphers_start, gc);
+        /* NULL terminate the copy at the right position */
+        ncp_ciphers_peer[ncp_ciphers_end - ncp_ciphers_start] = '\0';
+        return ncp_ciphers_peer;
+
+    }
+    else if (tls_peer_info_ncp_ver(peer_info)>=2)
+    {
+        /* If the peer announces IV_NCP=2 then it supports the AES GCM
+         * ciphers */
+        return "AES-256-GCM:AES-128-GCM";
+    }
+    else
+    {
+        return "";
+    }
+}
+
+char *
+ncp_get_best_cipher(const char *server_list, const char *server_cipher,
+                    const char *peer_info,  const char *remote_cipher,
+                    struct gc_arena *gc)
+{
+    const char *peer_ncp_list = tls_peer_ncp_list(peer_info, gc);
+
+    char *tmp_ciphers = string_alloc(server_list, NULL);
+    char *tmp_ciphers_orig = tmp_ciphers;
+
+    const char *token = strsep(&tmp_ciphers, ":");
+    while (token)
+    {
+        if (tls_item_in_cipher_list(token, peer_ncp_list)
+            || streq(token, remote_cipher))
+        {
+            break;
+        }
+        token = strsep(&tmp_ciphers, ":");
+    }
+    /* We have not found a common cipher, as a last resort check if the
+     * server cipher can be used
+     */
+    if (token == NULL
+        && (tls_item_in_cipher_list(server_cipher, peer_ncp_list)
+            || streq(server_cipher, remote_cipher)))
+    {
+        token = server_cipher;
+    }
+
+    char *ret = NULL;
+    if (token != NULL)
+    {
+        ret = string_alloc(token, gc);
+    }
+
+    free(tmp_ciphers_orig);
+    return ret;
+}
+
 void
 tls_poor_mans_ncp(struct options *o, const char *remote_ciphername)
 {
@@ -2322,11 +2396,15 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
 
         /* support for Negotiable Crypto Parameters */
         if (session->opt->ncp_enabled
-            && (session->opt->mode == MODE_SERVER || session->opt->pull)
-            && tls_item_in_cipher_list("AES-128-GCM", session->opt->config_ncp_ciphers)
-            && tls_item_in_cipher_list("AES-256-GCM", session->opt->config_ncp_ciphers))
+            && (session->opt->mode == MODE_SERVER || session->opt->pull))
         {
-            buf_printf(&out, "IV_NCP=2\n");
+            if (tls_item_in_cipher_list("AES-128-GCM", session->opt->config_ncp_ciphers)
+                && tls_item_in_cipher_list("AES-256-GCM", session->opt->config_ncp_ciphers))
+            {
+
+                buf_printf(&out, "IV_NCP=2\n");
+            }
+            buf_printf(&out, "IV_CIPHERS=%s\n", session->opt->config_ncp_ciphers);
         }
 
         /* push compression status */
@@ -2561,6 +2639,28 @@ error:
     return false;
 }
 
+/**
+ * Returns whether the client supports NCP either by
+ * announcing IV_NCP>=2 or the IV_CIPHERS list
+ */
+static bool
+tls_peer_supports_ncp(const char *peer_info)
+{
+    if (!peer_info)
+    {
+        return false;
+    }
+    else if (tls_peer_info_ncp_ver(peer_info) >= 2
+             || strstr(peer_info, "IV_CIPHERS="))
+    {
+        return true;
+    }
+    else
+    {
+        return false;
+    }
+}
+
 static bool
 key_method_2_read(struct buffer *buf, struct tls_multi *multi, struct tls_session *session)
 {
@@ -2633,7 +2733,7 @@ key_method_2_read(struct buffer *buf, struct tls_multi *multi, struct tls_sessio
     multi->remote_ciphername =
         options_string_extract_option(options, "cipher", NULL);
 
-    if (tls_peer_info_ncp_ver(multi->peer_info) < 2)
+    if (!tls_peer_supports_ncp(multi->peer_info))
     {
         /* Peer does not support NCP, but leave NCP enabled if the local and
          * remote cipher do not match to attempt 'poor-man's NCP'.
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index a944ca3a..2a8871ed 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -512,6 +512,40 @@ tls_get_peer_info(const struct tls_multi *multi)
  */
 int tls_peer_info_ncp_ver(const char *peer_info);
 
+/**
+ * Iterates through the ciphers in server_list and return the first
+ * cipher that is also supported by the peer according to the IV_NCP
+ * and IV_CIPHER values in peer_info.
+ *
+ * We also accept a cipher that is the remote cipher of the client for
+ * "Poor man's NCP": Use peer cipher if it is an allowed (NCP) cipher.
+ * Allows non-NCP peers to upgrade their cipher individually.
+ *
+ * Make sure to call tls_session_update_crypto_params() after calling this
+ * function.
+ *
+ * @param gc   gc arena that is ONLY used to allocate the returned string
+ *
+ * @returns NULL if no common cipher is available, otherwise the best common
+ * cipher
+ */
+char *
+ncp_get_best_cipher(const char *server_list, const char *server_cipher,
+                    const char *peer_info, const char *remote_cipher,
+                    struct gc_arena *gc);
+
+
+/**
+ * Returns the support cipher list from the peer according to the IV_NCP
+ * and IV_CIPHER values in peer_info.
+ *
+ * @returns Either a string containing the ncp list that is either static
+ * or allocated via gc. If no information is available an empty string
+ * ("") is returned.
+ */
+const char *
+tls_peer_ncp_list(const char *peer_info, struct gc_arena *gc);
+
 /**
  * Check whether the ciphers in the supplied list are supported.
  *
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index fb82f610..998ea3c4 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -289,7 +289,6 @@ struct tls_options
     bool tcp_mode;
 
     const char *config_ciphername;
-    const char *config_authname;
     const char *config_ncp_ciphers;
     bool ncp_enabled;
 
-- 
2.25.0


