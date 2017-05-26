From: Farhan Ul Haq <farhan@...515...>
Date: Fri, 26 May 2017 13:21:34 -0400
Message-Id: <20170526172134.4124-1-farhan@...515...>
Subject: [Openvpn-devel] [PATCH] Added port-share-max option
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
Cc: Farhan Ul Haq <farhan@...515...>

---
 src/openvpn/init.c    |  3 ++-
 src/openvpn/options.c |  9 +++++++++
 src/openvpn/options.h |  1 +
 src/openvpn/ps.c      | 54 +++++++++++++++++++++++++++++++++++++++++----------
 src/openvpn/ps.h      |  3 ++-
 5 files changed, 58 insertions(+), 12 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 56bdbe3..5745556 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -576,7 +576,8 @@ init_port_share (struct context *c)
       port_share = port_share_open (c->options.port_share_host,
 				    c->options.port_share_port,
 				    MAX_RW_SIZE_LINK (&c->c2.frame),
-				    c->options.port_share_journal_dir);
+				    c->options.port_share_journal_dir,
+				    c->options.port_share_max_concurrent_connections);
       if (port_share == NULL)
 	msg (M_FATAL, "Fatal error: Port sharing failed");
     }
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 79f861b..0d81479 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -480,6 +480,7 @@ static const char usage_message[] =
   "--port-share host port [dir] : When run in TCP mode, proxy incoming HTTPS\n"
   "                  sessions to a web server at host:port.  dir specifies an\n"
   "                  optional directory to write origin IP:port data.\n"
+  "--port-share-max N : Max number of port-share concurrent connections\n"
 #endif
 #endif
   "\n"
@@ -878,6 +879,9 @@ init_options (struct options *o, const bool init_gc)
   }
 #endif /* WIN32 */
 #endif /* P2MP_SERVER */
+#if PORT_SHARE
+  o->port_share_max_concurrent_connections = 512;
+#endif
   o->allow_recursive_routing = false;
 }
 
@@ -5892,6 +5896,11 @@ add_option (struct options *options,
       options->port_share_port = port;
       options->port_share_journal_dir = p[3];
     }
+  else if (streq (p[0], "port-share-max") && p[1])
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->port_share_max_concurrent_connections = atoi (p[1]);
+    }
 #endif
   else if (streq (p[0], "client-to-client"))
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index e4235e9..c9b6dd8 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -454,6 +454,7 @@ struct options
   char *port_share_host;
   int port_share_port;
   const char *port_share_journal_dir;
+  int port_share_max_concurrent_connections;
 #endif
 #endif
 
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index cd96257..59ce7f3 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -78,6 +78,15 @@ struct proxy_connection {
   char *jfn;
 };
 
+/*
+ * Keep track of concurrent connections, and enforce
+ * a maximum limit.
+ */
+struct proxy_limits {
+  int half_connections;
+  int max_half_connections;
+};
+
 #if 0
 static const char *
 headc (const struct buffer *buf)
@@ -285,9 +294,10 @@ proxy_entry_mark_for_close (struct proxy_connection *pc, struct event_set *es)
  * Run through the proxy entry list and delete all entries marked
  * for close.
  */
-static void
+static int
 proxy_list_housekeeping (struct proxy_connection **list)
 {
+  int count = 0;
   if (list)
     {
       struct proxy_connection *prev = NULL;
@@ -305,10 +315,14 @@ proxy_list_housekeeping (struct proxy_connection **list)
 		*list = next;
 	    }
 	  else
-	    prev = pc;
+	    {
+	      ++count;
+	      prev = pc;
+	    }
 	  pc = next;
 	}
     }
