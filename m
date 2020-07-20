From: Arne Schwabe <arne@...1227...>
Date: Mon, 20 Jul 2020 11:17:00 +0200
Message-Id: <20200720091700.30271-1-arne@...1227...>
In-Reply-To: <E1jxQx3-0003xM-Ke@...2487...>
References: <E1jxQx3-0003xM-Ke@...2487...>
Subject: [Openvpn-devel] [PATCH v2 1/9] Indicate that a client is in pull
 mode in IV_PROTO
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

This changes the interpretation of IV_PROTO from a scalar to a bitfield
Since we only have IV_PROTO=2 defined so far and will support DATA_V2
this should not make any problem. This avoid adding another IV_xxx variable
that takes valuable space in the protocol frame.

Signed-off-by: Arne Schwabe <arne@...1227...>

Patch V2: Use bitmask for IV_PROTO_DATA_V2 and add more documentation.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/man-sections/server-options.rst |  6 +++++-
 src/openvpn/multi.c                 | 12 ++++++++++--
 src/openvpn/ssl.c                   | 15 +++++++++++++--
 src/openvpn/ssl.h                   | 16 ++++++++++++++++
 4 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index c8e9fc61..e24cb135 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -464,9 +464,13 @@ fast hardware. SSL/TLS authentication must be used in this mode.
   :code:`IV_LZ4=1`
         If the client supports LZ4 compressions.
 
-  :code:`IV_PROTO=2`
+  :code:`IV_PROTO=2` (bit 2)
         If the client supports peer-id floating mechanism
 
+  :code:`IV_PROTO=4` (bit 3)
+        When the client expects a push-reply and the server may
+        send this reply without waiting for a push-request first.
+
   :code:`IV_NCP=2`
         Negotiable ciphers, client supports ``--cipher`` pushed by
         the server, a value of 2 or greater indicates client supports
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index d9456f34..cb950db5 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1792,10 +1792,18 @@ multi_client_set_protocol_options(struct context *c)
     {
         int proto = 0;
         int r = sscanf(optstr, "IV_PROTO=%d", &proto);
-        if ((r == 1) && (proto >= 2))
+        if (r == 1)
         {
-            tls_multi->use_peer_id = true;
+            if (proto & IV_PROTO_DATA_V2)
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
index 58a9b0d4..81f8810e 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -99,6 +99,22 @@
 /* Maximum length of OCC options string passed as part of auth handshake */
 #define TLS_OPTIONS_LEN 512
 
+/* Definitions of the bits in the IV_PROTO bitfield
+ *
+ * In older OpenVPN versions this used as comparision
+ * IV_PROTO >= 2 to determine if DATA_V2 is supported.
+ * Therefore any client announcing any of the flags must
+ * also announce IV_PROTO_DATA_V2. We also treat bit 0
+ * as reserved for this reason */
+
+/** Support P_DATA_V2 */
+#define IV_PROTO_DATA_V2        (1<<1)
+
+/** Assume client will send a push request and server does not need
+ * to wait for a push-request to send a push-reply */
+#define IV_PROTO_REQUEST_PUSH   (1<<2)
+
+
 /* Default field in X509 to be username */
 #define X509_USERNAME_FIELD_DEFAULT "CN"
 
-- 
2.26.2


