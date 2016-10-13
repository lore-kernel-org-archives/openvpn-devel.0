From: David Sommerseth <davids@...515...>
Date: Thu, 13 Oct 2016 21:59:30 +0200
Message-Id: <1476388771-16492-5-git-send-email-davids@...515...>
In-Reply-To: <1476388771-16492-1-git-send-email-davids@...515...>
References: <1476388771-16492-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH 4/5] auth-gen-token: Push generated
	auth-tokens to the client
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

If --auth-gen-token has been enabled and a token has been generated,
ensure this token is pushed to the client using the 'auth-token' option.

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/misc.c       | 5 +++++
 src/openvpn/push.c       | 9 ++++++++-
 src/openvpn/ssl_common.h | 2 ++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 225f0bf..b74ac9d 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -2073,6 +2073,11 @@ sanitize_control_message(const char *src, struct gc_arena *gc)
 	  skip = 4;
 	  redact = true;
 	}
+      else if (!check_debug_level(D_SHOW_KEYS) && (c == 'a' && !strncmp(src, "auth-token ", 11)))
+	{
+	  skip = 10;
+	  redact = true;
+	}
 
       if (c == ',') /* end of redacted item? */
 	{
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index ee2eda4..0fb87ba 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -309,7 +309,7 @@ prepare_push_reply (struct context *c, struct gc_arena *gc,
 		    struct push_list *push_list)
 {
   const char *optstr = NULL;
-  const struct tls_multi *tls_multi = c->c2.tls_multi;
+  struct tls_multi *tls_multi = c->c2.tls_multi;
   const char * const peer_info = tls_multi->peer_info;
   struct options *o = &c->options;
 
@@ -371,6 +371,13 @@ prepare_push_reply (struct context *c, struct gc_arena *gc,
 	  push_option_fmt(gc, push_list, M_USAGE, "cipher %s", o->ciphername);
 	}
     }
+
+  /* If server uses --auth-gen-token and we have an auth token to send to client */
+  if (false == tls_multi->auth_token_sent && NULL != tls_multi->auth_token)
+    {
+      push_option_fmt(gc, push_list, M_USAGE, "auth-token %s", tls_multi->auth_token);
+      tls_multi->auth_token_sent = true;
+    }
   return true;
 }
 
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 1b90c5e..3d802c9 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -526,6 +526,8 @@ struct tls_multi
   uint32_t peer_id;
   bool use_peer_id;
 
+  bool auth_token_sent;  /**< If server uses --auth-gen-token and
+                          *   token has been sent to client */
   char *auth_token;      /** If server sends a generated auth-token,
                           * this is the token to use for future
                           * user/pass authentications in this session.
-- 
1.8.3.1


