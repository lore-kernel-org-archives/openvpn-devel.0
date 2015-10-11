From: Lev Stipakov <lstipakov@...277...>
Date: Sun, 11 Oct 2015 13:15:31 +0300
Message-Id: <1444558531-18241-1-git-send-email-lstipakov@...277...>
In-Reply-To: <561A26DA.6060808@...1114...>
References: <561A26DA.6060808@...1114...>
Subject: [Openvpn-devel] [PATCH] Fix compilation with --disable-server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Add missing #if P2MP_SERVER
---
 src/openvpn/push.c | 2 ++
 src/openvpn/push.h | 5 ++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 704818d..a4cb726 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -410,6 +410,7 @@ push_reset (struct options *o)
 }
 #endif
 
+#if P2MP_SERVER
 int
 process_incoming_push_request (struct context *c)
 {
@@ -449,6 +450,7 @@ process_incoming_push_request (struct context *c)
 
   return ret;
 }
+#endif
 
 int
 process_incoming_push_msg (struct context *c,
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 5eca45f..fa06e08 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -37,9 +37,6 @@
 #define PUSH_MSG_CONTINUATION     5
 #define PUSH_MSG_ALREADY_REPLIED  6
 
-void incoming_push_message (struct context *c,
-			    const struct buffer *buffer);
-
 int process_incoming_push_request (struct context *c);
 
 int process_incoming_push_msg (struct context *c,
@@ -56,6 +53,8 @@ void server_pushed_signal (struct context *c, const struct buffer *buffer, const
 
 #if P2MP_SERVER
 
+void incoming_push_message (struct context *c, const struct buffer *buffer);
+
 void clone_push_list (struct options *o);
 
 void push_option (struct options *o, const char *opt, int msglevel);
-- 
1.9.1


