From: Arne Schwabe <arne@...1227...>
Date: Mon, 13 Jul 2020 11:44:44 +0200
Message-Id: <20200713094444.13466-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Indicate that a client is in pull mode in
 IV_PROTO
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

This allows us to skip waiting for the first PUSH_REQUEST message from
the client to send the response.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/multi.c | 12 ++++++++++--
 src/openvpn/ssl.c   | 15 +++++++++++++--
 src/openvpn/ssl.h   |  7 +++++++
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index a2af071a..71a4af88 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1793,10 +1793,18 @@ multi_client_set_protocol_options(struct context *c)
     {
         int proto = 0;
         int r = sscanf(optstr, "IV_PROTO=%d", &proto);
-        if ((r == 1) && (proto >= 2))
+        if (r == 1)
         {
-            tls_multi->use_peer_id = true;
+            if (proto >= 2)
+            {
+                tls_multi->use_peer_id = true;
+            }
+            if (proto & IV_PROTO_REQUEST_PUSH)
+            {
+                c->c2.push_request_received = true;
+            }
         }
+
     }
 
     /* Select cipher if client supports Negotiable Crypto Parameters */
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 54a23011..04d78a81 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2299,8 +2299,19 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
         buf_printf(&out, "IV_PLAT=win\n");
 #endif
 
-        /* support for P_DATA_V2 */
-        buf_printf(&out, "IV_PROTO=2\n");
+        /* support for P_DATA_V2*/
+        int iv_proto = IV_PROTO_DATA_V2;
+
+        /* support for receiving push_reply before sending
+         * push request, also signal that the client wants
+         * to get push-reply messages without without requiring a round
+         * trip for a push request message*/
+        if(session->opt->pull)
+        {
+            iv_proto |= IV_PROTO_REQUEST_PUSH;
+        }
+
+        buf_printf(&out, "IV_PROTO=%d\n", iv_proto);
 
         /* support for Negotiable Crypto Parameters */
         if (session->opt->ncp_enabled
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 58a9b0d4..86fb6853 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -99,6 +99,13 @@
 /* Maximum length of OCC options string passed as part of auth handshake */
 #define TLS_OPTIONS_LEN 512
 
+/* Definitions of the bits in the IV_PROTO bitfield */
+#define IV_PROTO_DATA_V2        (1<<1)  /**< Support P_DATA_V2 */
+#define IV_PROTO_REQUEST_PUSH   (1<<2)  /**< Assume client will send a push
+                                          * request and server does not need
+                                          * to wait for a push-request to send
+                                          * a push-reply */
+
 /* Default field in X509 to be username */
 #define X509_USERNAME_FIELD_DEFAULT "CN"
 
-- 
2.26.2


