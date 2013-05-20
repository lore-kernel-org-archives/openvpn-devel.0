From: Gert Doering <gert@...1296...>
Date: Mon, 20 May 2013 12:13:21 +0200
Message-Id: <1369044801-7594-1-git-send-email-gert@...1296...>
In-Reply-To: <1366393268-27392-1-git-send-email-gert@...1296...>
References: <1366393268-27392-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH 4/5 v3] Always push basic set of peer info
	values to server.
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

From: James Yonan <james@...515...>

On the client, allow certain peer info fields to be pushed even if
push-peer-info isn't specified in the config.

This is needed to allow the compression handshake to work correctly
(i.e. where the client indicates its support for LZO and/or Snappy).

Fields that have privacy implications such as Mac Address and UV_*
environment variables will not be pushed to the server as before unless
push-peer-info is specified by client config.

v1: equivalent to OpenVPN SVN r8225 (2.1.21c)

v2: distinguish 3 levels of peer-info detail

  --push-peer-info specified --> send all we have
  --pull           specified --> send basic set, as per r8225
  default                    --> send nothing (do not leak from server)

v3: undo extra whitespace changes in v1 and v2

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/init.c       |  7 ++++++-
 src/openvpn/ssl.c        | 31 ++++++++++++++++---------------
 src/openvpn/ssl_common.h |  2 +-
 3 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index e700cd6..2a0ba85 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2213,7 +2213,12 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
   to.renegotiate_seconds = options->renegotiate_seconds;
   to.single_session = options->single_session;
 #ifdef ENABLE_PUSH_PEER_INFO
-  to.push_peer_info = options->push_peer_info;
+  if (options->push_peer_info)		/* all there is */
+    to.push_peer_info_detail = 2;
+  else if (options->pull)		/* pull clients send some details */
+    to.push_peer_info_detail = 1;
+  else					/* default: no peer-info at all */
+    to.push_peer_info_detail = 0;
 #endif
 
   /* should we not xmit any packets until we get an initial
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 9ca409f..1026ad4 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1775,7 +1775,7 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
   bool ret = false;
 
 #ifdef ENABLE_PUSH_PEER_INFO
-  if (session->opt->push_peer_info) /* write peer info */
+  if (session->opt->push_peer_info_detail > 0)
     {
       struct env_set *es = session->opt->es;
       struct env_item *e;
@@ -1803,26 +1803,27 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
       buf_printf (&out, "IV_PLAT=win\n");
 #endif
 
-      /* push mac addr */
-      {
-	struct route_gateway_info rgi;
-	get_default_gateway (&rgi);
-	if (rgi.flags & RGI_HWADDR_DEFINED)
-	  buf_printf (&out, "IV_HWADDR=%s\n", format_hex_ex (rgi.hwaddr, 6, 0, 1, ":", &gc));
-      }
-
       /* push compression status */
 #ifdef USE_COMP
       comp_generate_peer_info_string(&session->opt->comp_options, &out);
 #endif
 
-      /* push env vars that begin with UV_ */
-      for (e=es->list; e != NULL; e=e->next)
-	{
-	  if (e->string)
+      if (session->opt->push_peer_info_detail >= 2)
+        {
+	  /* push mac addr */
+	  struct route_gateway_info rgi;
+	  get_default_gateway (&rgi);
+	  if (rgi.flags & RGI_HWADDR_DEFINED)
+	    buf_printf (&out, "IV_HWADDR=%s\n", format_hex_ex (rgi.hwaddr, 6, 0, 1, ":", &gc));
+
+	  /* push env vars that begin with UV_ */
+	  for (e=es->list; e != NULL; e=e->next)
 	    {
-	      if (!strncmp(e->string, "UV_", 3) && buf_safe(&out, strlen(e->string)+1))
-		buf_printf (&out, "%s\n", e->string);
+	      if (e->string)
+		{
+		  if (!strncmp(e->string, "UV_", 3) && buf_safe(&out, strlen(e->string)+1))
+		    buf_printf (&out, "%s\n", e->string);
+		}
 	    }
 	}
 
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 47dbefb..0e97487 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -233,7 +233,7 @@ struct tls_options
   bool disable_occ;
 #endif
 #ifdef ENABLE_PUSH_PEER_INFO
-  bool push_peer_info;
+  int push_peer_info_detail;
 #endif
   int transition_window;
   int handshake_window;
-- 
1.8.1.5


