From: Stefan Monnier <monnier@...1268...>
Date: Wed, 17 Feb 2010 00:17:54 -0500
Message-ID: <jwvr5okih0h.fsf-monnier+gmane.network.openvpn.devel@...1269...>
References: <4B7AE8D6.3020304@...1114...>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: news <news@...1062...>
Subject: [Openvpn-devel] [PATCH] FQDN for routes should expand to all IPs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--=-=-=
Content-Type: text/plain

[ I've sent this in the past already, but just trying to make sure it
  doesn't get lost somewhere. ]

When specifiying an FQDN for the network part of a route, OpenVPN should
setup a route for each IP associated with that FQDN.  Currently, it just
chooses one of the IPs at random instead, which leads to inconsistent
and unpredictable behavior since subsequent connections to that FQDN will
sometimes go through the VPN and sometimes not.

The patch below works for me, and I'd welcome any help in bringing it to
a state where it can be included in the mainline code.  It was made
against the openvpn-testing/master code.


        Stefan



--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=openvpn-fqdn.patch

diff --git a/route.c b/route.c
index 24d4bd8..396a20b 100644
--- a/route.c
+++ b/route.c
@@ -217,16 +217,19 @@ is_special_addr (const char *addr_str)
     return false;
 }
 
-static bool
+struct route *
 init_route (struct route *r,
+	    struct route *last_route,
 	    const struct route_option *ro,
 	    const struct route_special_addr *spec)
 {
   const in_addr_t default_netmask = ~0;
   bool status;
-
-  r->option = ro;
-  r->defined = false;
+  int nb = -1;
+  in_addr_t nets[MAX_IPS_PER_HOSTNAME];
+  in_addr_t netmask, gateway;
+  bool metric_defined;
+  int metric;
 
   /* network */
 
@@ -234,17 +237,19 @@ init_route (struct route *r,
     {
       goto fail;
     }
-  
-  if (!get_special_addr (spec, ro->network, &r->network, &status))
+
+  if (get_special_addr (spec, ro->network, &nets[0], &status))
+    nb = 1;
+  else
     {
-      r->network = getaddr (
-			    GETADDR_RESOLVE
-			    | GETADDR_HOST_ORDER
-			    | GETADDR_WARN_ON_SIGNAL,
-			    ro->network,
-			    0,
-			    &status,
-			    NULL);
+      nb = getaddr_all (GETADDR_RESOLVE
+			| GETADDR_HOST_ORDER
+			| GETADDR_WARN_ON_SIGNAL,
+			nets, MAX_IPS_PER_HOSTNAME,
+			ro->network,
+			0,
+			NULL);
+      status = (nb >= 0);
     }
 
   if (!status)
@@ -254,33 +259,33 @@ init_route (struct route *r,
 
   if (is_route_parm_defined (ro->netmask))
     {
-      r->netmask = getaddr (
-			    GETADDR_HOST_ORDER
-			    | GETADDR_WARN_ON_SIGNAL,
-			    ro->netmask,
-			    0,
-			    &status,
-			    NULL);
+      netmask = getaddr (
+			 GETADDR_HOST_ORDER
+			 | GETADDR_WARN_ON_SIGNAL,
+			 ro->netmask,
+			 0,
+			 &status,
+			 NULL);
       if (!status)
 	goto fail;
     }
   else
-    r->netmask = default_netmask;
+    netmask = default_netmask;
 
   /* gateway */
-
+      
   if (is_route_parm_defined (ro->gateway))
     {
-      if (!get_special_addr (spec, ro->gateway, &r->gateway, &status))
+      if (!get_special_addr (spec, ro->gateway, &gateway, &status))
 	{
-	  r->gateway = getaddr (
-				GETADDR_RESOLVE
-				| GETADDR_HOST_ORDER
-				| GETADDR_WARN_ON_SIGNAL,
-				ro->gateway,
-				0,
-				&status,
-				NULL);
+	  gateway = getaddr (
+			     GETADDR_RESOLVE
+			     | GETADDR_HOST_ORDER
+			     | GETADDR_WARN_ON_SIGNAL,
+			     ro->gateway,
+			     0,
+			     &status,
+			     NULL);
 	}
       if (!status)
 	goto fail;
@@ -288,7 +293,7 @@ init_route (struct route *r,
   else
     {
       if (spec->remote_endpoint_defined)
-	r->gateway = spec->remote_endpoint;
+	gateway = spec->remote_endpoint;
       else
 	{
 	  msg (M_WARN, PACKAGE_NAME " ROUTE: " PACKAGE_NAME " needs a gateway parameter for a --route option and no default was specified by either --route-gateway or --ifconfig options");
@@ -298,35 +303,54 @@ init_route (struct route *r,
 
   /* metric */
 
-  r->metric_defined = false;
-  r->metric = 0;
+  metric_defined = false;
+  metric = 0;
   if (is_route_parm_defined (ro->metric))
     {
-      r->metric = atoi (ro->metric);
-      if (r->metric < 0)
+      metric = atoi (ro->metric);
+      if (metric < 0)
 	{
 	  msg (M_WARN, PACKAGE_NAME " ROUTE: route metric for network %s (%s) must be >= 0",
 	       ro->network,
 	       ro->metric);
 	  goto fail;
 	}
-      r->metric_defined = true;
+      metric_defined = true;
     }
   else if (spec->default_metric_defined)
     {
-      r->metric = spec->default_metric;
-      r->metric_defined = true;
+      metric = spec->default_metric;
+      metric_defined = true;
     }
 
-  r->defined = true;
+  /* Now fill the corresponding route entries.  */
 
-  return true;
+  if (netmask != default_netmask && nb > 1)
+    /* If we add individual hosts, then every IP of that host is added,
+       but if we add a whole subnet, then only consider the first IP,
+       presuming that all the IPs are in the same subnet.  */
+    nb = 1;
+
+  /* Add a route for each one of the IPs found.  */
+  while (nb > 0 && r < last_route)
+    {
+      nb--;
+      r->option = ro;
+      r->network = nets[nb];
+      r->netmask = netmask;
+      r->gateway = gateway;
+      r->metric_defined = metric_defined;
+      r->metric = metric;
+      r->defined = true;
+      r++;
+    }
+
+  return r;
 
  fail:
   msg (M_WARN, PACKAGE_NAME " ROUTE: failed to parse/resolve route for host/network: %s",
        ro->network);
-  r->defined = false;
-  return false;
+  return NULL;
 }
 
 void
@@ -438,22 +462,29 @@ init_route_list (struct route_list *rl,
   else
     rl->spec.remote_endpoint_defined = false;
 
-  if (!(opt->n >= 0 && opt->n <= rl->capacity))
-    msg (M_FATAL, PACKAGE_NAME " ROUTE: (init) number of route options (%d) is greater than route list capacity (%d)", opt->n, rl->capacity);
-
   /* parse the routes from opt to rl */
   {
-    int i, j = 0;
+    int i;
+    struct route *cur_route = rl->routes;
+    struct route *last_route = &rl->routes[rl->capacity];
     for (i = 0; i < opt->n; ++i)
       {
-	if (!init_route (&rl->routes[j],
-			 &opt->routes[i],
-			 &rl->spec))
-	  ret = false;
+	if (cur_route >= last_route)
+	  msg (M_FATAL, PACKAGE_NAME " ROUTE: (init) number of route options (%d) is greater than route list capacity (%d)", opt->n, rl->capacity);
 	else
-	  ++j;
+	  {
+	    struct route *next_route
+	      = init_route (cur_route,
+			    last_route,
+			    &opt->routes[i],
+			    &rl->spec);
+	    if (!next_route)
+	      ret = false;
+	    else
+	      cur_route = next_route;
+	  }
       }
-    rl->n = j;
+    rl->n = cur_route - rl->routes;
   }
 
   gc_free (&gc);
diff --git a/socket.c b/socket.c
index fecc398..3f2fc28 100644
--- a/socket.c
+++ b/socket.c
@@ -78,22 +78,25 @@ h_errno_msg(int h_errno_err)
 }
 
 /*
- * Translate IP addr or hostname to in_addr_t.
+ * Translate IP addr or hostname to a list of in_addr_t.
  * If resolve error, try again for
  * resolve_retry_seconds seconds.
+ * ret&size is the table in which we'll put the results.
+ * The return value is the number of IPs found.
  */
-in_addr_t
-getaddr (unsigned int flags,
-	 const char *hostname,
-	 int resolve_retry_seconds,
-	 bool *succeeded,
-	 volatile int *signal_received)
+int
+getaddr_all (unsigned int flags,
+	     in_addr_t *ret, int size,
+	     const char *hostname,
+	     int resolve_retry_seconds,
+	     volatile int *signal_received)
 {
   struct in_addr ia;
   int status;
   int sigrec = 0;
   int msglevel = (flags & GETADDR_FATAL) ? M_FATAL : D_RESOLVE_ERRORS;
   struct gc_arena gc = gc_new ();
+  int nb = -1;
 
   if (flags & GETADDR_RANDOMIZE)
     hostname = hostname_randomize(hostname, &gc);
@@ -101,14 +104,11 @@ getaddr (unsigned int flags,
   if (flags & GETADDR_MSG_VIRT_OUT)
     msglevel |= M_MSG_VIRT_OUT;
 
-  CLEAR (ia);
-  if (succeeded)
-    *succeeded = false;
-
   if ((flags & (GETADDR_FATAL_ON_SIGNAL|GETADDR_WARN_ON_SIGNAL))
       && !signal_received)
     signal_received = &sigrec;
 
+  CLEAR (ia);
   status = openvpn_inet_aton (hostname, &ia); /* parse ascii IP address */
 
   if (status != OIA_IP) /* parse as IP address failed? */
@@ -119,8 +119,6 @@ getaddr (unsigned int flags,
       const char *fmt;
       int level = 0;
 
-      CLEAR (ia);
-
       fmt = "RESOLVE: Cannot resolve host address: %s: %s";
       if ((flags & GETADDR_MENTION_RESOLVE_RETRY)
 	  && !resolve_retry_seconds)
@@ -199,37 +197,21 @@ getaddr (unsigned int flags,
 	    goto done;
 	}
 
-      ia.s_addr = *(in_addr_t *) (h->h_addr_list[0]);
-
-      if (ia.s_addr)
+      nb = 0;
+      while (nb < size && h->h_addr_list[nb])
 	{
-	  if (h->h_addr_list[1]) /* more than one address returned */
-	    {
-	      int n = 0;
-
-	      /* count address list */
-	      while (h->h_addr_list[n])
-		++n;
-	      ASSERT (n >= 2);
-
-	      msg (D_RESOLVE_ERRORS, "RESOLVE: NOTE: %s resolves to %d addresses, choosing one by random",
-		   hostname,
-		   n);
-
-	      /* choose address randomly, for basic load-balancing capability */
-	      ia.s_addr = *(in_addr_t *) (h->h_addr_list[get_random () % n]);
-	    }
+	  ret[nb] = *(in_addr_t *) (h->h_addr_list[nb]);
+	  nb++;
 	}
-
-      /* hostname resolve succeeded */
-      if (succeeded)
-	*succeeded = true;
     }
   else
     {
       /* IP address parse succeeded */
-      if (succeeded)
-	*succeeded = true;
+      if (size > 0)
+	{
+	  ret[0] = ia.s_addr;
+	  nb = 1;
+	}
     }
 
  done:
@@ -244,7 +226,44 @@ getaddr (unsigned int flags,
     }
 
   gc_free (&gc);
-  return (flags & GETADDR_HOST_ORDER) ? ntohl (ia.s_addr) : ia.s_addr;
+  if (flags & GETADDR_HOST_ORDER)
+    {
+      int i = 0;
+      for (; i < nb; i++)
+	ret[i] = ntohl (ret[i]);
+    }
+  return nb;
+}
+
+/*
+ * Translate IP addr or hostname to in_addr_t.
+ * If resolve error, try again for
+ * resolve_retry_seconds seconds.
+ */
+in_addr_t
+getaddr (unsigned int flags,
+	 const char *hostname,
+	 int resolve_retry_seconds,
+	 bool *succeeded,
+	 volatile int *signal_received)
+{
+  in_addr_t ips[MAX_IPS_PER_HOSTNAME];
+  int nb = getaddr_all (flags, ips, MAX_IPS_PER_HOSTNAME,
+			hostname, resolve_retry_seconds, signal_received);
+  if (succeeded)
+    *succeeded = nb >= 0;
+
+  if (nb > 1)
+    {
+      msg (D_RESOLVE_ERRORS, "RESOLVE: NOTE: %s resolves to %d addresses, choosing one at random",
+	   hostname,
+	   nb);
+      return ips[get_random () % nb];
+    }
+  else if (nb >= 1)
+    return ips[0];
+  else
+    return 0;
 }
 
 /*
diff --git a/socket.h b/socket.h
index 6877e66..8f84537 100644
--- a/socket.h
+++ b/socket.h
@@ -450,6 +450,13 @@ bool unix_socket_get_peer_uid_gid (const socket_descriptor_t sd, int *uid, int *
 #define GETADDR_UPDATE_MANAGEMENT_STATE (1<<8)
 #define GETADDR_RANDOMIZE             (1<<9)
 
+#define MAX_IPS_PER_HOSTNAME 100
+
+int getaddr_all (unsigned int flags,
+		 in_addr_t *ret, int size,
+		 const char *hostname,
+		 int resolve_retry_seconds,
+		 volatile int *signal_received);
 in_addr_t getaddr (unsigned int flags,
 		   const char *hostname,
 		   int resolve_retry_seconds,

--=-=-=--


