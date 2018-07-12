From: Antonio Quartulli <a@...2181...>
Date: Thu, 12 Jul 2018 09:29:55 +0800
Message-Id: <20180712012955.24050-1-a@...2181...>
In-Reply-To: <20180711170042.15154-1-a@...2181...>
References: <20180711170042.15154-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH v3] socket: make stream_buf_* functions
 static
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
Cc: Antonio Quartulli <a@...2181...>

stream_buf_init(), stream_buf_close() and stream_buf_added()
are only used within socket.c, therefore there is noneed to
have them declared in socket.h.

Make them static and remove useless declarations.
This change reuired adding function prototypes in socket.c to
avoid useless code re-ordering.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
v2:
- fix commit subject
v3:
- move functions back to their original locations and add prototypes
  before the first usage of the three functions
---
 src/openvpn/socket.c | 22 +++++++++++++++++++---
 src/openvpn/socket.h | 15 ---------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 211e7441..29de56fd 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1491,6 +1491,22 @@ done:
     gc_free(&gc);
 }
 
+/*
+ * Stream buffer handling prototypes -- stream_buf is a helper class
+ * to assist in the packetization of stream transport protocols
+ * such as TCP.
+ */
+
+static void
+stream_buf_init(struct stream_buf *sb, struct buffer *buf,
+                const unsigned int sockflags, const int proto);
+
+static void
+stream_buf_close(struct stream_buf *sb);
+
+static bool
+stream_buf_added(struct stream_buf *sb, int length_added);
+
 /* For stream protocols, allocate a buffer to build up packet.
  * Called after frame has been finalized. */
 
@@ -2500,7 +2516,7 @@ stream_buf_reset(struct stream_buf *sb)
     sb->len = -1;
 }
 
-void
+static void
 stream_buf_init(struct stream_buf *sb,
                 struct buffer *buf,
                 const unsigned int sockflags,
@@ -2574,7 +2590,7 @@ stream_buf_read_setup_dowork(struct link_socket *sock)
     return !sock->stream_buf.residual_fully_formed;
 }
 
-bool
+static bool
 stream_buf_added(struct stream_buf *sb,
                  int length_added)
 {
@@ -2641,7 +2657,7 @@ stream_buf_added(struct stream_buf *sb,
     }
 }
 
-void
+static void
 stream_buf_close(struct stream_buf *sb)
 {
     free_buf(&sb->residual);
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 479d1150..7329a518 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -994,21 +994,6 @@ link_socket_set_outgoing_addr(const struct buffer *buf,
     }
 }
 
-/*
- * Stream buffer handling -- stream_buf is a helper class
- * to assist in the packetization of stream transport protocols
- * such as TCP.
- */
-
-void stream_buf_init(struct stream_buf *sb,
-                     struct buffer *buf,
-                     const unsigned int sockflags,
-                     const int proto);
-
-void stream_buf_close(struct stream_buf *sb);
-
-bool stream_buf_added(struct stream_buf *sb, int length_added);
-
 static inline bool
 stream_buf_read_setup(struct link_socket *sock)
 {
-- 
2.18.0


