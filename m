From: Lev Stipakov <lstipakov@...277...>
Date: Sat, 24 Sep 2016 13:23:59 +0300
Message-Id: <1474712639-11698-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Fix duplicated PUSH_REPLY options
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

Starting from https://github.com/OpenVPN/openvpn/commit/3a5a46cf2b7f6a8b8520c2513a8054deb48bfcbe,
we add peer-id and cipher values to context->options->push_list instead of adding those directly
to buf (as done for client-specific values, like ifconfig). Since push_list is per child context,
when options are added and context is reused - we got duplicates.

Fixed by adding options to buffer, as it was done previously.

Signed-off-by: Lev Stipakov <lstipakov@...277...>
---
 src/openvpn/push.c | 83 +++++++++++++++---------------------------------------
 1 file changed, 22 insertions(+), 61 deletions(-)

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index a1b999e..5220bf0 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -40,30 +40,6 @@
 
 #if P2MP
 
-/**
- * Add an option to the push list by providing a format string.
- *
- * The string added to the push options is allocated in o->gc, so the caller
- * does not have to preserve anything.
- *
- * @param o		The current connection's options
- * @param msglevel	The message level to use when printing errors
- * @param fmt		Format string for the option
- * @param ...		Format string arguments
- *
- * @return true on success, false on failure.
- */
-static bool push_option_fmt(struct options *o, int msglevel,
-    const char *fmt, ...)
-#ifdef __GNUC__
-#if __USE_MINGW_ANSI_STDIO
-    __attribute__ ((format (gnu_printf, 3, 4)))
-#else
-    __attribute__ ((format (__printf__, 3, 4)))
-#endif
-#endif
-    ;
-
 /*
  * Auth username/password
  *
@@ -293,31 +269,31 @@ send_push_request (struct context *c)
 #if P2MP_SERVER
 
 /**
- * Prepare push options, based on local options and available peer info.
+ * Add peer specific options, based on local options and peer info.
  *
- * @param options	Connection options
  * @param tls_multi	TLS state structure for the current tunnel
+ * @param options	Connection options
+ * @param buf		buffer to where options are added
  *
- * @return true on success, false on failure.
  */
-static bool
-prepare_push_reply (struct options *o, struct tls_multi *tls_multi)
+static void
+add_peer_specific_opts (struct tls_multi *tls_multi, struct options *o, struct buffer *buf)
 {
-  const char *optstr = NULL;
   const char * const peer_info = tls_multi->peer_info;
-
+  const char *optstr = NULL;
+  
   /* Send peer-id if client supports it */
-  optstr = peer_info ? strstr(peer_info, "IV_PROTO=") : NULL;
+  optstr = peer_info ? strstr (peer_info, "IV_PROTO=") : NULL;
   if (optstr)
-    {
-      int proto = 0;
-      int r = sscanf(optstr, "IV_PROTO=%d", &proto);
-      if ((r == 1) && (proto >= 2))
-	{
-	  push_option_fmt(o, M_USAGE, "peer-id %d", tls_multi->peer_id);
-	}
-    }
-
+  {
+    int proto = 0;
+    int r = sscanf (optstr, "IV_PROTO=%d", &proto);
+    if ((r == 1) && (proto >= 2))
+      {
+	buf_printf (buf, ",peer-id %d", tls_multi->peer_id);
+      }
+  }
+	
   /* Push cipher if client supports Negotiable Crypto Parameters */
   if (tls_peer_info_ncp_ver (peer_info) >= 2 && o->ncp_enabled)
     {
@@ -335,12 +311,11 @@ prepare_push_reply (struct options *o, struct tls_multi *tls_multi)
 	{
 	  /* Push the first cipher from --ncp-ciphers to the client.
 	   * TODO: actual negotiation, instead of server dictatorship. */
-	  char *push_cipher = string_alloc(o->ncp_ciphers, &o->gc);
+	  char *push_cipher = string_alloc (o->ncp_ciphers, &o->gc);
 	  o->ciphername = strtok (push_cipher, ":");
-	  push_option_fmt(o, M_USAGE, "cipher %s", o->ciphername);
+	  buf_printf (buf, ",cipher %s", o->ciphername);
 	}
     }
-  return true;
 }
 
 static bool
@@ -414,6 +389,8 @@ send_push_reply (struct context *c)
   if (multi_push)
     buf_printf (&buf, ",push-continuation 1");
 
+  add_peer_specific_opts (c->c2.tls_multi, &c->options, &buf);
+
   if (BLEN (&buf) > sizeof(cmd)-1)
     {
       const bool status = send_control_channel_string (c, BSTR (&buf), D_PUSH);
@@ -501,21 +478,6 @@ push_options (struct options *o, char **p, int msglevel, struct gc_arena *gc)
   push_option (o, opt, msglevel);
 }
 
-static bool push_option_fmt(struct options *o, int msglevel,
-    const char *format, ...)
-{
-  va_list arglist;
-  char tmp[256] = {0};
-  int len = -1;
-  va_start (arglist, format);
-  len = vsnprintf (tmp, sizeof(tmp), format, arglist);
-  va_end (arglist);
-  if (len > sizeof(tmp)-1)
-    return false;
-  push_option (o, string_alloc (tmp, &o->gc), msglevel);
-  return true;
-}
-
 void
 push_reset (struct options *o)
 {
@@ -580,8 +542,7 @@ process_incoming_push_request (struct context *c)
 	}
       else
 	{
-	  if (prepare_push_reply(&c->options, c->c2.tls_multi) &&
-	      send_push_reply (c))
+	  if (send_push_reply (c))
 	    {
 	      ret = PUSH_MSG_REQUEST;
 	      c->c2.sent_push_reply_expiry = now + 30;
-- 
1.9.1


