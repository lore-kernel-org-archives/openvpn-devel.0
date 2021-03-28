From: Arne Schwabe <arne@...1227...>
Date: Sun, 28 Mar 2021 14:02:41 +0200
Message-Id: <20210328120241.27605-2-arne@...1227...>
In-Reply-To: <20210328120241.27605-1-arne@...1227...>
References: <20201215164221.5995-1-arne@...1227...>
 <20210328120241.27605-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v2 2/2] Fix condition to generate session
 keys
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

When OpenVPN sees a new (SSL) connection via HARD_RESET or SOFT_RESET with
the same port/ip as an existing session, it will give it the slot of the
renegotiation session (TM_UNTRUSTED). And when the authentication
succeeds it will replace the current session. In the case of a SOFT_RESET
this a renegotiation and we will generated data channel keys at the of
key_method_2_write function as key-id > 0.

For a HARD RESET the key-id is 0. Since we already have gone through
connect stages and set context_auth to CAS_SUCCEEDED, we don't
call all the connect stages again, and therefore also never call
multi_client_generate_tls_keys for this session.

This commit changes postponing the key generation to be done only if
the multi_connect has not yet been finished.

Patch V2: Explain better in the commit message why this change is done.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 893e5753d..0da558392 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2240,7 +2240,8 @@ error:
  * to the TLS control channel (cleartext).
  */
 static bool
-key_method_2_write(struct buffer *buf, struct tls_session *session)
+key_method_2_write(struct buffer *buf, struct tls_multi *multi,
+                   struct tls_session *session)
 {
     struct key_state *ks = &session->key[KS_PRIMARY];      /* primary key */
 
@@ -2331,12 +2332,17 @@ key_method_2_write(struct buffer *buf, struct tls_session *session)
         goto error;
     }
 
-    /* Generate tunnel keys if we're a TLS server.
-     * If we're a p2mp server and IV_NCP >= 2 is negotiated, the first key
-     * generation is postponed until after the pull/push, so we can process pushed
-     * cipher directives.
+    /*
+     * Generate tunnel keys if we're a TLS server.
+     *
+     * If we're a p2mp server to allow NCP, the first key
+     * generation is postponed until after the connect script finished and the
+     * NCP options can be processed. Since that always happens at after connect
+     * script options are available the CAS_SUCCEEDED status is identical to
+     * NCP options are processed and we have no extra state for NCP finished.
      */
-    if (session->opt->server && !(session->opt->mode == MODE_SERVER && ks->key_id <= 0))
+    if (session->opt->server && (session->opt->mode != MODE_SERVER
+            || multi->multi_state == CAS_SUCCEEDED))
     {
         if (ks->authenticated > KS_AUTH_FALSE)
         {
@@ -2826,7 +2832,7 @@ tls_process(struct tls_multi *multi,
         if (!buf->len && ((ks->state == S_START && !session->opt->server)
                           || (ks->state == S_GOT_KEY && session->opt->server)))
         {
-            if (!key_method_2_write(buf, session))
+            if (!key_method_2_write(buf, multi, session))
             {
                 goto error;
             }
-- 
2.30.1


