From: Lev Stipakov <lstipakov@...277...>
Date: Fri,  7 Oct 2016 22:46:51 +0300
Message-Id: <1475869611-30771-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Use separate list for per-client push
	options
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

Move client-specific push options (currently peer-id and cipher) to
separate list, which is deallocated after push_reply
has been send. This makes sure that options are fit into buf,
not duplicated nor leak memory on renegotiation.

Signed-off-by: Lev Stipakov <lstipakov@...277...>
---
 src/openvpn/push.c | 142 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 83 insertions(+), 59 deletions(-)

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index a1b999e..a968c29 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -40,26 +40,29 @@
 
 #if P2MP
 
+static char push_reply_cmd[] = "PUSH_REPLY";
+
 /**
- * Add an option to the push list by providing a format string.
+ * Add an option to the given push list by providing a format string.
  *
  * The string added to the push options is allocated in o->gc, so the caller
  * does not have to preserve anything.
  *
- * @param o		The current connection's options
- * @param msglevel	The message level to use when printing errors
+ * @param gc		GC arena where options are allocated
+ * @param push_list Push list containing options
+ * @param msglevel  The message level to use when printing errors
  * @param fmt		Format string for the option
  * @param ...		Format string arguments
  *
  * @return true on success, false on failure.
  */
-static bool push_option_fmt(struct options *o, int msglevel,
+static bool push_option_fmt(struct gc_arena *gc, struct push_list *push_list, int msglevel,
     const char *fmt, ...)
 #ifdef __GNUC__
 #if __USE_MINGW_ANSI_STDIO
-    __attribute__ ((format (gnu_printf, 3, 4)))
+    __attribute__ ((format (gnu_printf, 4, 5)))
 #else
-    __attribute__ ((format (__printf__, 3, 4)))
+    __attribute__ ((format (__printf__, 4, 5)))
 #endif
 #endif
     ;
@@ -296,12 +299,14 @@ send_push_request (struct context *c)
  * Prepare push options, based on local options and available peer info.
  *
  * @param options	Connection options
+ * @param gc     	gc arena for allocating push options
+ * @param push_list     push list to where options are added
  * @param tls_multi	TLS state structure for the current tunnel
  *
  * @return true on success, false on failure.
  */
 static bool
-prepare_push_reply (struct options *o, struct tls_multi *tls_multi)
+prepare_push_reply (struct options *o, struct gc_arena *gc, struct push_list *push_list, struct tls_multi *tls_multi)
 {
   const char *optstr = NULL;
   const char * const peer_info = tls_multi->peer_info;
@@ -314,7 +319,7 @@ prepare_push_reply (struct options *o, struct tls_multi *tls_multi)
       int r = sscanf(optstr, "IV_PROTO=%d", &proto);
       if ((r == 1) && (proto >= 2))
 	{
-	  push_option_fmt(o, M_USAGE, "peer-id %d", tls_multi->peer_id);
+	  push_option_fmt(gc, push_list, M_USAGE, "peer-id %d", tls_multi->peer_id);
 	}
     }
 
@@ -335,29 +340,63 @@ prepare_push_reply (struct options *o, struct tls_multi *tls_multi)
 	{
 	  /* Push the first cipher from --ncp-ciphers to the client.
 	   * TODO: actual negotiation, instead of server dictatorship. */
-	  char *push_cipher = string_alloc(o->ncp_ciphers, &o->gc);
+	  char *push_cipher = string_alloc(o->ncp_ciphers, gc);
 	  o->ciphername = strtok (push_cipher, ":");
-	  push_option_fmt(o, M_USAGE, "cipher %s", o->ciphername);
+	  push_option_fmt(gc, push_list, M_USAGE, "cipher %s", o->ciphername);
 	}
     }
   return true;
 }
 
 static bool
