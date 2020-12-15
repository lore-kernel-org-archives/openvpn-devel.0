From: Arne Schwabe <arne@...1227...>
Date: Tue, 15 Dec 2020 17:42:21 +0100
Message-Id: <20201215164221.5995-2-arne@...1227...>
In-Reply-To: <20201215164221.5995-1-arne@...1227...>
References: <20201215164221.5995-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 2/2] Fix condition to generate session keys
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

For --nobind clients OpenVPN reuses the context and tls_multi structs
of the previous clients and does not rerun the connect scripts on
connect. But since it is a new client connection, the key_id is 0 and
we postpone the key generation but it will never happen.

This commit changes postponing the key generation to the right
condition of NCP done for this session.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index efbf688f..5d322598 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2351,7 +2351,7 @@ error:
  * to the TLS control channel (cleartext).
  */
 static bool
-key_method_2_write(struct buffer *buf, struct tls_session *session)
+key_method_2_write(struct buffer *buf, struct tls_multi *multi, struct tls_session *session)
 {
     struct key_state *ks = &session->key[KS_PRIMARY];      /* primary key */
 
@@ -2442,12 +2442,17 @@ key_method_2_write(struct buffer *buf, struct tls_session *session)
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
+            || multi->context_auth == CAS_SUCCEEDED))
     {
         if (ks->authenticated > KS_AUTH_FALSE)
         {
@@ -2936,7 +2941,7 @@ tls_process(struct tls_multi *multi,
         if (!buf->len && ((ks->state == S_START && !session->opt->server)
                           || (ks->state == S_GOT_KEY && session->opt->server)))
         {
-            if (!key_method_2_write(buf, session))
+            if (!key_method_2_write(buf, multi, session))
             {
                 goto error;
             }
-- 
2.26.2


