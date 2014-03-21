From: Arne Schwabe <arne@...1227...>
Date: Fri, 21 Mar 2014 14:18:38 +0100
Message-Id: <1395407925-25518-6-git-send-email-arne@...1227...>
In-Reply-To: <1395407925-25518-1-git-send-email-arne@...1227...>
References: <1395407925-25518-1-git-send-email-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] =?utf-8?q?=5BPATCH_05/12=5D_Introduce_an_option_t?=
	=?utf-8?q?o_resolve_dns_names_in_advance_for_=E2=80=94remote=2C_?=
	=?utf-8?q?=E2=80=94local_and_http-proxy?=
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Also introduce x_gc_addspeical function that allows to add objects with a custom free function to the gc.

Some additional addrinfo cleanup

Conflicts:
	src/openvpn/socket.c
---
 src/openvpn/buffer.c  |  38 +++++
 src/openvpn/buffer.h  |  28 +++-
 src/openvpn/init.c    |  33 +++--
 src/openvpn/manage.c  |  18 ++-
 src/openvpn/openvpn.h |   3 +
 src/openvpn/options.c |  12 ++
 src/openvpn/options.h |   4 +-
 src/openvpn/route.c   |   2 +-
 src/openvpn/socket.c  | 395 +++++++++++++++++++++++++++++++++++---------------
 src/openvpn/socket.h  |  22 ++-
 10 files changed, 413 insertions(+), 142 deletions(-)

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index fb3b52d..3661141 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -372,6 +372,44 @@ x_gc_free (struct gc_arena *a)
 }
 
 /*
+ * Functions to handle special objects in gc_entries
+ */
+
+void
+x_gc_freespecial (struct gc_arena *a)
+{
+  struct gc_entry_special *e;
+  e = a->list_special;
+  a->list_special = NULL;
+
+  while (e != NULL)
+    {
+      struct gc_entry_special *next = e->next;
+      e->free_fnc (e->addr);
+      free(e);
+      e = next;
+    }
+}
+
+void gc_addspecial (void *addr, void (free_function)(void*), struct gc_arena *a)
+{
+  ASSERT(a);
+  struct gc_entry_special *e;
+#ifdef DMALLOC
+  e = (struct gc_entry_special *) openvpn_dmalloc (file, line, sizeof (struct gc_entry_special));
+#else
+  e = (struct gc_entry_special *) malloc (sizeof (struct gc_entry_special));
+#endif
+  check_malloc_return (e);
+  e->free_fnc = free_function;
+  e->addr = addr;
+
+  e->next = a->list_special;
+  a->list_special = e;
+}
+
+
+/*
  * Transfer src arena to dest, resetting src to an empty arena.
  */
 void
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 93efb09..0010c77 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -91,6 +91,18 @@ struct gc_entry
                                  *   linked list. */
 };
 
+/**
+ * Gargabe collection entry for a specially allocated structure that needs
+ * a custom free function to be freed like struct addrinfo
+ *
+ */
+struct gc_entry_special
+{
+  struct gc_entry_special *next;
+  void (*free_fnc)(void*);
+  void *addr;
+};
+
 
 /**
  * Garbage collection arena used to keep track of dynamically allocated
@@ -106,6 +118,7 @@ struct gc_arena
 {
   struct gc_entry *list;        /**< First element of the linked list of
                                  *   \c gc_entry structures. */
+  struct gc_entry_special *list_special;
 };
 
 
