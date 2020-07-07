From: Arne Schwabe <arne@...1227...>
Date: Tue,  7 Jul 2020 14:16:14 +0200
Message-Id: <20200707121615.15736-4-arne@...1227...>
In-Reply-To: <20200707121615.15736-1-arne@...1227...>
References: <20200707121615.15736-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 2/3] Cleanup: Remove unused code of old poor
 man's NCP.
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

Ever since the NCPv2 the ncp_get_best_cipher uses the global
options->ncp_enabled option and ignore the tls_session->ncp_enabled
option.

The server side's poor man's NCP is implemented as seeing the list
of supported ciphers from the peer as just one cipher so this special
handling for poor man's NCP of the older NCP here is not needed anymore.

Theoretically we can now get rid of tls_session->ncp_enabled but doing
so requires more refactoring since options is not available in the
methods that still use it. And when we remove ncp-disable the variable
will be removed anyway.

Also document the remaining usage of tls_poor_mans_ncp better.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c |  2 ++
 src/openvpn/ssl.c  | 15 +--------------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 91b919d5..e9c01629 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2376,6 +2376,8 @@ do_deferred_options(struct context *c, const unsigned int found)
         }
         else if (c->options.ncp_enabled)
         {
+            /* If the server did not push a --cipher, we will switch to the
+             * remote cipher if it is in our ncp-ciphers list */
             tls_poor_mans_ncp(&c->options, c->c2.tls_multi->remote_ciphername);
         }
         struct frame *frame_fragment = NULL;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 9df7552d..71565dd3 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2463,8 +2463,7 @@ key_method_2_write(struct buffer *buf, struct tls_session *session)
      * generation is postponed until after the pull/push, so we can process pushed
      * cipher directives.
      */
-    if (session->opt->server && !(session->opt->ncp_enabled
-                                  && session->opt->mode == MODE_SERVER && ks->key_id <= 0))
+    if (session->opt->server && !(session->opt->mode == MODE_SERVER && ks->key_id <= 0))
     {
         if (ks->authenticated != KS_AUTH_FALSE)
         {
@@ -2616,18 +2615,6 @@ key_method_2_read(struct buffer *buf, struct tls_multi *multi, struct tls_sessio
     multi->remote_ciphername =
         options_string_extract_option(options, "cipher", NULL);
 
-    if (!tls_peer_supports_ncp(multi->peer_info))
-    {
-        /* Peer does not support NCP, but leave NCP enabled if the local and
-         * remote cipher do not match to attempt 'poor-man's NCP'.
-         */
-        if (multi->remote_ciphername == NULL
-            || 0 == strcmp(multi->remote_ciphername, multi->opt.config_ciphername))
-        {
-            session->opt->ncp_enabled = false;
-        }
-    }
-
     if (tls_session_user_pass_enabled(session))
     {
         /* Perform username/password authentication */
-- 
2.26.2