-send_push_reply (struct context *c)
+send_push_options (struct context *c, struct buffer *buf, struct push_list *push_list,
+    int safe_cap, bool *push_sent, bool *multi_push)
+{
+  struct push_entry *e = push_list->head;
+
+  while (e)
+    {
+      if (e->enable)
+	{
+	  const int l = strlen (e->option);
+	  if (BLEN (buf) + l >= safe_cap)
+	    {
+	      buf_printf (buf, ",push-continuation 2");
+		{
+		  const bool status = send_control_channel_string (c, BSTR (buf), D_PUSH);
+		  if (!status)
+		    return false;
+		  *push_sent = true;
+		  *multi_push = true;
+		  buf_reset_len (buf);
+		  buf_printf (buf, "%s", push_reply_cmd);
+		}
+	    }
+	  if (BLEN (buf) + l >= safe_cap)
+	    {
+	      msg (M_WARN, "--push option is too long");
+	      return false;
+	    }
+	  buf_printf (buf, ",%s", e->option);
+	}
+      e = e->next;
+    }
+  return true;
+}
+
+static bool
+send_push_reply (struct context *c, struct push_list *per_client_push_list)
 {
   struct gc_arena gc = gc_new ();
   struct buffer buf = alloc_buf_gc (PUSH_BUNDLE_SIZE, &gc);
-  struct push_entry *e = c->options.push_list.head;
   bool multi_push = false;
-  static char cmd[] = "PUSH_REPLY";
   const int extra = 84; /* extra space for possible trailing ifconfig and push-continuation */
   const int safe_cap = BCAP (&buf) - extra;
   bool push_sent = false;
 
   msg( M_INFO, "send_push_reply(): safe_cap=%d", safe_cap );
 
-  buf_printf (&buf, "%s", cmd);
+  buf_printf (&buf, "%s", push_reply_cmd);
 
   if ( c->c2.push_ifconfig_ipv6_defined &&
           !c->options.push_ifconfig_ipv6_blocked )
@@ -374,33 +413,13 @@ send_push_reply (struct context *c)
 	}
     }
 