@@ -153,7 +166,6 @@ char *string_alloc_debug (const char *str, struct gc_arena *gc, const char *file
 struct buffer string_alloc_buf_debug (const char *str, struct gc_arena *gc, const char *file, int line);
 
 #else
-
 struct buffer alloc_buf (size_t size);
 struct buffer alloc_buf_gc (size_t size, struct gc_arena *gc); /* allocate buffer with garbage collection */
 struct buffer clone_buf (const struct buffer* buf);
@@ -163,6 +175,9 @@ struct buffer string_alloc_buf (const char *str, struct gc_arena *gc);
 
 #endif
 
+void gc_addspecial (void *addr, void (*free_function)(void*), struct gc_arena *a);
+
+
 #ifdef BUF_INIT_TRACKING
 #define buf_init(buf, offset) buf_init_debug (buf, offset, __FILE__, __LINE__)
 bool buf_init_debug (struct buffer *buf, int offset, const char *file, int line);
@@ -172,6 +187,11 @@ bool buf_init_debug (struct buffer *buf, int offset, const char *file, int line)
 
 
 /* inline functions */
+inline static void
+gc_freeaddrinfo_callback (void *addr)
+{
+  freeaddrinfo((struct addrinfo*) addr);
+}
 
 static inline bool
 buf_defined (const struct buffer *buf)
@@ -778,6 +798,7 @@ void character_class_debug (void);
 void gc_transfer (struct gc_arena *dest, struct gc_arena *src);
 
 void x_gc_free (struct gc_arena *a);
+void x_gc_freespecial (struct gc_arena *a);
 
 static inline bool
 gc_defined (struct gc_arena *a)
@@ -789,6 +810,7 @@ static inline void
 gc_init (struct gc_arena *a)
 {
   a->list = NULL;
+  a->list_special = NULL;
 }
 
 static inline void
@@ -801,7 +823,7 @@ static inline struct gc_arena
 gc_new (void)
 {
   struct gc_arena ret;
-  ret.list = NULL;
+  gc_init (&ret);
   return ret;
 }
 
@@ -810,6 +832,8 @@ gc_free (struct gc_arena *a)
 {
   if (a->list)
     x_gc_free (a);
+  if (a->list_special)
+    x_gc_freespecial(a);
 }
 
 static inline void
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 21e3052..c39646d 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1,4 +1,4 @@
-/*
+    /*
  *  OpenVPN -- An application to securely tunnel IP networks
  *             over a single TCP/UDP port, with support for SSL/TLS-based
  *             session authentication and key exchange,
@@ -131,7 +131,7 @@ management_callback_proxy_cmd (void *arg, const char **p)
           msg (M_WARN, "HTTP proxy support is not available");
 #else
           struct http_proxy_options *ho;
-          if (ce->proto != PROTO_TCP && ce->proto != PROTO_TCP_CLIENT )            {
+         if (ce->proto != PROTO_TCP && ce->proto != PROTO_TCP_CLIENT )            {
               msg (M_WARN, "HTTP proxy support only works for TCP based connections");
               return false;
             }
@@ -306,11 +306,10 @@ init_connection_list (struct context *c)
 /*
  * Clear the remote address list
  */
-static void clear_remote_addrlist (struct link_socket_addr *lsa)
+static void clear_remote_addrlist (struct link_socket_addr *lsa, bool free)
 {
-    if (lsa->remote_list) {
-        freeaddrinfo(lsa->remote_list);
-    }
+    if (lsa->remote_list && free)
+      freeaddrinfo(lsa->remote_list);
     lsa->remote_list = NULL;
     lsa->current_remote = NULL;
 }
@@ -348,9 +347,12 @@ next_connection_entry (struct context *c)
              * this is broken probably ever since connection lists and multiple
              * remote existed
              */
-
             if (!c->options.persist_remote_ip)
-                clear_remote_addrlist (&c->c1.link_socket_addr);
+	      {
+		/* close_instance should have cleared the addrinfo objects */
+		ASSERT (c->c1.link_socket_addr.current_remote == NULL);
+		ASSERT (c->c1.link_socket_addr.remote_list == NULL);
+	      }
             else
                 c->c1.link_socket_addr.current_remote =
                 c->c1.link_socket_addr.remote_list;
@@ -2688,6 +2690,7 @@ do_init_socket_1 (struct context *c, const int mode)
 			   c->options.ce.local_port,
 			   c->options.ce.remote,
 			   c->options.ce.remote_port,
+			   c->c1.dns_cache,
 			   c->options.ce.proto,
 			   c->options.ce.af,
 			   c->options.ce.bind_ipv6_only,
@@ -2908,7 +2911,7 @@ do_close_link_socket (struct context *c)
            || c->options.no_advance))
          )))
     {
-      clear_remote_addrlist(&c->c1.link_socket_addr);
+      clear_remote_addrlist(&c->c1.link_socket_addr, !c->options.resolve_in_advance);
     }
 
     /* Clear the remote actual address when persist_remote_ip is not in use */
