From: James Yonan <james@...515...>
Date: Thu,  8 May 2014 16:50:31 -0600
Message-Id: <1399589436-8730-2-git-send-email-james@...515...>
In-Reply-To: <1399589436-8730-1-git-send-email-james@...515...>
References: <1399589436-8730-1-git-send-email-james@...515...>
Subject: [Openvpn-devel] [PATCH 1/6] Fixed several instances of declarations
	after statements.
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

Signed-off-by: James Yonan <james@...515...>
---
 src/openvpn/init.c   | 10 ++++++----
 src/openvpn/socket.c |  2 +-
 src/openvpn/win32.c  |  6 +++---
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 52d370b..88883fb 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -183,10 +183,12 @@ ce_management_query_proxy (struct context *c)
   if (management)
     {
       gc = gc_new ();
-      struct buffer out = alloc_buf_gc (256, &gc);
-      buf_printf (&out, ">PROXY:%u,%s,%s", (l ? l->current : 0) + 1,
-                  (proto_is_udp (ce->proto) ? "UDP" : "TCP"), np (ce->remote));
-      management_notify_generic (management, BSTR (&out));
+      {
+	struct buffer out = alloc_buf_gc (256, &gc);
+	buf_printf (&out, ">PROXY:%u,%s,%s", (l ? l->current : 0) + 1,
+		    (proto_is_udp (ce->proto) ? "UDP" : "TCP"), np (ce->remote));
+	management_notify_generic (management, BSTR (&out));
+      }
       ce->flags |= CE_MAN_QUERY_PROXY;
       while (ce->flags & CE_MAN_QUERY_PROXY)
         {
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 23566f1..7ff14cc 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1227,6 +1227,7 @@ resolve_remote (struct link_socket *sock,
 	      unsigned int flags = sf2gaf(GETADDR_RESOLVE|GETADDR_UPDATE_MANAGEMENT_STATE, sock->sockflags);
 	      int retry = 0;
 	      int status = -1;
+	      struct addrinfo* ai;
 
 	      if (sock->connection_profiles_defined && sock->resolve_retry_seconds == RESOLV_RETRY_INFINITE)
 		{
@@ -1263,7 +1264,6 @@ resolve_remote (struct link_socket *sock,
 		  ASSERT (0);
 		}
 
-		  struct addrinfo* ai;
 		  /* Temporary fix, this need to be changed for dual stack */
 		  status = openvpn_getaddrinfo(flags, sock->remote_host, retry,
 											  signal_received, af, &ai);
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 13fd881..f35c96b 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -870,6 +870,9 @@ openvpn_execve (const struct argv *a, const struct env_set *es, const unsigned i
           WCHAR *cl = wide_cmd_line (a, &gc);
           WCHAR *cmd = wide_string (a->argv[0], &gc);
 
+          /* this allows console programs to run, and is ignored otherwise */
+          DWORD proc_flags = CREATE_NO_WINDOW;
+
           CLEAR (start_info);
           CLEAR (proc_info);
 
@@ -879,9 +882,6 @@ openvpn_execve (const struct argv *a, const struct env_set *es, const unsigned i
           start_info.dwFlags = STARTF_USESHOWWINDOW;
           start_info.wShowWindow = SW_HIDE;
 
-          /* this allows console programs to run, and is ignored otherwise */
-          DWORD proc_flags = CREATE_NO_WINDOW;
-
           if (CreateProcessW (cmd, cl, NULL, NULL, FALSE, proc_flags, env, NULL, &start_info, &proc_info))
             {
               DWORD exit_status = 0;
-- 
1.8.5.5