+  return count;
 }
 
 /*
@@ -407,7 +421,8 @@ proxy_entry_new (struct proxy_connection **list,
 		 const int server_port,
 		 const socket_descriptor_t sd_client,
 		 struct buffer *initial_data,
-		 const char *journal_dir)
+		 const char *journal_dir,
+		 struct proxy_limits *limits)
 {
   struct openvpn_sockaddr osaddr;
   socket_descriptor_t sd_server;
@@ -415,6 +430,15 @@ proxy_entry_new (struct proxy_connection **list,
   struct proxy_connection *pc;
   struct proxy_connection *cp;
 
+  /* check concurrent connections limit */
+  if (limits->half_connections >= limits->max_half_connections)
+    {
+      msg (M_WARN, "PORT SHARE PROXY: concurrent connections limit (%d/%d) has been reached",
+	   limits->half_connections / 2,
+	   limits->max_half_connections / 2);
+      return false;
+    }
+
   /* connect to port share server */
   sock_addr_set (&osaddr, server_addr, server_port);
   if ((sd_server = socket (PF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0)
@@ -469,6 +493,7 @@ proxy_entry_new (struct proxy_connection **list,
   proxy_connection_io_requeue (pc, EVENT_READ, es);
   proxy_connection_io_requeue (cp, EVENT_READ|EVENT_WRITE, es);
   
+  ++limits->half_connections;
   return true;
 }
 
@@ -485,7 +510,8 @@ control_message_from_parent (const socket_descriptor_t sd_control,
 			     const in_addr_t server_addr,
 			     const int server_port,
 			     const int max_initial_buf,
-			     const char *journal_dir)
+			     const char *journal_dir,
+			     struct proxy_limits *limits)
 {
   /* this buffer needs to be large enough to handle the largest buffer
      that might be returned by the link_socket_read call in read_incoming_link. */
@@ -542,7 +568,8 @@ control_message_from_parent (const socket_descriptor_t sd_control,
 				   server_port,
 				   received_fd,
 				   &buf,
-				   journal_dir))
+				   journal_dir,
+				   limits))
 		{
 		  CLEAR (buf); /* we gave the buffer to proxy_entry_new */
 		}
@@ -720,7 +747,8 @@ port_share_proxy (const in_addr_t hostaddr,
 		  const int port,
 		  const socket_descriptor_t sd_control,
 		  const int max_initial_buf,
-		  const char *journal_dir)
+		  const char *journal_dir,
+		  struct proxy_limits *limits)
 {
   if (send_control (sd_control, RESPONSE_INIT_SUCCEEDED) >= 0)
     {
@@ -754,7 +782,7 @@ port_share_proxy (const in_addr_t hostaddr,
 		  const struct event_set_return *e = &esr[i];
 		  if (e->arg == sd_control_marker)
 		    {
-		      if (!control_message_from_parent (sd_control, &list, es, hostaddr, port, max_initial_buf, journal_dir))
+		      if (!control_message_from_parent (sd_control, &list, es, hostaddr, port, max_initial_buf, journal_dir, limits))
 			goto done;
 		    }
 		  else
@@ -771,7 +799,7 @@ port_share_proxy (const in_addr_t hostaddr,
 	    }
 	  if (current > last_housekeeping)
 	    {
-	      proxy_list_housekeeping (&list);
+	      limits->half_connections = proxy_list_housekeeping (&list);
 	      last_housekeeping = current;
 	    }
 	}
@@ -791,12 +819,18 @@ struct port_share *
 port_share_open (const char *host,
 		 const int port,
 		 const int max_initial_buf,
-		 const char *journal_dir)
+		 const char *journal_dir,
+		 const int max_concurrent_connections)
 {
   pid_t pid;
   socket_descriptor_t fd[2];
   in_addr_t hostaddr;
   struct port_share *ps;
+  struct proxy_limits limits;
+
+  /* concurrent connection limits */
+  limits.half_connections = 0;
+  limits.max_half_connections = max_concurrent_connections * 2;
 
   ALLOC_OBJ_CLEAR (ps, struct port_share);
   ps->foreground_fd = -1;
@@ -881,7 +915,7 @@ port_share_open (const char *host,
       prng_init (NULL, 0);
 
       /* execute the event loop */
-      port_share_proxy (hostaddr, port, fd[1], max_initial_buf, journal_dir);
+      port_share_proxy (hostaddr, port, fd[1], max_initial_buf, journal_dir, &limits);
 
       openvpn_close_socket (fd[1]);
 
diff --git a/src/openvpn/ps.h b/src/openvpn/ps.h
index 62af8b5..0c913bf 100644
--- a/src/openvpn/ps.h
+++ b/src/openvpn/ps.h
@@ -46,7 +46,8 @@ extern struct port_share *port_share;
 struct port_share *port_share_open (const char *host,
 				    const int port,
 				    const int max_initial_buf,
-				    const char *journal_dir);
+				    const char *journal_dir,
+				    const int max_concurrent_connections);
 
 void port_share_close (struct port_share *ps);
 void port_share_abort (struct port_share *ps);
-- 
2.11.0