@@ -2916,8 +2919,9 @@ do_close_link_socket (struct context *c)
       CLEAR (c->c1.link_socket_addr.actual);
 
   if (!(c->sig->signal_received == SIGUSR1 && c->options.persist_local_ip)) {
-    if (c->c1.link_socket_addr.bind_local)
-        freeaddrinfo(c->c1.link_socket_addr.bind_local);
+    if (c->c1.link_socket_addr.bind_local && !c->options.resolve_in_advance)
+	freeaddrinfo(c->c1.link_socket_addr.bind_local);
+
     c->c1.link_socket_addr.bind_local=NULL;
   }
 }
@@ -3359,6 +3363,13 @@ init_instance (struct context *c, const struct env_set *env, const unsigned int
 	goto sig;
     }
 
+  if (c->options.resolve_in_advance)
+    {
+      do_preresolve (c);
+      if (IS_SIG (c))
+	goto sig;
+    }
+
   /* map in current connection entry */
   next_connection_entry (c);
 
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 68ee37f..0cc185b 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1568,9 +1568,9 @@ man_listen (struct management *man)
       else
 #endif
 	{
-	  man->connection.sd_top = create_socket_tcp (AF_INET);
+	  man->connection.sd_top = create_socket_tcp (man->settings.local->ai_family);
 	  socket_bind (man->connection.sd_top, man->settings.local,
-                       AF_INET, "MANAGEMENT", true);
+                       man->settings.local->ai_family, "MANAGEMENT", false);
 	}
 
       /*
@@ -2151,8 +2151,14 @@ man_settings_init (struct man_settings *ms,
 	    }
 	  else
 	    {
-              int status = openvpn_getaddrinfo(GETADDR_RESOLVE|GETADDR_WARN_ON_SIGNAL|GETADDR_FATAL,
-                                               addr, port, 0, NULL, AF_INET, &ms->local);
+	      int status;
+	      int resolve_flags = GETADDR_RESOLVE|GETADDR_WARN_ON_SIGNAL|GETADDR_FATAL;
+
+	      if (! (flags & MF_CONNECT_AS_CLIENT))
+		  resolve_flags |= GETADDR_PASSIVE;
+
+              status = openvpn_getaddrinfo (resolve_flags, addr, port, 0,
+					    NULL, AF_UNSPEC, &ms->local);
               ASSERT(status==0);
 	    }
 	}
@@ -2179,6 +2185,8 @@ man_settings_init (struct man_settings *ms,
 static void
 man_settings_close (struct man_settings *ms)
 {
+  if (ms->local)
+    freeaddrinfo(ms->local);
   free (ms->write_peer_info_file);
   CLEAR (*ms);
 }
@@ -2616,7 +2624,7 @@ management_post_tunnel_open (struct management *man, const in_addr_t tun_local_i
       int ret;
 
       ia.s_addr = htonl(tun_local_ip);
-      ret = openvpn_getaddrinfo(0, inet_ntoa(ia), NULL, 0, NULL,
+      ret = openvpn_getaddrinfo(GETADDR_PASSIVE, inet_ntoa(ia), NULL, 0, NULL,
                                 AF_INET, &man->settings.local);
       ASSERT (ret==0);
       man_connection_init (man);
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 606a4f5..7ad6c55 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -166,6 +166,9 @@ struct context_1
   /* tunnel session keys */
   struct key_schedule ks;
 
+  /* preresolved and cached host names */
+  struct cached_dns_entry *dns_cache;
+
   /* persist crypto sequence number to/from file */
   struct packet_id_persist pid_persist;
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e7259f7..cb2cf95 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -796,6 +796,7 @@ init_options (struct options *o, const bool init_gc)
   o->ce.mssfix = MSSFIX_DEFAULT;
   o->route_delay_window = 30;
   o->resolve_retry_seconds = RESOLV_RETRY_INFINITE;
+  o->resolve_in_advance = false;
   o->proto_force = -1;
 #ifdef ENABLE_OCC
   o->occ = true;
@@ -1369,6 +1370,7 @@ show_connection_entry (const struct connection_entry *o)
   SHOW_BOOL (remote_float);
   SHOW_BOOL (bind_defined);
   SHOW_BOOL (bind_local);
+  SHOW_BOOL (bind_ipv6_only);
   SHOW_INT (connect_retry_seconds);
   SHOW_INT (connect_timeout);
 
