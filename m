From: Steffan Karger <steffan@...1856...>
Date: Sun,  7 Feb 2016 20:47:18 +0100
Message-Id: <1454874438-5081-11-git-send-email-steffan@...1856...>
In-Reply-To: <1454874438-5081-1-git-send-email-steffan@...1856...>
References: <1454874438-5081-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 10/10] Add preliminary server-side support
	for negotiable crypto parameters
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

Add preliminary support for Negotiable Crypto Parameters 'level 2'
(IV_NCP=2), as proposed by James Yonan on the openvpn-devel mailinglist:
http://comments.gmane.org/gmane.network.openvpn.devel/9385

This patch:
 * Makes the server advertise "IV_NCP=2", if --push-peer-info 2 is enabled.
 * Pushes a 'cipher XXX' directive to the client, if the client advertises
   "IV_NCP=2", where XXX is the cipher set in the server config file.

This enables clients that have support for IV_NCP to connect to a server,
even when the client does not have the correct cipher specified in it's
config file.

Since pushing the cipher directive is quite similar to pushing peer-id, I
moved peer-id pushing to same prepare_push_reply() function I created for
pushing cipher.  Adding these directives as regular push options allows us
to use the existing 'push-continuation' infrastructure.  Note that we
should not reduce safe_cap in send_push_reply, because it was never
increased to account for peer-id.

This is a preliminary patch, which will be followed by more patches to add
client support, and configurability.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/push.c | 97 +++++++++++++++++++++++++++++++++++++++++++++---------
 src/openvpn/push.h |  2 --
 src/openvpn/ssl.c  |  4 +++
 3 files changed, 86 insertions(+), 17 deletions(-)

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index d4f3cb6..051aef6 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -40,6 +40,30 @@
 
 #if P2MP
 
+/**
+ * Add an option to the push list by providing a format string.
+ *
+ * The string added to the push options is allocated in o->gc, so fmt may be
+ * free'd by the caller before the option is sent to the peer.
+ *
+ * @param o		The current connection's options
+ * @param msglevel	The message level to use when printing errors
+ * @param fmt		Format string for the option
+ * @param ...		Format string arguments
+ *
+ * @return true on success, false on failure.
+ */
+static bool push_option_fmt(struct options *o, int msglevel,
+    const char *fmt, ...)
+#ifdef __GNUC__
+#if __USE_MINGW_ANSI_STDIO
+    __attribute__ ((format (gnu_printf, 3, 4)))
+#else
+    __attribute__ ((format (__printf__, 3, 4)))
+#endif
+#endif
+    ;
+
 /*
  * Auth username/password
  *
@@ -239,7 +263,47 @@ send_push_request (struct context *c)
 
 #if P2MP_SERVER
 
-bool
+/**
+ * Prepare push options, based on local options and available peer info.
+ *
+ * @param options	Connection options
+ * @param tls_multi	TLS state structure for the current tunnel
+ *
+ * @return true on success, false on failure.
+ */
+static bool
+prepare_push_reply (struct options *o, struct tls_multi *tls_multi)
+{
+  const char *optstr = NULL;
+  const char * const peer_info = tls_multi->peer_info;
+
+  /* Send peer-id if client supports it */
+  optstr = peer_info ? strstr(peer_info, "IV_PROTO=") : NULL;
+  if (optstr)
+    {
+      int proto = 0;
+      int r = sscanf(optstr, "IV_PROTO=%d", &proto);
+      if ((r == 1) && (proto >= 2))
+	{
+	  push_option_fmt(o, M_USAGE, "peer-id %d", tls_multi->peer_id);
+	}
+    }
+
+  /* Push cipher if client supports Negotiable Crypto Parameters */
+  optstr = peer_info ? strstr(peer_info, "IV_NCP=") : NULL;
+  if (optstr)
+    {
+      int ncp = 0;
+      int r = sscanf(optstr, "IV_NCP=%d", &ncp);
+      if ((r == 1) && (ncp == 2))
+	{
+	  push_option_fmt(o, M_USAGE, "cipher %s", o->ciphername);
+	}
+    }
+  return true;
+}
+
+static bool
 send_push_reply (struct context *c)
 {
   struct gc_arena gc = gc_new ();
@@ -309,19 +373,6 @@ send_push_reply (struct context *c)
   if (multi_push)
     buf_printf (&buf, ",push-continuation 1");
 
-  /* Send peer-id if client supports it */
-  if (c->c2.tls_multi->peer_info)
-    {
-      const char* proto_str = strstr(c->c2.tls_multi->peer_info, "IV_PROTO=");
-      if (proto_str)
-	{
-	  int proto = 0;
-	  int r = sscanf(proto_str, "IV_PROTO=%d", &proto);
-	  if ((r == 1) && (proto >= 2))
-	    buf_printf(&buf, ",peer-id %d", c->c2.tls_multi->peer_id);
-	}
-  }
-
   if (BLEN (&buf) > sizeof(cmd)-1)
     {
       const bool status = send_control_channel_string (c, BSTR (&buf), D_PUSH);
@@ -409,6 +460,21 @@ push_options (struct options *o, char **p, int msglevel, struct gc_arena *gc)
   push_option (o, opt, msglevel);
 }
 
+static bool push_option_fmt(struct options *o, int msglevel,
+    const char *format, ...)
+{
+  va_list arglist;
+  char tmp[256] = {0};
+  int len = -1;
+  va_start (arglist, format);
+  len = vsnprintf (tmp, sizeof(tmp), format, arglist);
+  va_end (arglist);
+  if (len > sizeof(tmp)-1)
+    return false;
+  push_option (o, string_alloc (tmp, &o->gc), msglevel);
+  return true;
+}
+
 void
 push_reset (struct options *o)
 {
@@ -442,7 +508,8 @@ process_incoming_push_request (struct context *c)
 	}
       else
 	{
-	  if (send_push_reply (c))
+	  if (prepare_push_reply(&c->options, c->c2.tls_multi) &&
+	      send_push_reply (c))
 	    {
 	      ret = PUSH_MSG_REQUEST;
 	      c->c2.sent_push_reply_expiry = now + 30;
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index fa06e08..19bbf5e 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -62,8 +62,6 @@ void push_options (struct options *o, char **p, int msglevel, struct gc_arena *g
 
 void push_reset (struct options *o);
 
-bool send_push_reply (struct context *c);
-
 void remove_iroutes_from_push_route_list (struct options *o);
 
 void send_auth_failed (struct context *c, const char *client_reason);
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 7156030..1d811b1 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1883,6 +1883,10 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
       /* support for P_DATA_V2 */
       buf_printf(&out, "IV_PROTO=2\n");
 
+      /* support for Negotiable Crypto Paramters */
+      if (session->opt->server)
+	buf_printf(&out, "IV_NCP=2\n");
+
       /* push compression status */
 #ifdef USE_COMP
       comp_generate_peer_info_string(&session->opt->comp_options, &out);
-- 
2.5.0