-  while (e)
-    {
-      if (e->enable)
-	{
-	  const int l = strlen (e->option);
-	  if (BLEN (&buf) + l >= safe_cap)
-	    {
-	      buf_printf (&buf, ",push-continuation 2");
-	      {
-		const bool status = send_control_channel_string (c, BSTR (&buf), D_PUSH);
-		if (!status)
-		  goto fail;
-		push_sent = true;
-		multi_push = true;
-		buf_reset_len (&buf);
-		buf_printf (&buf, "%s", cmd);
-	      }
-	    }
-	  if (BLEN (&buf) + l >= safe_cap)
-	    {
-	      msg (M_WARN, "--push option is too long");
-	      goto fail;
-	    }
-	  buf_printf (&buf, ",%s", e->option);
-	}
-      e = e->next;
-    }
+  /* send options which are common tp all clients */
+  if (!send_push_options (c, &buf, &c->options.push_list, safe_cap, &push_sent, &multi_push))
+    goto fail;
+
+  /* send client-specific options */ 
+  if (!send_push_options (c, &buf, per_client_push_list, safe_cap, &push_sent, &multi_push))
+    goto fail;
 
   if (c->c2.push_ifconfig_defined && c->c2.push_ifconfig_local && c->c2.push_ifconfig_remote_netmask)
     {
@@ -414,7 +433,7 @@ send_push_reply (struct context *c)
   if (multi_push)
     buf_printf (&buf, ",push-continuation 1");
 
-  if (BLEN (&buf) > sizeof(cmd)-1)
+  if (BLEN (&buf) > sizeof(push_reply_cmd)-1)
     {
       const bool status = send_control_channel_string (c, BSTR (&buf), D_PUSH);
       if (!status)
@@ -430,7 +449,7 @@ send_push_reply (struct context *c)
       bool status = false;
 
       buf_reset_len (&buf);
-      buf_printf (&buf, "%s", cmd);
+      buf_printf (&buf, "%s", push_reply_cmd);
       status = send_control_channel_string (c, BSTR(&buf), D_PUSH);
       if (!status)
 	goto fail;
@@ -445,7 +464,7 @@ send_push_reply (struct context *c)
 }
 
 static void
-push_option_ex (struct options *o, const char *opt, bool enable, int msglevel)
+push_option_ex (struct gc_arena *gc, struct push_list *push_list, const char *opt, bool enable, int msglevel)
 {
   if (!string_class (opt, CC_ANY, CC_COMMA))
     {
@@ -454,20 +473,20 @@ push_option_ex (struct options *o, const char *opt, bool enable, int msglevel)
   else
     {
       struct push_entry *e;
-      ALLOC_OBJ_CLEAR_GC (e, struct push_entry, &o->gc);
+      ALLOC_OBJ_CLEAR_GC (e, struct push_entry, gc);
       e->enable = true;
       e->option = opt;
-      if (o->push_list.head)
+      if (push_list->head)
 	{
-	  ASSERT(o->push_list.tail);
-	  o->push_list.tail->next = e;
-	  o->push_list.tail = e;
+	  ASSERT(push_list->tail);
+	  push_list->tail->next = e;
+	  push_list->tail = e;
 	}
       else
 	{
-	  ASSERT(!o->push_list.tail);
-	  o->push_list.head = e;
-	  o->push_list.tail = e;
+	  ASSERT(!push_list->tail);
+	  push_list->head = e;
+	  push_list->tail = e;
 	}
     }
 }
@@ -475,7 +494,7 @@ push_option_ex (struct options *o, const char *opt, bool enable, int msglevel)
 void
 push_option (struct options *o, const char *opt, int msglevel)
 {
-  push_option_ex (o, opt, true, msglevel);
+  push_option_ex (&o->gc, &o->push_list, opt, true, msglevel);
 }
 
 void
@@ -487,7 +506,7 @@ clone_push_list (struct options *o)
       push_reset (o);
       while (e)
 	{
-	  push_option_ex (o, string_alloc (e->option, &o->gc), true, M_FATAL);
+	  push_option_ex (&o->gc, &o->push_list, string_alloc (e->option, &o->gc), true, M_FATAL);
 	  e = e->next;
 	}
     }
@@ -501,18 +520,18 @@ push_options (struct options *o, char **p, int msglevel, struct gc_arena *gc)
   push_option (o, opt, msglevel);
 }
 
-static bool push_option_fmt(struct options *o, int msglevel,
+static bool push_option_fmt(struct gc_arena *gc, struct push_list *push_list, int msglevel,
     const char *format, ...)
 {
   va_list arglist;
   char tmp[256] = {0};
-  int len = -1;
+  int len;
   va_start (arglist, format);
   len = vsnprintf (tmp, sizeof(tmp), format, arglist);
   va_end (arglist);
   if (len > sizeof(tmp)-1)
     return false;
-  push_option (o, string_alloc (tmp, &o->gc), msglevel);
+  push_option_ex (gc, push_list, string_alloc (tmp, gc), true, msglevel);
   return true;
 }
 
@@ -580,12 +599,17 @@ process_incoming_push_request (struct context *c)
 	}
       else
 	{
-	  if (prepare_push_reply(&c->options, c->c2.tls_multi) &&
-	      send_push_reply (c))
+	  struct push_list push_list; /* per-client push options */
+	  struct gc_arena gc = gc_new ();
+
+	  CLEAR (push_list);
+	  if (prepare_push_reply (&c->options, &gc, &push_list, c->c2.tls_multi) &&
+	      send_push_reply (c, &push_list))
 	    {
 	      ret = PUSH_MSG_REQUEST;
 	      c->c2.sent_push_reply_expiry = now + 30;
 	    }
+	  gc_free(&gc);
 	}
     }
   else
-- 
1.9.1