@@ -1494,6 +1496,7 @@ show_settings (const struct options *o)
 #endif
 
   SHOW_INT (resolve_retry_seconds);
+  SHOW_BOOL (resolve_in_advance);
 
   SHOW_STR (username);
   SHOW_STR (groupname);
@@ -4540,6 +4543,15 @@ add_option (struct options *options,
       else
 	options->resolve_retry_seconds = positive_atoi (p[1]);
     }
+  else if (streq (p[0], "preresolve") || streq (p[0], "ip-remote-hint"))
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->resolve_in_advance = true;
+      /* Note the ip-remote-hint and the argument p[1] are for
+	 backward compatibility */
+      if (p[1])
+	options->ip_remote_hint=p[1];
+    }
   else if (streq (p[0], "connect-retry") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 175918e..ec1d091 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -90,7 +90,7 @@ struct connection_entry
   sa_family_t af;
   const char* local_port;
   bool local_port_defined;
-  const char* remote_port;
+  const char *remote_port;
   const char *local;
   const char *remote;
   bool remote_float;
@@ -278,6 +278,8 @@ struct options
 #endif
 
   int resolve_retry_seconds;    /* If hostname resolve fails, retry for n seconds */
+  bool resolve_in_advance;
+  const char *ip_remote_hint;
 
   struct tuntap_options tuntap_options;
 
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 392e248..1dd14fb 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -638,6 +638,7 @@ init_route_list (struct route_list *rl,
 	else
 	  {
             struct addrinfo* curele;
+            gc_addspecial(netlist, &gc_freeaddrinfo_callback, &gc);
             for (curele	= netlist; curele; curele = curele->ai_next)
 	      {
                 struct route_ipv4 *new;
@@ -647,7 +648,6 @@ init_route_list (struct route_list *rl,
                 new->next = rl->routes;
                 rl->routes = new;
 	      }
-            freeaddrinfo(netlist);
 	  }
       }
   }
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 91c6af0..bf793f4 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -39,6 +39,7 @@
 #include "manage.h"
 #include "misc.h"
 #include "manage.h"
+#include "openvpn.h"
 
 #include "memdbg.h"
 
@@ -117,6 +118,175 @@ getaddr (unsigned int flags,
   }
 }
 
