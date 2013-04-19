From: Gert Doering <gert@...1296...>
Date: Fri, 19 Apr 2013 19:41:07 +0200
Message-Id: <1366393268-27392-5-git-send-email-gert@...1296...>
In-Reply-To: <1366393268-27392-1-git-send-email-gert@...1296...>
References: <1366393268-27392-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH 4/5] Always push basic set of peer info
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
Cc: James Yonan <james@...515...>

From: James Yonan <james@...515...>

On the client, allow certain peer info fields to be pushed even if
push-peer-info isn't specified in the config.

This is needed to allow the compression handshake to work correctly
(i.e. where the client indicates its support for LZO and/or Snappy).

Fields that have privacy implications such as Mac Address and UV_*
environment variables will not be pushed to the server as before unless
push-peer-info is specified by client config.

OpenVPN SVN r8225 (2.1.21c)

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/ssl.c | 82 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 42 insertions(+), 40 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index cf36191..4843065 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1775,64 +1775,66 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
   bool ret = false;
 
 #ifdef ENABLE_PUSH_PEER_INFO
-  if (session->opt->push_peer_info) /* write peer info */
-    {
-      struct env_set *es = session->opt->es;
-      struct env_item *e;
-      struct buffer out = alloc_buf_gc (512*3, &gc);
+  {
+    struct env_set *es = session->opt->es;
+    struct env_item *e;
+    struct buffer out = alloc_buf_gc (512*3, &gc);
 
-      /* push version */
-      buf_printf (&out, "IV_VER=%s\n", PACKAGE_VERSION);
+    /* push version */
+    buf_printf (&out, "IV_VER=%s\n", PACKAGE_VERSION);
 
-      /* push platform */
+    /* push platform */
 #if defined(TARGET_LINUX)
-      buf_printf (&out, "IV_PLAT=linux\n");
+    buf_printf (&out, "IV_PLAT=linux\n");
 #elif defined(TARGET_SOLARIS)
-      buf_printf (&out, "IV_PLAT=solaris\n");
+    buf_printf (&out, "IV_PLAT=solaris\n");
 #elif defined(TARGET_OPENBSD)
-      buf_printf (&out, "IV_PLAT=openbsd\n");
+    buf_printf (&out, "IV_PLAT=openbsd\n");
 #elif defined(TARGET_DARWIN)
-      buf_printf (&out, "IV_PLAT=mac\n");
+    buf_printf (&out, "IV_PLAT=mac\n");
 #elif defined(TARGET_NETBSD)
-      buf_printf (&out, "IV_PLAT=netbsd\n");
+    buf_printf (&out, "IV_PLAT=netbsd\n");
 #elif defined(TARGET_FREEBSD)
-      buf_printf (&out, "IV_PLAT=freebsd\n");
+    buf_printf (&out, "IV_PLAT=freebsd\n");
 #elif defined(WIN32)
-      buf_printf (&out, "IV_PLAT=win\n");
+    buf_printf (&out, "IV_PLAT=win\n");
 #endif
 
-      /* push mac addr */
-      {
-	struct route_gateway_info rgi;
-	get_default_gateway (&rgi);
-	if (rgi.flags & RGI_HWADDR_DEFINED)
-	  buf_printf (&out, "IV_HWADDR=%s\n", format_hex_ex (rgi.hwaddr, 6, 0, 1, ":", &gc));
-      }
-
-      /* push compression status */
+    /* push compression status */
 #ifdef USE_COMP
-      comp_generate_peer_info_string(&session->opt->comp_options, &out);
+    comp_generate_peer_info_string(&session->opt->comp_options, &out);
 #endif
 
-      /* push env vars that begin with UV_ */
-      for (e=es->list; e != NULL; e=e->next)
+    if (session->opt->push_peer_info)
+      {
+	/* push mac addr */
 	{
-	  if (e->string)
-	    {
-	      if (!strncmp(e->string, "UV_", 3) && buf_safe(&out, strlen(e->string)+1))
-		buf_printf (&out, "%s\n", e->string);
-	    }
+	  struct route_gateway_info rgi;
+	  get_default_gateway (&rgi);
+	  if (rgi.flags & RGI_HWADDR_DEFINED)
+	    buf_printf (&out, "IV_HWADDR=%s\n", format_hex_ex (rgi.hwaddr, 6, 0, 1, ":", &gc));
 	}
 
-      if (!write_string(buf, BSTR(&out), -1))
-	goto error;
-    }
-  else
+	/* push env vars that begin with UV_ */
+	for (e=es->list; e != NULL; e=e->next)
+	  {
+	    if (e->string)
+	      {
+		if (!strncmp(e->string, "UV_", 3) && buf_safe(&out, strlen(e->string)+1))
+		  buf_printf (&out, "%s\n", e->string);
+	      }
+	  }
+      }
+
+    if (!write_string(buf, BSTR(&out), -1))
+      goto error;
+  }
+#else
+  {
+    if (!write_empty_string (buf)) /* no peer info */
+      goto error;
+  }
 #endif
-    {
-      if (!write_empty_string (buf)) /* no peer info */
-	goto error;
-    }
   ret = true;
 
  error:
-- 
1.8.1.5


