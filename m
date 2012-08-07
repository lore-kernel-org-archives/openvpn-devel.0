From: Arne Schwabe <arne@...1227...>
Date: Tue,  7 Aug 2012 10:33:16 +0200
Message-Id: <1344328396-32121-1-git-send-email-arne@...1227...>
In-Reply-To: <20120806202605.GI2535@...1296...>
References: <20120806202605.GI2535@...1296...>
Subject: [Openvpn-devel] [Version 3] Merge getaddr_multi and getaddr6 into
	one function
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

the getaddr6 and getaddr_mutli functions are duplicates of each other. Since we always require getaddrinfo to be present both function are merge into one openvpn_getaddrinfo.

This functions also returns a standard struct addrinfo* so our resolve interface is closer to the standard unix interface. The getaddr function is a wrapper which provides backward compatibility for IPv4 addresses. Ipv6 calls and calls to getaddr_multi are replaced with the new interface.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/route.c  |   50 ++---
 src/openvpn/socket.c |  596 ++++++++++++++++----------------------------------
 src/openvpn/socket.h |   17 +-
 3 files changed, 221 insertions(+), 442 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index d967d4f..a1064fe 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -268,12 +268,14 @@ is_special_addr (const char *addr_str)
 
 static bool
 init_route (struct route *r,
-	    struct resolve_list *network_list,
+	    struct addrinfo **network_list,
 	    const struct route_option *ro,
 	    const struct route_list *rl)
 {
   const in_addr_t default_netmask = IPV4_NETMASK_HOST;
   bool status;
+  int ret;
+  struct in_addr special;
 
   CLEAR (*r);
   r->option = ro;
@@ -284,19 +286,23 @@ init_route (struct route *r,
     {
       goto fail;
     }
-  
-  if (!get_special_addr (rl, ro->network, &r->network, &status))
-    {
-      r->network = getaddr_multi (
-				  GETADDR_RESOLVE
-				  | GETADDR_HOST_ORDER
-				  | GETADDR_WARN_ON_SIGNAL,
-				  ro->network,
-				  0,
-				  &status,
-				  NULL,
-				  network_list);
-    }
+
+	
+	/* get_special_addr replaces specialaddr with a special ip addr
+	   like gw. getaddrinfo is called to convert a a addrinfo struct */
+
+	if(get_special_addr (rl, ro->network, &special.s_addr, &status)) 
+	  {
+		special.s_addr = htonl(special.s_addr);
+		ret = openvpn_getaddrinfo(0, inet_ntoa(special), 0, NULL,
+								  AF_INET, network_list);
+	  }
+	else 
+		ret = openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL,
+								  ro->network, 0, NULL, AF_INET, network_list);
+
+	status = (ret == 0);
+
 
   if (!status)
     goto fail;
@@ -642,11 +648,8 @@ init_route_list (struct route_list *rl,
     bool warned = false;
     for (i = 0; i < opt->n; ++i)
       {
-	struct resolve_list netlist;
+	struct addrinfo* netlist;
 	struct route r;
-	int k;
-
-        CLEAR(netlist);		/* init_route() will not always init this */
 
 	if (!init_route (&r,
 			 &netlist,
@@ -655,16 +658,12 @@ init_route_list (struct route_list *rl,
 	  ret = false;
 	else
 	  {
-	    if (!netlist.len)
-	      {
-		netlist.data[0] = r.network;
-		netlist.len = 1;
-	      }
-	    for (k = 0; k < netlist.len; ++k)
+		struct addrinfo* curele;
+		for (curele	= netlist; curele; curele = curele->ai_next) 
 	      {
 		if (j < rl->capacity)
 		  {
-		    r.network = netlist.data[k];
+			r.network = ntohl(((struct sockaddr_in*)(curele)->ai_addr)->sin_addr.s_addr);
 		    rl->routes[j++] = r;
 		  }
 		else
@@ -676,6 +675,7 @@ init_route_list (struct route_list *rl,
 		      }
 		  }
 	      }
+   	  freeaddrinfo(netlist);
 	  }
       }
     rl->n = j;
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index a34e78c..d6a0ce6 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -93,390 +93,186 @@ h_errno_msg(int h_errno_err)
  */
 in_addr_t
 getaddr (unsigned int flags,
-	 const char *hostname,
-	 int resolve_retry_seconds,
-	 bool *succeeded,
-	 volatile int *signal_received)
-{
-  return getaddr_multi (flags, hostname, resolve_retry_seconds, succeeded, signal_received, NULL);
-}
-
-in_addr_t
-getaddr_multi (unsigned int flags,
-	 const char *hostname,
-	 int resolve_retry_seconds,
-	 bool *succeeded,
-	 volatile int *signal_received,
-	 struct resolve_list *reslist)
+		 const char *hostname,
+		 int resolve_retry_seconds,
+		 bool *succeeded,
+		 volatile int *signal_received)
 {
-  struct in_addr ia;
+  struct addrinfo *ai;
   int status;
-  int sigrec = 0;
-  int msglevel = (flags & GETADDR_FATAL) ? M_FATAL : D_RESOLVE_ERRORS;
-  struct gc_arena gc = gc_new ();
-
-  if (reslist)
-    reslist->len = 0;
-
-  if (flags & GETADDR_RANDOMIZE)
-    hostname = hostname_randomize(hostname, &gc);
-
-  if (flags & GETADDR_MSG_VIRT_OUT)
-    msglevel |= M_MSG_VIRT_OUT;
-
-  CLEAR (ia);
-  if (succeeded)
-    *succeeded = false;
-
-  if ((flags & (GETADDR_FATAL_ON_SIGNAL|GETADDR_WARN_ON_SIGNAL))
-      && !signal_received)
-    signal_received = &sigrec;
-
-  status = openvpn_inet_aton (hostname, &ia); /* parse ascii IP address */
-
-  if (status != OIA_IP) /* parse as IP address failed? */
-    {
-      const int fail_wait_interval = 5; /* seconds */
-      int resolve_retries = (flags & GETADDR_TRY_ONCE) ? 1 : (resolve_retry_seconds / fail_wait_interval);
-      struct hostent *h;
-      const char *fmt;
-      int level = 0;
-
-      CLEAR (ia);
-
-      fmt = "RESOLVE: Cannot resolve host address: %s: %s";
-      if ((flags & GETADDR_MENTION_RESOLVE_RETRY)
-	  && !resolve_retry_seconds)
-	fmt = "RESOLVE: Cannot resolve host address: %s: %s (I would have retried this name query if you had specified the --resolv-retry option.)";
-
-      if (!(flags & GETADDR_RESOLVE) || status == OIA_ERROR)
-	{
-	  msg (msglevel, "RESOLVE: Cannot parse IP address: %s", hostname);
-	  goto done;
-	}
-
-#ifdef ENABLE_MANAGEMENT
-      if (flags & GETADDR_UPDATE_MANAGEMENT_STATE)
-	{
-	  if (management)
-	    management_set_state (management,
-				  OPENVPN_STATE_RESOLVE,
-				  NULL,
-				  (in_addr_t)0,
-				  (in_addr_t)0);
-	}
-#endif
-
-      /*
-       * Resolve hostname
-       */
-      while (true)
-	{
-	  /* try hostname lookup */
-#if defined(HAVE_RES_INIT)
-	  res_init ();
-#endif
-	  h = gethostbyname (hostname);
-
-	  if (signal_received)
-	    {
-	      get_signal (signal_received);
-	      if (*signal_received) /* were we interrupted by a signal? */
-		{
-		  h = NULL;
-		  if (*signal_received == SIGUSR1) /* ignore SIGUSR1 */
-		    {
-		      msg (level, "RESOLVE: Ignored SIGUSR1 signal received during DNS resolution attempt");
-		      *signal_received = 0;
-		    }
-		  else
-		    goto done;
-		}
-	    }
-
-	  /* success? */
-	  if (h)
-	    break;
-
-	  /* resolve lookup failed, should we
-	     continue or fail? */
-
-	  level = msglevel;
-	  if (resolve_retries > 0)
-	    level = D_RESOLVE_ERRORS;
-
-	  msg (level,
-	       fmt,
-	       hostname,
-	       h_errno_msg (h_errno));
-
-	  if (--resolve_retries <= 0)
-	    goto done;
-
-	  openvpn_sleep (fail_wait_interval);
-	}
-
-      if (h->h_addrtype != AF_INET || h->h_length != 4)
-	{
-	    msg (msglevel, "RESOLVE: Sorry, but we only accept IPv4 DNS names: %s", hostname);
-	    goto done;
-	}
-
-      ia.s_addr = *(in_addr_t *) (h->h_addr_list[0]);
-
-      if (ia.s_addr)
-	{
-	  if (h->h_addr_list[1]) /* more than one address returned */
-	    {
-	      int n = 0;
-
-	      /* count address list */
-	      while (h->h_addr_list[n])
-		++n;
-	      ASSERT (n >= 2);
-
-	      msg (D_RESOLVE_ERRORS, "RESOLVE: NOTE: %s resolves to %d addresses",
-		   hostname,
-		   n);
-
-	      /* choose address randomly, for basic load-balancing capability */
-	      /*ia.s_addr = *(in_addr_t *) (h->h_addr_list[get_random () % n]);*/
-
-	      /* choose first address */
-	      ia.s_addr = *(in_addr_t *) (h->h_addr_list[0]);
-
-	      if (reslist)
-		{
-		  int i;
-		  for (i = 0; i < n && i < SIZE(reslist->data); ++i)
-		    {
-		      in_addr_t a = *(in_addr_t *) (h->h_addr_list[i]);
-		      if (flags & GETADDR_HOST_ORDER)
-			a = ntohl(a);
-		      reslist->data[i] = a;
-		    }
-		  reslist->len = i;
-		}
-	    }
-	}
-
-      /* hostname resolve succeeded */
-      if (succeeded)
-	*succeeded = true;
-    }
-  else
-    {
-      /* IP address parse succeeded */
-      if (succeeded)
-	*succeeded = true;
-    }
-
- done:
-  if (signal_received && *signal_received)
-    {
-      int level = 0;
-      if (flags & GETADDR_FATAL_ON_SIGNAL)
-	level = M_FATAL;
-      else if (flags & GETADDR_WARN_ON_SIGNAL)
-	level = M_WARN;
-      msg (level, "RESOLVE: signal received during DNS resolution attempt");
-    }
-
-  gc_free (&gc);
-  return (flags & GETADDR_HOST_ORDER) ? ntohl (ia.s_addr) : ia.s_addr;
+  status = openvpn_getaddrinfo(flags, hostname, resolve_retry_seconds, 
+							   signal_received, AF_INET, &ai);
+  if(status==0) {
+	struct in_addr ia;
+	if(succeeded)
+	  *succeeded=true;
+	ia = ((struct sockaddr_in*)ai->ai_addr)->sin_addr;
+	freeaddrinfo(ai);
+	return (flags & GETADDR_HOST_ORDER) ? ntohl (ia.s_addr) : ia.s_addr;
+  } else {
+	if(succeeded)
+	  *succeeded =false;
+	return 0;
+  }
 }
 
+
 /*
- * Translate IPv6 addr or hostname into struct addrinfo
- * If resolve error, try again for
- * resolve_retry_seconds seconds.
+ * Translate IPv4/IPv6 addr or hostname into struct addrinfo
+ * If resolve error, try again for resolve_retry_seconds seconds.
  */
-bool
-getaddr6 (unsigned int flags,
-	 const char *hostname,
-	 int resolve_retry_seconds,
-	 volatile int *signal_received,
-         int *gai_err,
-	 struct sockaddr_in6 *in6)
-{
-  bool success;
-  struct addrinfo hints, *ai;
+int
+openvpn_getaddrinfo (unsigned int flags,
+					 const char *hostname,
+					 int resolve_retry_seconds,
+					 volatile int *signal_received,
+					 int ai_family, 
+					 struct addrinfo **res)
+{
+  struct addrinfo hints;
   int status;
   int sigrec = 0;
   int msglevel = (flags & GETADDR_FATAL) ? M_FATAL : D_RESOLVE_ERRORS;
   struct gc_arena gc = gc_new ();
-
-  ASSERT(in6);
-
+	
+  ASSERT(res);
+	
   if (!hostname)
-    hostname = "::";
-
+	hostname = "::";
+	
   if (flags & GETADDR_RANDOMIZE)
-    hostname = hostname_randomize(hostname, &gc);
-
+	hostname = hostname_randomize(hostname, &gc);
+	
   if (flags & GETADDR_MSG_VIRT_OUT)
-    msglevel |= M_MSG_VIRT_OUT;
-
-  CLEAR (ai);
-  success = false;
-
+	msglevel |= M_MSG_VIRT_OUT;
+	
   if ((flags & (GETADDR_FATAL_ON_SIGNAL|GETADDR_WARN_ON_SIGNAL))
-      && !signal_received)
-    signal_received = &sigrec;
-
+	  && !signal_received)
+	signal_received = &sigrec;
+	
   /* try numeric ipv6 addr first */
   CLEAR(hints);
-  hints.ai_family = AF_INET6;
+  hints.ai_family = ai_family;
   hints.ai_flags = AI_NUMERICHOST;
-  if ((status = getaddrinfo(hostname, NULL, &hints, &ai))==0)
-    {
-      *in6 = *((struct sockaddr_in6 *)(ai->ai_addr));
-      freeaddrinfo(ai);
-      ai = NULL;
-    }
-  if (gai_err)
-    *gai_err = status;
-
-
-  if (status != 0) /* parse as IPv6 address failed? */
-    {
-      const int fail_wait_interval = 5; /* seconds */
-      int resolve_retries = (flags & GETADDR_TRY_ONCE) ? 1 : (resolve_retry_seconds / fail_wait_interval);
-      const char *fmt;
-      int level = 0;
-      int err;
-
-      ai = NULL;
-
-      fmt = "RESOLVE: Cannot resolve host address: %s: %s";
-      if ((flags & GETADDR_MENTION_RESOLVE_RETRY)
-	  && !resolve_retry_seconds)
-	fmt = "RESOLVE: Cannot resolve host address: %s: %s (I would have retried this name query if you had specified the --resolv-retry option.)";
-
-      if (!(flags & GETADDR_RESOLVE) || status == EAI_FAIL)
+	
+  status = getaddrinfo(hostname, NULL, &hints, res);
+	
+  if (status != 0) /* parse as numeric address failed? */
 	{
-	  msg (msglevel, "RESOLVE: Cannot parse IPv6 address: %s", hostname);
-	  goto done;
-	}
-
+	  const int fail_wait_interval = 5; /* seconds */
+	  int resolve_retries = (flags & GETADDR_TRY_ONCE) ? 1 : (resolve_retry_seconds / fail_wait_interval);
+	  const char *fmt;
+	  int level = 0;
+		
+		
+	  fmt = "RESOLVE: Cannot resolve host address: %s: %s";
+	  if ((flags & GETADDR_MENTION_RESOLVE_RETRY)
+		  && !resolve_retry_seconds)
+		fmt = "RESOLVE: Cannot resolve host address: %s: %s (I would have retried this name query if you had specified the --resolv-retry option.)";
+		
+	  if (!(flags & GETADDR_RESOLVE) || status == EAI_FAIL)
+		{
+		  msg (msglevel, "RESOLVE: Cannot parse IP address: %s", hostname);
+		  goto done;
+		}
+		
 #ifdef ENABLE_MANAGEMENT
-      if (flags & GETADDR_UPDATE_MANAGEMENT_STATE)
-	{
-	  if (management)
-	    management_set_state (management,
-				  OPENVPN_STATE_RESOLVE,
-				  NULL,
-				  (in_addr_t)0,
-				  (in_addr_t)0);
-	}
+	  if (flags & GETADDR_UPDATE_MANAGEMENT_STATE)
+		{
+		  if (management)
+			management_set_state (management,
+								  OPENVPN_STATE_RESOLVE,
+								  NULL,
+								  (in_addr_t)0,
+								  (in_addr_t)0);
+		}
 #endif
-
-      /*
-       * Resolve hostname
-       */
-      while (true)
-	{
-	  /* try hostname lookup */
-          hints.ai_flags = 0;
-          hints.ai_socktype = dnsflags_to_socktype(flags);
-	  dmsg (D_SOCKET_DEBUG, "GETADDR6 flags=0x%04x ai_family=%d ai_socktype=%d",
-		flags, hints.ai_family, hints.ai_socktype);
-          err = getaddrinfo(hostname, NULL, &hints, &ai);
-
-          if (gai_err)
-            *gai_err = err;
-
-	  if (signal_received)
-	    {
-	      get_signal (signal_received);
-	      if (*signal_received) /* were we interrupted by a signal? */
+		
+	  /*
+	   * Resolve hostname
+	   */
+	  while (true)
 		{
-                  if (0 == err) {
-                    ASSERT(ai);
-                    freeaddrinfo(ai);
-                    ai = NULL;
-                  }
-		  if (*signal_received == SIGUSR1) /* ignore SIGUSR1 */
-		    {
-		      msg (level, "RESOLVE: Ignored SIGUSR1 signal received during DNS resolution attempt");
-		      *signal_received = 0;
-		    }
-		  else
-		    goto done;
+		  /* try hostname lookup */
+#if defined(HAVE_RES_INIT)
+		  res_init ();
+#endif
+			
+		  hints.ai_flags = 0;
+		  hints.ai_socktype = dnsflags_to_socktype(flags);
+		  dmsg (D_SOCKET_DEBUG, "GETADDRINFO flags=0x%04x ai_family=%d ai_socktype=%d",
+				flags, hints.ai_family, hints.ai_socktype);
+		  status = getaddrinfo(hostname, NULL, &hints, res);
+			
+			
+		  if (signal_received)
+			{
+			  get_signal (signal_received);
+			  if (*signal_received) /* were we interrupted by a signal? */
+				{
+				  if (0 == status) {
+					ASSERT(res);
+					freeaddrinfo(*res);
+					res = NULL;
+				  }
+				  if (*signal_received == SIGUSR1) /* ignore SIGUSR1 */
+					{
+					  msg (level, "RESOLVE: Ignored SIGUSR1 signal received during DNS resolution attempt");
+					  *signal_received = 0;
+					}
+				  else
+					goto done;
+				}
+			}
+			
+		  /* success? */
+		  if (0 == status)
+			break;
+			
+		  /* resolve lookup failed, should we
+			 continue or fail? */
+			
+		  level = msglevel;
+		  if (resolve_retries > 0)
+			level = D_RESOLVE_ERRORS;
+			
+		  msg (level,
+			   fmt,
+			   hostname,
+			   gai_strerror(status));
+			
+		  if (--resolve_retries <= 0)
+			goto done;
+			
+		  openvpn_sleep (fail_wait_interval);
 		}
-	    }
+		
+	  ASSERT(res);
 
-	  /* success? */
-	  if (0 == err)
-	    break;
-
-	  /* resolve lookup failed, should we
-	     continue or fail? */
-
-	  level = msglevel;
-	  if (resolve_retries > 0)
-	    level = D_RESOLVE_ERRORS;
-
-	  msg (level,
-	       fmt,
-	       hostname,
-	       gai_strerror(err));
-
-	  if (--resolve_retries <= 0)
-	    goto done;
-
-	  openvpn_sleep (fail_wait_interval);
+	  /* hostname resolve succeeded */
+		
+	  /* Do not chose an IP Addresse by random or change the order *
+	   * of IP addresses, doing so will break RFC 3484 address selection *
+	   */
 	}
-
-      ASSERT(ai);
-
-      if (!ai->ai_next)
-        *in6 = *((struct sockaddr_in6*)(ai->ai_addr));
-      else 
-        /* more than one address returned */
-        {
-          struct addrinfo *ai_cursor;
-          int n = 0;
-          /* count address list */
-          for (ai_cursor = ai; ai_cursor; ai_cursor = ai_cursor->ai_next) n++;
-          ASSERT (n >= 2);
-
-          msg (D_RESOLVE_ERRORS, "RESOLVE: NOTE: %s resolves to %d ipv6 addresses, choosing one by random",
-               hostname,
-               n);
-
-          /* choose address randomly, for basic load-balancing capability */
-	  n--;
-          n %= get_random();
-          for (ai_cursor = ai; n; ai_cursor = ai_cursor->ai_next) n--;
-          *in6 = *((struct sockaddr_in6*)(ai_cursor->ai_addr));
-        }
-
-      freeaddrinfo(ai);
-      ai = NULL;
-
-      /* hostname resolve succeeded */
-      success = true;
-    }
   else
-    {
-      /* IP address parse succeeded */
-      success = true;
-    }
-
+	{
+	  /* IP address parse succeeded */
+	}
+	
  done:
   if (signal_received && *signal_received)
-    {
-      int level = 0;
-      if (flags & GETADDR_FATAL_ON_SIGNAL)
-	level = M_FATAL;
-      else if (flags & GETADDR_WARN_ON_SIGNAL)
-	level = M_WARN;
-      msg (level, "RESOLVE: signal received during DNS resolution attempt");
-    }
-
+	{
+	  int level = 0;
+	  if (flags & GETADDR_FATAL_ON_SIGNAL)
+		level = M_FATAL;
+	  else if (flags & GETADDR_WARN_ON_SIGNAL)
+		level = M_WARN;
+	  msg (level, "RESOLVE: signal received during DNS resolution attempt");
+	}
+	
   gc_free (&gc);
-  return success;
+  return status;
 }
 
 /*
@@ -652,18 +448,16 @@ update_remote (const char* host,
     case AF_INET6:
       if (host && addr)
         {
-          struct sockaddr_in6 sin6;
-          int success;
-          CLEAR(sin6);
-          success = getaddr6 (
-                                    sf2gaf(GETADDR_RESOLVE|GETADDR_UPDATE_MANAGEMENT_STATE, sockflags),
-                                    host,
-                                    1,
-                                    NULL,
-                                    NULL,
-                                    &sin6);
-          if ( success )
+          int status;
+          struct addrinfo* ai;
+
+		  status = openvpn_getaddrinfo(sf2gaf(GETADDR_RESOLVE|GETADDR_UPDATE_MANAGEMENT_STATE, sockflags), host, 1, NULL, AF_INET6, &ai);
+			
+          if ( status ==0 )
             {
+			  struct sockaddr_in6 sin6;			  	
+			  CLEAR(sin6);
+			  sin6 = *((struct sockaddr_in6*)ai->ai_addr);	
               if (!IN6_ARE_ADDR_EQUAL(&sin6.sin6_addr, &addr->addr.in6.sin6_addr))
               {
                 int port = addr->addr.in6.sin6_port;
@@ -671,6 +465,7 @@ update_remote (const char* host,
                 addr->addr.in6 = sin6; 
                 addr->addr.in6.sin6_port = port;
               }
+			  freeaddrinfo(ai);
             }
         }
       break;
@@ -1355,25 +1150,27 @@ resolve_bind_local (struct link_socket *sock)
 	  break;
 	case AF_INET6:
 	    {
-	      int success;
+	      int status;
 	      int err;
 	      CLEAR(sock->info.lsa->local.addr.in6);
 	      if (sock->local_host)
 		{
-		  success = getaddr6(GETADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL | GETADDR_FATAL,
-				     sock->local_host,
-				     0,
-				     NULL,
-				     &err,
-				     &sock->info.lsa->local.addr.in6);
+		  struct addrinfo *ai;
+		  
+		  status = openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL | GETADDR_FATAL,
+									   sock->local_host, 0, NULL, AF_INET6, &ai);
+		  if(status ==0) {
+			  sock->info.lsa->local.addr.in6 = *((struct sockaddr_in6*)(ai->ai_addr));
+			  freeaddrinfo(ai);
+		  }
 		}
 	      else
 		{
 		  sock->info.lsa->local.addr.in6.sin6_family = AF_INET6;
 		  sock->info.lsa->local.addr.in6.sin6_addr = in6addr_any;
-		  success = true;
+		  status = 0;
 		}
-	      if (!success)
+	      if (!status == 0)
 		{
 		  msg (M_FATAL, "getaddr6() failed for local \"%s\": %s",
 		       sock->local_host,
@@ -1430,7 +1227,7 @@ resolve_remote (struct link_socket *sock,
 	    {
 	      unsigned int flags = sf2gaf(GETADDR_RESOLVE|GETADDR_UPDATE_MANAGEMENT_STATE, sock->sockflags);
 	      int retry = 0;
-	      bool status = false;
+	      int status = -1;
 
 	      if (sock->connection_profiles_defined && sock->resolve_retry_seconds == RESOLV_RETRY_INFINITE)
 		{
@@ -1467,40 +1264,27 @@ resolve_remote (struct link_socket *sock,
 		  ASSERT (0);
 		}
 
-              switch(af)
-                {
-                  case AF_INET:
-                    sock->info.lsa->remote.addr.in4.sin_addr.s_addr = getaddr (
-                          flags,
-                          sock->remote_host,
-                          retry,
-                          &status,
-                          signal_received);
-                    break;
-                  case AF_INET6:
-                    status = getaddr6 (
-                        flags,
-                        sock->remote_host,
-                        retry,
-                        signal_received,
-                        NULL,
-                        &sock->info.lsa->remote.addr.in6);
-                    break;
-                }
-
-	      dmsg (D_SOCKET_DEBUG, "RESOLVE_REMOTE flags=0x%04x phase=%d rrs=%d sig=%d status=%d",
-		   flags,
-		   phase,
-		   retry,
-		   signal_received ? *signal_received : -1,
-		   status);
-
+		  struct addrinfo* ai;		
+		  /* Temporary fix, this need to be changed for dual stack */
+		  status = openvpn_getaddrinfo(flags, sock->remote_host, retry,
+											  signal_received, af, &ai);
+		  if(status == 0) {
+			  sock->info.lsa->remote.addr.in6 = *((struct sockaddr_in6*)(ai->ai_addr));
+			  freeaddrinfo(ai);
+		  
+			  dmsg (D_SOCKET_DEBUG, "RESOLVE_REMOTE flags=0x%04x phase=%d rrs=%d sig=%d status=%d",
+					flags,
+					phase,
+					retry,
+					signal_received ? *signal_received : -1,
+					status);
+		  }
 	      if (signal_received)
 		{
 		  if (*signal_received)
 		    goto done;
 		}
-	      if (!status)
+	      if (status!=0)
 		{
 		  if (signal_received)
 		    *signal_received = SIGUSR1;
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 43f72dc..2060bc8 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -467,11 +467,6 @@ bool unix_socket_get_peer_uid_gid (const socket_descriptor_t sd, int *uid, int *
  * DNS resolution
  */
 
-struct resolve_list {
-  int len;
-  in_addr_t data[16];
-};
-
 #define GETADDR_RESOLVE               (1<<0)
 #define GETADDR_FATAL                 (1<<1)
 #define GETADDR_HOST_ORDER            (1<<2)
@@ -494,12 +489,12 @@ in_addr_t getaddr (unsigned int flags,
 		   bool *succeeded,
 		   volatile int *signal_received);
 
-in_addr_t getaddr_multi (unsigned int flags,
-			 const char *hostname,
-			 int resolve_retry_seconds,
-			 bool *succeeded,
-			 volatile int *signal_received,
-			 struct resolve_list *reslist);
+int openvpn_getaddrinfo (unsigned int flags,
+					 const char *hostname,
+					 int resolve_retry_seconds,
+					 volatile int *signal_received,
+					 int ai_family, 
+					 struct addrinfo **res);
 
 /*
  * Transport protocol naming and other details.
-- 
1.7.9.6 (Apple Git-31.1)