+static inline bool
+streqnull (const char* a, const char* b)
+{
+  if (a == NULL && b == NULL)
+    return true;
+  else if (a == NULL || b == NULL)
+    return false;
+  else
+    return streq (a, b);
+}
+
+static int
+get_cached_dns_entry (struct cached_dns_entry* dns_cache,
+		      const char* hostname,
+		      const char* servname,
+		      int ai_family,
+		      int resolve_flags,
+		      struct addrinfo **ai)
+{
+  struct cached_dns_entry *ph;
+  int flags;
+
+  /* Only use flags that are relevant for the structure */
+  flags = resolve_flags & GETADDR_CACHE_MASK;
+
+  for (ph = dns_cache; ph ; ph = ph->next)
+    {
+      if (streqnull (ph->hostname, hostname) &&
+	  streqnull (ph->servname, servname) &&
+	  ph->ai_family == ai_family &&
+	  ph->flags == flags)
+	{
+	  *ai = ph->ai;
+	  return 0;
+	}
+    }
+  return -1;
+}
+
+
+static int
+do_preresolve_host (struct context *c,
+		    const char *hostname,
+		    const char *servname,
+		    const int af,
+		    const int flags)
+{
+  struct addrinfo *ai;
+  if (get_cached_dns_entry(c->c1.dns_cache,
+			   hostname,
+			     servname,
+			     af,
+			     flags,
+			   &ai))
+    {
+      int status;
+      status = openvpn_getaddrinfo (flags, hostname, servname,
+				    c->options.resolve_retry_seconds, NULL,
+				    af, &ai);
+      if (status == 0)
+	{
+	  struct cached_dns_entry *ph;
+
+	  ALLOC_OBJ_CLEAR_GC (ph, struct cached_dns_entry, &c->gc);
+	  ph->ai = ai;
+	  ph->hostname = hostname;
+	  ph->servname = servname;
+	  ph->flags = flags & GETADDR_CACHE_MASK;
+
+	  if (!c->c1.dns_cache)
+	    c->c1.dns_cache = ph;
+	  else
+	    {
+	      struct cached_dns_entry *prev = c->c1.dns_cache;
+	      while (prev->next)
+		prev = prev->next;
+	      prev->next = ph;
+	    }
+
+	  gc_addspecial (ai, &gc_freeaddrinfo_callback, &c->gc);
+
+	}
+      return status;
+    }
+  else
+    {
+      /* already in cached dns list, return success */
+      return 0;
+    }
+}
+
+void
+do_preresolve (struct context *c)
+{
+  int i;
+  struct connection_list *l = c->options.connection_list;
+  const unsigned int preresolve_flags = GETADDR_RESOLVE|
+    GETADDR_UPDATE_MANAGEMENT_STATE|
+    GETADDR_MENTION_RESOLVE_RETRY|
+    GETADDR_FATAL;
+
+
+  for (i = 0; i < l->len; ++i)
+    {
+      int status;
+      const char *remote;
+      int flags = preresolve_flags;
+
+      struct connection_entry* ce = c->options.connection_list->array[i];
+
+      if (proto_is_dgram(ce->proto))
+	  flags |= GETADDR_DATAGRAM;
+
+      if (c->options.sockflags & SF_HOST_RANDOMIZE)
+	  flags |= GETADDR_RANDOMIZE;
+
+      if (c->options.ip_remote_hint)
+	  remote = c->options.ip_remote_hint;
+      else
+	  remote = ce->remote;
+
+      /* HTTP remote hostname does not need to be resolved */
+      if (! ce->http_proxy_options)
+	{
+	  status = do_preresolve_host (c, remote, ce->remote_port, ce->af, flags);
+	  if (status != 0)
+	      goto err;
+	}
+
+      /* Preresolve proxy */
+      if (ce->http_proxy_options)
+	{
+	  status = do_preresolve_host (c,
+				       ce->http_proxy_options->server,
+				       ce->http_proxy_options->port,
+				       ce->af,
+				       preresolve_flags);
+
+	  if (status != 0)
+	      goto err;
+	}
+
+      if (ce->socks_proxy_server)
+	{
+	  status = do_preresolve_host (c,
+				       ce->socks_proxy_server,
+				       ce->socks_proxy_port,
+				       ce->af,
+				       flags);
+	  if (status != 0)
+	      goto err;
+	}
+
+      if (ce->bind_local)
+	{
+	  flags |= GETADDR_PASSIVE;
+	  flags &= ~GETADDR_RANDOMIZE;
+	  status = do_preresolve_host (c, ce->local, ce->local_port, ce->af, flags);
+	  if (status != 0)
+	      goto err;
+
+	}
+
+    }
+    return;
+
+ err:
+  throw_signal_soft (SIGHUP, "Preresolving failed");
+}
 
 /*
  * Translate IPv4/IPv6 addr or hostname into struct addrinfo
@@ -1155,7 +1325,15 @@ resolve_bind_local (struct link_socket *sock, const sa_family_t af)
 	flags |= GETADDR_DATAGRAM;
 
       /* will return AF_{INET|INET6}from local_host */
