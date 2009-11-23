From: Stefan Monnier <monnier@...1268...>
Date: Mon, 23 Nov 2009 00:43:30 -0500
Message-ID: <jwvhbslztlw.fsf-monnier+gmane.network.openvpn.devel@...1269...>
References: <4B06ABED.8090800@...41...>
Mime-Version: 1.0
Sender: news <news@...1062...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1_rc22 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net
Cc: openvpn-users@lists.sourceforge.net

> 2009.11.20 -- Version 2.1_rc22

Thanks.
For those like me who need to use routing commands with hostnames mapped
to more than a single IP, here's an updated patch.  IIUC the previous
patch should still apply, tho with some offsets.


        Stefan


Index: route.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- route.c	(r=E9vision 5180)
+++ route.c	(copie de travail)
@@ -217,34 +217,39 @@
     return false;
 }
=20
-static bool
+struct route *
 init_route (struct route *r,
+	    struct route *last_route,
 	    const struct route_option *ro,
 	    const struct route_special_addr *spec)
 {
   const in_addr_t default_netmask =3D ~0;
   bool status;
+  int nb =3D -1;
+  in_addr_t nets[MAX_IPS_PER_HOSTNAME];
+  in_addr_t netmask, gateway;
+  bool metric_defined;
+  int metric;
=20
-  r->option =3D ro;
-  r->defined =3D false;
-
   /* network */
=20
   if (!is_route_parm_defined (ro->network))
     {
       goto fail;
     }
- =20
-  if (!get_special_addr (spec, ro->network, &r->network, &status))
+
+  if (get_special_addr (spec, ro->network, &nets[0], &status))
+    nb =3D 1;
+  else
     {
-      r->network =3D getaddr (
-			    GETADDR_RESOLVE
-			    | GETADDR_HOST_ORDER
-			    | GETADDR_WARN_ON_SIGNAL,
-			    ro->network,
-			    0,
-			    &status,
-			    NULL);
+      nb =3D getaddr_all (GETADDR_RESOLVE
+			| GETADDR_HOST_ORDER
+			| GETADDR_WARN_ON_SIGNAL,
+			nets, MAX_IPS_PER_HOSTNAME,
+			ro->network,
+			0,
+			NULL);
+      status =3D (nb >=3D 0);
     }
=20
   if (!status)
@@ -254,33 +259,33 @@
=20
   if (is_route_parm_defined (ro->netmask))
     {
-      r->netmask =3D getaddr (
-			    GETADDR_HOST_ORDER
-			    | GETADDR_WARN_ON_SIGNAL,
-			    ro->netmask,
-			    0,
-			    &status,
-			    NULL);
+      netmask =3D getaddr (
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
-    r->netmask =3D default_netmask;
+    netmask =3D default_netmask;
=20
   /* gateway */
-
+     =20
   if (is_route_parm_defined (ro->gateway))
     {
-      if (!get_special_addr (spec, ro->gateway, &r->gateway, &status))
+      if (!get_special_addr (spec, ro->gateway, &gateway, &status))
 	{
-	  r->gateway =3D getaddr (
-				GETADDR_RESOLVE
-				| GETADDR_HOST_ORDER
-				| GETADDR_WARN_ON_SIGNAL,
-				ro->gateway,
-				0,
-				&status,
-				NULL);
+	  gateway =3D getaddr (
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
@@ -288,7 +293,7 @@
   else
     {
       if (spec->remote_endpoint_defined)
-	r->gateway =3D spec->remote_endpoint;
+	gateway =3D spec->remote_endpoint;
       else
 	{
 	  msg (M_WARN, PACKAGE_NAME " ROUTE: " PACKAGE_NAME " needs a gateway par=
ameter for a --route option and no default was specified by either --route-=
gateway or --ifconfig options");
@@ -298,35 +303,54 @@
=20
   /* metric */
=20
-  r->metric_defined =3D false;
-  r->metric =3D 0;
+  metric_defined =3D false;
+  metric =3D 0;
   if (is_route_parm_defined (ro->metric))
     {
-      r->metric =3D atoi (ro->metric);
-      if (r->metric < 0)
+      metric =3D atoi (ro->metric);
+      if (metric < 0)
 	{
 	  msg (M_WARN, PACKAGE_NAME " ROUTE: route metric for network %s (%s) mus=
t be >=3D 0",
 	       ro->network,
 	       ro->metric);
 	  goto fail;
 	}
-      r->metric_defined =3D true;
+      metric_defined =3D true;
     }
   else if (spec->default_metric_defined)
     {
-      r->metric =3D spec->default_metric;
-      r->metric_defined =3D true;
+      metric =3D spec->default_metric;
+      metric_defined =3D true;
     }
=20
-  r->defined =3D true;
+  /* Now fill the corresponding route entries.  */
=20
-  return true;
+  if (netmask !=3D default_netmask && nb > 1)
+    /* If we add individual hosts, then every IP of that host is added,
+       but if we add a whole subnet, then only consider the first IP,
+       presuming that all the IPs are in the same subnet.  */
+    nb =3D 1;
=20
+  /* Add a route for each one of the IPs found.  */
+  while (nb > 0 && r < last_route)
+    {
+      nb--;
+      r->option =3D ro;
+      r->network =3D nets[nb];
+      r->netmask =3D netmask;
+      r->gateway =3D gateway;
+      r->metric_defined =3D metric_defined;
+      r->metric =3D metric;
+      r->defined =3D true;
+      r++;
+    }
+
+  return r;
+
  fail:
   msg (M_WARN, PACKAGE_NAME " ROUTE: failed to parse/resolve route for hos=
t/network: %s",
        ro->network);
-  r->defined =3D false;
-  return false;
+  return NULL;
 }
=20
 void
@@ -438,22 +462,29 @@
   else
     rl->spec.remote_endpoint_defined =3D false;
=20
-  if (!(opt->n >=3D 0 && opt->n <=3D rl->capacity))
-    msg (M_FATAL, PACKAGE_NAME " ROUTE: (init) number of route options (%d=
) is greater than route list capacity (%d)", opt->n, rl->capacity);
-
   /* parse the routes from opt to rl */
   {
-    int i, j =3D 0;
+    int i;
+    struct route *cur_route =3D rl->routes;
+    struct route *last_route =3D &rl->routes[rl->capacity];
     for (i =3D 0; i < opt->n; ++i)
       {
-	if (!init_route (&rl->routes[j],
-			 &opt->routes[i],
-			 &rl->spec))
-	  ret =3D false;
+	if (cur_route >=3D last_route)
+	  msg (M_FATAL, PACKAGE_NAME " ROUTE: (init) number of route options (%d)=
 is greater than route list capacity (%d)", opt->n, rl->capacity);
 	else
-	  ++j;
+	  {
+	    struct route *next_route
+	      =3D init_route (cur_route,
+			    last_route,
+			    &opt->routes[i],
+			    &rl->spec);
+	    if (!next_route)
+	      ret =3D false;
+	    else
+	      cur_route =3D next_route;
+	  }
       }
-    rl->n =3D j;
+    rl->n =3D cur_route - rl->routes;
   }
=20
   gc_free (&gc);
Index: socket.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- socket.c	(r=E9vision 5180)
+++ socket.c	(copie de travail)
@@ -78,22 +78,25 @@
 }
=20
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
   int sigrec =3D 0;
   int msglevel =3D (flags & GETADDR_FATAL) ? M_FATAL : D_RESOLVE_ERRORS;
   struct gc_arena gc =3D gc_new ();
+  int nb =3D -1;
=20
   if (flags & GETADDR_RANDOMIZE)
     hostname =3D hostname_randomize(hostname, &gc);
@@ -101,14 +104,11 @@
   if (flags & GETADDR_MSG_VIRT_OUT)
     msglevel |=3D M_MSG_VIRT_OUT;
=20
-  CLEAR (ia);
-  if (succeeded)
-    *succeeded =3D false;
-
   if ((flags & (GETADDR_FATAL_ON_SIGNAL|GETADDR_WARN_ON_SIGNAL))
       && !signal_received)
     signal_received =3D &sigrec;
=20
+  CLEAR (ia);
   status =3D openvpn_inet_aton (hostname, &ia); /* parse ascii IP address =
*/
=20
   if (status !=3D OIA_IP) /* parse as IP address failed? */
@@ -119,8 +119,6 @@
       const char *fmt;
       int level =3D 0;
=20
-      CLEAR (ia);
-
       fmt =3D "RESOLVE: Cannot resolve host address: %s: %s";
       if ((flags & GETADDR_MENTION_RESOLVE_RETRY)
 	  && !resolve_retry_seconds)
@@ -199,37 +197,21 @@
 	    goto done;
 	}
=20
-      ia.s_addr =3D *(in_addr_t *) (h->h_addr_list[0]);
-
-      if (ia.s_addr)
+      nb =3D 0;
+      while (nb < size && h->h_addr_list[nb])
 	{
-	  if (h->h_addr_list[1]) /* more than one address returned */
-	    {
-	      int n =3D 0;
-
-	      /* count address list */
-	      while (h->h_addr_list[n])
-		++n;
-	      ASSERT (n >=3D 2);
-
-	      msg (D_RESOLVE_ERRORS, "RESOLVE: NOTE: %s resolves to %d addresses,=
 choosing one by random",
-		   hostname,
-		   n);
-
-	      /* choose address randomly, for basic load-balancing capability */
-	      ia.s_addr =3D *(in_addr_t *) (h->h_addr_list[get_random () % n]);
-	    }
+	  ret[nb] =3D *(in_addr_t *) (h->h_addr_list[nb]);
+	  nb++;
 	}
-
-      /* hostname resolve succeeded */
-      if (succeeded)
-	*succeeded =3D true;
     }
   else
     {
       /* IP address parse succeeded */
-      if (succeeded)
-	*succeeded =3D true;
+      if (size > 0)
+	{
+	  ret[0] =3D ia.s_addr;
+	  nb =3D 1;
+	}
     }
=20
  done:
@@ -244,10 +226,47 @@
     }
=20
   gc_free (&gc);
-  return (flags & GETADDR_HOST_ORDER) ? ntohl (ia.s_addr) : ia.s_addr;
+  if (flags & GETADDR_HOST_ORDER)
+    {
+      int i =3D 0;
+      for (; i < nb; i++)
+	ret[i] =3D ntohl (ret[i]);
+    }
+  return nb;
 }
=20
 /*
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
+  int nb =3D getaddr_all (flags, ips, MAX_IPS_PER_HOSTNAME,
+			hostname, resolve_retry_seconds, signal_received);
+  if (succeeded)
+    *succeeded =3D nb >=3D 0;
+
+  if (nb > 1)
+    {
+      msg (D_RESOLVE_ERRORS, "RESOLVE: NOTE: %s resolves to %d addresses, =
choosing one at random",
+	   hostname,
+	   nb);
+      return ips[get_random () % nb];
+    }
+  else if (nb >=3D 1)
+    return ips[0];
+  else
+    return 0;
+}
+
+/*
  * We do our own inet_aton because the glibc function
  * isn't very good about error checking.
  */
Index: socket.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- socket.h	(r=E9vision 5180)
+++ socket.h	(copie de travail)
@@ -450,6 +450,13 @@
 #define GETADDR_UPDATE_MANAGEMENT_STATE (1<<8)
 #define GETADDR_RANDOMIZE             (1<<9)
=20
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


