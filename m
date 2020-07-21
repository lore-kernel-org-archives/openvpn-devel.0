From: Arne Schwabe <arne@...1227...>
Date: Tue, 21 Jul 2020 18:38:11 +0200
Message-Id: <20200721163811.22745-1-arne@...1227...>
In-Reply-To: <0c06f527-c7a0-641e-6b4b-2c484e10d1c5@...2181...>
References: <0c06f527-c7a0-641e-6b4b-2c484e10d1c5@...2181...>
Subject: [Openvpn-devel] [PATCH 1/9 v3] Indicate that a client is in pull
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

Patch V3: Rewrite IV_PROTO paragraph in man page, incoperate spelling fixes
          by tincanteksup.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/man-sections/server-options.rst | 10 ++++++++--
 src/openvpn/multi.c                 | 12 ++++++++++--
 src/openvpn/ssl.c                   | 15 +++++++++++++--
 src/openvpn/ssl.h                   | 16 ++++++++++++++++
 4 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index c8e9fc61..babf33d3 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -464,8 +464,14 @@ fast hardware. SSL/TLS authentication must be used in this mode.
   :code:`IV_LZ4=1`
         If the client supports LZ4 compressions.
 
-  :code:`IV_PROTO=2`
-        If the client supports peer-id floating mechanism
+  :code:`IV_PROTO`
+    Details about protocol extensions that the peer supports. The
+    variable is a bitfield and the bits are defined as follows
+    (starting a bit 0 for the first (unused) bit:
+
+    - bit 1: The peer supports peer-id floating mechanism
+    - bit 2: The client expects a push-reply and the server may
+      send this reply without waiting for a push-request first.
 
   :code:`IV_NCP=2`
         Negotiable ciphers, client supports ``--cipher`` pushed by
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 2ae9c03e..b83a0f06 100644
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
index 58a9b0d4..0da16974 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -99,6 +99,22 @@
 /* Maximum length of OCC options string passed as part of auth handshake */
 #define TLS_OPTIONS_LEN 512
 
+/* Definitions of the bits in the IV_PROTO bitfield
+ *
+ * In older OpenVPN versions this used in a comparison
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