-      status = openvpn_getaddrinfo(flags, sock->local_host, sock->local_port, 0,
+      status = get_cached_dns_entry (sock->dns_cache,
+				     sock->local_host,
+				     sock->local_port,
+				     af,
+				     flags,
+				     &sock->info.lsa->bind_local);
+
+      if (status)
+	status = openvpn_getaddrinfo(flags, sock->local_host, sock->local_port, 0,
 				   NULL, af, &sock->info.lsa->bind_local);
 
       if(status !=0) {
@@ -1193,103 +1371,104 @@ resolve_remote (struct link_socket *sock,
 {
   struct gc_arena gc = gc_new ();
 
-  if (!sock->did_resolve_remote)
+  /* resolve remote address if undefined */
+  if (!sock->info.lsa->remote_list)
     {
-      /* resolve remote address if undefined */
-      if (!sock->info.lsa->remote_list)
+      if (sock->remote_host)
 	{
-	  if (sock->remote_host)
+	  unsigned int flags = sf2gaf(GETADDR_RESOLVE|GETADDR_UPDATE_MANAGEMENT_STATE, sock->sockflags);
+	  int retry = 0;
+	  int status = -1;
+	  struct addrinfo* ai;
+	  if (proto_is_dgram(sock->info.proto))
+	    flags |= GETADDR_DATAGRAM;
+
+	  if (sock->resolve_retry_seconds == RESOLV_RETRY_INFINITE)
 	    {
-	      unsigned int flags = sf2gaf(GETADDR_RESOLVE|GETADDR_UPDATE_MANAGEMENT_STATE, sock->sockflags);
-	      int retry = 0;
-	      int status = -1;
-              struct addrinfo* ai;
-              if (proto_is_dgram(sock->info.proto))
-                  flags |= GETADDR_DATAGRAM;
-
-	      if (sock->resolve_retry_seconds == RESOLV_RETRY_INFINITE)
+	      if (phase == 2)
+		flags |= (GETADDR_TRY_ONCE | GETADDR_FATAL);
+	      retry = 0;
+	    }
+	  else if (phase == 1)
+	    {
+	      if (sock->resolve_retry_seconds)
 		{
-		  if (phase == 2)
-		    flags |= (GETADDR_TRY_ONCE | GETADDR_FATAL);
 		  retry = 0;
 		}
-	      else if (phase == 1)
+	      else
 		{
-		  if (sock->resolve_retry_seconds)
-		    {
-		      retry = 0;
-		    }
-		  else
-		    {
-		      flags |= (GETADDR_FATAL | GETADDR_MENTION_RESOLVE_RETRY);
-		      retry = 0;
-		    }
+		  flags |= (GETADDR_FATAL | GETADDR_MENTION_RESOLVE_RETRY);
+		  retry = 0;
 		}
-	      else if (phase == 2)
+	    }
+	  else if (phase == 2)
+	    {
+	      if (sock->resolve_retry_seconds)
 		{
-		  if (sock->resolve_retry_seconds)
-		    {
-		      flags |= GETADDR_FATAL;
-		      retry = sock->resolve_retry_seconds;
-		    }
-		  else
-		    {
-		      ASSERT (0);
-		    }
+		  flags |= GETADDR_FATAL;
+		  retry = sock->resolve_retry_seconds;
 		}
 	      else
 		{
 		  ASSERT (0);
 		}
+	    }
+	  else
+	    {
+	      ASSERT (0);
+	    }
 
-	      status = openvpn_getaddrinfo (flags, sock->remote_host, sock->remote_port,
-					    retry, signal_received, sock->info.af, &ai);
-
-	      if(status == 0) {
-		sock->info.lsa->remote_list = ai;
-		sock->info.lsa->current_remote = ai;
-
-		dmsg (D_SOCKET_DEBUG, "RESOLVE_REMOTE flags=0x%04x phase=%d rrs=%d sig=%d status=%d",
-		      flags,
-		      phase,
-		      retry,
-		      signal_received ? *signal_received : -1,
-		      status);
-	      }
-	      if (signal_received)
-		{
-		  if (*signal_received)
-		    goto done;
-		}
+
+	  status = get_cached_dns_entry (sock->dns_cache,
+					 sock->remote_host,
+					 sock->remote_port,
+					 sock->info.af,
+					 flags, &ai);
+	  if (status)
+	    status = openvpn_getaddrinfo (flags, sock->remote_host, sock->remote_port,
+					  retry, signal_received, sock->info.af, &ai);
+
+	  if(status == 0) {
+	    sock->info.lsa->remote_list = ai;
+	    sock->info.lsa->current_remote = ai;
+
+	    dmsg (D_SOCKET_DEBUG, "RESOLVE_REMOTE flags=0x%04x phase=%d rrs=%d sig=%d status=%d",
+		  flags,
+		  phase,
+		  retry,
+		  signal_received ? *signal_received : -1,
+		  status);
+	  }
+	  if (signal_received)
+	    {
+	      if (*signal_received)
+		goto done;
+	    }
 	      if (status!=0)
 		{
 		  if (signal_received)
 		    *signal_received = SIGUSR1;
 		  goto done;
 		}
-	    }
 	}
+    }
   
-      /* should we re-use previous active remote address? */
-      if (link_socket_actual_defined (&sock->info.lsa->actual))
-	{
-	  msg (M_INFO, "TCP/UDP: Preserving recently used remote address: %s",
-	       print_link_socket_actual (&sock->info.lsa->actual, &gc));
-	  if (remote_dynamic)
-	    *remote_dynamic = NULL;
-	}
-      else
+  /* should we re-use previous active remote address? */
+  if (link_socket_actual_defined (&sock->info.lsa->actual))
+    {
+      msg (M_INFO, "TCP/UDP: Preserving recently used remote address: %s",
+	   print_link_socket_actual (&sock->info.lsa->actual, &gc));
+      if (remote_dynamic)
+	*remote_dynamic = NULL;
+    }
+  else
+    {
+      CLEAR (sock->info.lsa->actual);
+      if(sock->info.lsa->current_remote)
 	{
-	  CLEAR (sock->info.lsa->actual);
-	  if(sock->info.lsa->current_remote)
-	    {
-	      set_actual_address (&sock->info.lsa->actual,
-				  sock->info.lsa->current_remote);
-	    }
+	  set_actual_address (&sock->info.lsa->actual,
+			      sock->info.lsa->current_remote);
 	}
-
-      /* remember that we finished */
-      sock->did_resolve_remote = true;
     }
 
  done:
@@ -1341,6 +1520,7 @@ create_new_socket (struct link_socket* sock)
       if (sock->bind_local)
           bind_local(sock);
     }
+
 }
 
 
@@ -1351,6 +1531,7 @@ link_socket_init_phase1 (struct link_socket *sock,
 			 const char *local_port,
 			 const char *remote_host,
 			 const char *remote_port,
+			 struct cached_dns_entry *dns_cache,
 			 int proto,
 			 sa_family_t af,
 			 bool bind_ipv6_only,
@@ -1385,6 +1566,7 @@ link_socket_init_phase1 (struct link_socket *sock,
   sock->local_port = local_port;
   sock->remote_host = remote_host;
   sock->remote_port = remote_port;
+  sock->dns_cache = dns_cache;
 
 #ifdef ENABLE_HTTP_PROXY
   sock->http_proxy = http_proxy;
@@ -1564,33 +1746,33 @@ linksock_print_addr (struct link_socket *sock)
   const int msglevel = (sock->mode == LS_MODE_TCP_ACCEPT_FROM) ? D_INIT_MEDIUM : M_INFO;
 
   /* print local address */
-  if (sock->inetd)
+ if (sock->inetd)
     msg (msglevel, "%s link local: [inetd]", proto2ascii (sock->info.proto, sock->info.af, true));
-    else if (sock->bind_local)
-      {
-	/* Socket is always bound on the first matching address */
-	struct addrinfo *cur;
-	for (cur = sock->info.lsa->bind_local; cur; cur=cur->ai_next)
-	  {
-	    if(cur->ai_family == sock->info.lsa->actual.ai_family)
-		break;
-	  }
-	ASSERT (cur);
-	msg (msglevel, "%s link local (bound): %s",
+  else if (sock->bind_local)
+    {
+      /* Socket is always bound on the first matching address */
+      struct addrinfo *cur;
+      for (cur = sock->info.lsa->bind_local; cur; cur=cur->ai_next)
+	{
+	  if(cur->ai_family == sock->info.lsa->actual.ai_family)
+	    break;
+	}
+      ASSERT (cur);
+      msg (msglevel, "%s link local (bound): %s",
 	   proto2ascii (sock->info.proto, sock->info.af, true),
 	   print_sockaddr(cur->ai_addr,&gc));
-      }
-    else
-	msg (msglevel, "%s link local: (not bound)",
-	     proto2ascii (sock->info.proto, sock->info.af, true));
+    }
+  else
+    msg (msglevel, "%s link local: (not bound)",
+	 proto2ascii (sock->info.proto, sock->info.af, true));
 
   /* print active remote address */
   msg (msglevel, "%s link remote: %s",
-	 proto2ascii (sock->info.proto, sock->info.af, true),
-	 print_link_socket_actual_ex (&sock->info.lsa->actual,
-				      ":",
-				      PS_SHOW_PORT_IF_DEFINED,
-				      &gc));
+       proto2ascii (sock->info.proto, sock->info.af, true),
+       print_link_socket_actual_ex (&sock->info.lsa->actual,
+				    ":",
+				    PS_SHOW_PORT_IF_DEFINED,
+				    &gc));
   gc_free(&gc);
 }
 
@@ -1707,7 +1889,6 @@ phase2_socks_client (struct link_socket *sock, struct signal_info *sig_info)
 
     sock->remote_host = sock->proxy_dest_host;
     sock->remote_port = sock->proxy_dest_port;
-    sock->did_resolve_remote = false;
 
     addr_zero_host(&sock->info.lsa->actual.dest);
     if (sock->info.lsa->remote_list)
@@ -2579,30 +2760,6 @@ proto2ascii_all (struct gc_arena *gc)
   return BSTR (&out);
 }
 
-int
-addr_guess_family(sa_family_t af, const char *name)
-{
-  unsigned short ret;
-  if (af)
-    {
-      return af;	/* already stamped */
-    } 
-  else
-    {
-      struct addrinfo hints , *ai;
-      int err;
-      CLEAR(hints);
-      hints.ai_flags = AI_NUMERICHOST;
-      err = getaddrinfo(name, NULL, &hints, &ai);
-      if ( 0 == err )
-	{
-	  ret=ai->ai_family;
-	  freeaddrinfo(ai);
-	  return ret;
-	}
-    }
-  return AF_INET;	/* default */
-}
 const char *
 addr_family_name (int af) 
 {
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 191668f..8d4316b 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -77,6 +77,16 @@ struct openvpn_sockaddr
   } addr;
 };
 
+/* struct to hold preresolved host names */
+struct cached_dns_entry {
+    const char *hostname;
+    const char *servname;
+    int ai_family;
+    int flags;
+    struct addrinfo *ai;
+    struct cached_dns_entry *next;
+};
+
 /* actual address of remote, based on source address of received packets */
 struct link_socket_actual
 {
@@ -188,6 +198,7 @@ struct link_socket
   const char *remote_port;
   const char *local_host;
   const char *local_port;
+  struct cached_dns_entry *dns_cache;
   bool bind_local;
 
 # define INETD_NONE   0
@@ -208,8 +219,6 @@ struct link_socket
 
   int mtu;                      /* OS discovered MTU, or 0 if unknown */
 
-  bool did_resolve_remote;
-
 # define SF_USE_IP_PKTINFO (1<<0)
 # define SF_TCP_NODELAY (1<<1)
 # define SF_PORT_SHARE (1<<2)
@@ -298,6 +307,8 @@ int openvpn_connect (socket_descriptor_t sd,
 		     int connect_timeout,
 		     volatile int *signal_received);
 
+
+
 /*
  * Initialize link_socket object.
  */
@@ -308,6 +319,7 @@ link_socket_init_phase1 (struct link_socket *sock,
 			 const char *local_port,
 			 const char *remote_host,
 			 const char *remote_port,
+			 struct cached_dns_entry *dns_cache,
 			 int proto,
 			 sa_family_t af,
 			 bool bind_ipv6_only,
@@ -340,6 +352,8 @@ void link_socket_init_phase2 (struct link_socket *sock,
 			      const struct frame *frame,
 			      struct signal_info *sig_info);
 
+void do_preresolve(struct context *c);
+
 void socket_adjust_frame_parameters (struct frame *frame, int proto);
 
 void frame_adjust_path_mtu (struct frame *frame, int pmtu, int proto);
@@ -514,6 +528,8 @@ bool unix_socket_get_peer_uid_gid (const socket_descriptor_t sd, int *uid, int *
 #define GETADDR_PASSIVE               (1<<10)
 #define GETADDR_DATAGRAM              (1<<11)
 
+#define GETADDR_CACHE_MASK		GETADDR_DATAGRAM|GETADDR_PASSIVE
+
 in_addr_t getaddr (unsigned int flags,
 		   const char *hostname,
 		   int resolve_retry_seconds,
@@ -905,7 +921,7 @@ link_socket_set_outgoing_addr (const struct buffer *buf,
 	   &&
 	   /* address undef or address == remote or --float */
 	   (info->remote_float ||
-	       (!lsa->remote_list || addrlist_match_proto (&act->dest, lsa->remote_list, info->proto))
+	    (!lsa->remote_list || addrlist_match_proto (&act->dest, lsa->remote_list, info->proto))
 	    )
 	  )
 	{
-- 
1.8.5.2 (Apple Git-48)


