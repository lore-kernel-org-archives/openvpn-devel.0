Date: Thu, 4 Feb 2010 16:54:46 +0100
From: Dominique Rousseau <d.rousseau@...1300...>
Message-ID: <20100204155446.GY32433@...1300...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
Subject: [Openvpn-devel] multipath iroute
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

I wanted to make redundant VPNs by using multiple instances from same
client to same server but current (2.1.1) implementation of OpenVPN
override previous iroute definition when new client connects with same
ip or same route.

Attached is a proposed patch to allow for multiple paths for the same
route.

The functional target of the patch is that I modified the multi_route
struct to have a property called instances instead of instance, which
hosts an array of multi_instance.

It's a bit rough, and I don't doubt it needs a bi refactoring, since
it's the first time I browse through openvpn's source code, but it seems
to be functional and hasn't caused segfault since I try it.

-- 
Dominique Rousseau 
Neuronnexion, Prestataire Internet & Intranet
50, rue Riolan 80000 Amiens
tel: 03 22 71 61 90 - fax: 03 22 71 61 99 - http://www.neuronnexion.coop

--CE+1k2dSO48ffgeK
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="multipath-multi-h.patch"

--- openvpn-2.1.1/multi.h	2009-10-01 20:02:18.000000000 +0200
+++ openvpn-2.1.1-mod/multi.h	2010-01-22 00:02:42.000000000 +0100
@@ -137,7 +137,7 @@
 struct multi_route
 {
   struct mroute_addr addr;
-  struct multi_instance *instance;
+  struct multi_instance **instances;
 
 # define MULTI_ROUTE_CACHE   (1<<0)
 # define MULTI_ROUTE_AGEABLE (1<<1)
@@ -145,6 +145,7 @@
 
   unsigned int cache_generation;
   time_t last_reference;
+  unsigned int nb_use;
 };
 
 /*
@@ -279,6 +280,9 @@
     }
 }
 
+/* 
+moved to multi.c
+
 static inline void
 multi_route_del (struct multi_route *route)
 {
@@ -287,21 +291,26 @@
   multi_instance_dec_refcount (mi);
   free (route);
 }
+*/
 
 static inline bool
 multi_route_defined (const struct multi_context *m,
 		     const struct multi_route *r)
 {
-  if (r->instance->halt)
-    return false;
-  else if ((r->flags & MULTI_ROUTE_CACHE)
+  bool ret;
+  int i;
+  ret = false;
+  for (i = 0; i < r->nb_use; i++) {
+    if (!r->instances[i]->halt)
+      ret = ret | true;
+  }
+  if ((r->flags & MULTI_ROUTE_CACHE)
 	   && r->cache_generation != m->route_helper->cache_generation)
-    return false;
+    ret = false;
   else if ((r->flags & MULTI_ROUTE_AGEABLE)
 	   && r->last_reference + m->route_helper->ageable_ttl_secs < now)
-    return false;
-  else
-    return true;
+    ret = false;
+  return ret;
 }
 
 /*

--CE+1k2dSO48ffgeK
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="multipath-multi-c.patch"

--- openvpn-2.1.1/multi.c	2009-10-25 01:17:29.000000000 +0200
+++ openvpn-2.1.1-mod/multi.c	2010-01-24 16:53:40.000000000 +0100
@@ -130,6 +130,73 @@
     }
 }
 
+
+static void
+multi_route_del (struct multi_route *route, struct multi_instance *mi)
+{
+  int i, j;
+  struct multi_instance **new_instances;
+  struct gc_arena gcd = gc_new ();
+//  struct multi_instance *mi = route->instance;
+  
+  if (mi != NULL) {
+    // clear route for this instance
+    dmsg (D_MULTI_LOW, "MULTI: delete route %s for instance %s",
+	       mroute_addr_print (&route->addr, &gcd),
+	       multi_instance_string (mi, false, &gcd));
+    ALLOC_ARRAY (new_instances, struct multi_instance *, (route->nb_use - 1));
+    route_quota_dec (mi);
+    j = 0;
+    for (i = 0; i < route->nb_use; i++) {
+      if (route->instances[i] != mi) {
+        new_instances[j] = route->instances[i];
+        j += 1;
+      }
+    }
+    multi_instance_dec_refcount (mi);
+  } else {
+    // clear route for all instances
+    dmsg (D_MULTI_LOW, "MULTI: delete route %s for all instances",
+	       mroute_addr_print (&route->addr, &gcd));
+    for (i = 0; i < route->nb_use; i++) {
+      route_quota_dec (route->instances[i]);
+      multi_instance_dec_refcount (route->instances[i]);
+    }
+    new_instances = NULL;
+    route->nb_use = 0;
+  }
+  free(route->instances);
+  route->instances = new_instances;
+  route->nb_use -= 1;
+  if (route->nb_use <= 0) {
+    free (route);
+  }
+  gc_free (&gcd);
+}
+
+static void
+multi_route_add (struct multi_route *route, struct multi_instance *mi)
+{
+  int i, j;
+  struct multi_instance **new_instances;
+  
+  ALLOC_ARRAY (new_instances, struct multi_instance *, (route->nb_use + 1));
+  if (route->instances != NULL) {
+    for (i = 0; i < route->nb_use; i++) {
+      new_instances[i] = route->instances[i];
+    }
+  }
+  multi_instance_inc_refcount (mi);
+  route_quota_inc (mi);
+  new_instances[route->nb_use] = mi;
+  route->nb_use += 1;
+
+  if (route->instances != NULL) {
+    free(route->instances);
+  }
+  route->instances = new_instances;
+}
+
 static void
 multi_reap_range (const struct multi_context *m,
 		  int start_bucket,
@@ -155,7 +222,7 @@
 	  dmsg (D_MULTI_DEBUG, "MULTI: REAP DEL %s",
 	       mroute_addr_print (&r->addr, &gc));
 	  learn_address_script (m, NULL, "delete", &r->addr);
-	  multi_route_del (r);
+	  multi_route_del (r, NULL);
 	  hash_iterator_delete_element (&hi);
 	}
     }
@@ -753,18 +820,22 @@
 
 	      if (multi_route_defined (m, route))
 		{
-		  const struct multi_instance *mi = route->instance;
+		  const struct multi_instance *mi;
 		  const struct mroute_addr *ma = &route->addr;
 		  char flags[2] = {0, 0};
+		  int i;
 
-		  if (route->flags & MULTI_ROUTE_CACHE)
-		    flags[0] = 'C';
-		  status_printf (so, "%s%s,%s,%s,%s",
+		  for (i = 0; i < route->nb_use; i++) {
+		    mi = route->instances[i];
+		    if (route->flags & MULTI_ROUTE_CACHE)
+		      flags[0] = 'C';
+		    status_printf (so, "%s%s,%s,%s,%s",
 				 mroute_addr_print (ma, &gc),
 				 flags,
 				 tls_common_name (mi->context.c2.tls_multi, false),
 				 mroute_addr_print (&mi->real, &gc),
 				 time_string (route->last_reference, 0, false, &gc));
+		  }
 		}
 	      gc_free (&gc);
 	    }
@@ -819,18 +890,22 @@
 
 	      if (multi_route_defined (m, route))
 		{
-		  const struct multi_instance *mi = route->instance;
+		  const struct multi_instance *mi;
 		  const struct mroute_addr *ma = &route->addr;
 		  char flags[2] = {0, 0};
+		  int i;
 
-		  if (route->flags & MULTI_ROUTE_CACHE)
-		    flags[0] = 'C';
-		  status_printf (so, "ROUTING_TABLE%c%s%s%c%s%c%s%c%s%c%u",
+		  for (i = 0; i < route->nb_use; i++) {
+		    mi = route->instances[i];
+		    if (route->flags & MULTI_ROUTE_CACHE)
+		      flags[0] = 'C';
+		    status_printf (so, "ROUTING_TABLE%c%s%s%c%s%c%s%c%s%c%u",
 				 sep, mroute_addr_print (ma, &gc), flags,
 				 sep, tls_common_name (mi->context.c2.tls_multi, false),
 				 sep, mroute_addr_print (&mi->real, &gc),
 				 sep, time_string (route->last_reference, 0, false, &gc),
 				 sep, (unsigned int)route->last_reference);
+		  }
 		}
 	      gc_free (&gc);
 	    }
@@ -895,18 +970,34 @@
   struct hash_bucket *bucket = hash_bucket (m->vhash, hv);
   struct multi_route *oldroute = NULL;
   struct multi_instance *owner = NULL;
+  bool found = false;
+  struct gc_arena gcd = gc_new ();
 
   hash_bucket_lock (bucket);
 
+  msg (D_MULTI_LOW, "MULTI: Entering learn for %s",
+	   mroute_addr_print (addr, &gcd));
   /* if route currently exists, get the instance which owns it */
   he = hash_lookup_fast (m->vhash, bucket, addr, hv);
   if (he)
     oldroute = (struct multi_route *) he->value;
-  if (oldroute && multi_route_defined (m, oldroute))
-    owner = oldroute->instance;
+  if (oldroute && multi_route_defined (m, oldroute)) {
+    int i;
+
+    for (i=0; i < oldroute->nb_use; i++) {
+      owner = oldroute->instances[i];
+      if (owner == mi) {
+        found = true;
+        msg (D_MULTI_LOW, "MULTI: Learn: addr %s found for instance %s",
+	   mroute_addr_print (addr, &gcd),
+	   multi_instance_string (owner, false, &gcd));
+      }
+    }
+  }
 
-  /* do we need to add address to hash table? */
-  if ((!owner || owner != mi)
+
+  /* we don't have this route for this isntance already */
+  if ((!found)
       && mroute_learnable_address (addr)
       && !mroute_addr_equal (addr, &m->local))
     {
@@ -914,59 +1005,60 @@
       struct multi_route *newroute;
       bool learn_succeeded = false;
 
-      ALLOC_OBJ (newroute, struct multi_route);
-      newroute->addr = *addr;
-      newroute->instance = mi;
-      newroute->flags = flags;
-      newroute->last_reference = now;
-      newroute->cache_generation = 0;
-
-      /* The cache is invalidated when cache_generation is incremented */
-      if (flags & MULTI_ROUTE_CACHE)
-	newroute->cache_generation = m->route_helper->cache_generation;
-
+      msg (D_MULTI_LOW, "MULTI: %s learnable",
+	   mroute_addr_print (addr, &gcd));
       if (oldroute) /* route already exists? */
 	{
-	  if (route_quota_test (m, mi) && learn_address_script (m, mi, "update", &newroute->addr))
+	  if (route_quota_test (m, mi) && learn_address_script (m, mi, "update", &oldroute->addr))
 	    {
 	      learn_succeeded = true;
 	      owner = mi;
-	      multi_instance_inc_refcount (mi);
-	      route_quota_inc (mi);
-
-	      /* delete old route */
-	      multi_route_del (oldroute);
-
-	      /* modify hash table entry, replacing old route */
-	      he->key = &newroute->addr;
-	      he->value = newroute;
+	      multi_route_add (oldroute, owner);
+              if (flags & MULTI_ROUTE_CACHE)
+	        oldroute->cache_generation = m->route_helper->cache_generation;
 	    }
 	}
       else
 	{
+          ALLOC_OBJ (newroute, struct multi_route);
+          newroute->addr = *addr;
+	  newroute->instances = NULL;
+          newroute->flags = flags;
+          newroute->last_reference = now;
+          newroute->cache_generation = 0;
+          newroute->nb_use = 0;
+
+          msg (D_MULTI_LOW, "MULTI: %s not found, creating new entry",
+	   mroute_addr_print (addr, &gcd));
+
+          /* The cache is invalidated when cache_generation is incremented */
+          if (flags & MULTI_ROUTE_CACHE)
+        	newroute->cache_generation = m->route_helper->cache_generation;
+
 	  if (route_quota_test (m, mi) && learn_address_script (m, mi, "add", &newroute->addr))
 	    {
 	      learn_succeeded = true;
 	      owner = mi;
-	      multi_instance_inc_refcount (mi);
-	      route_quota_inc (mi);
+	      multi_route_add (newroute, owner);
 
 	      /* add new route */
 	      hash_add_fast (m->vhash, bucket, &newroute->addr, hv, newroute);
 	    }
+
+          if (!learn_succeeded)
+	    free (newroute);
 	}
       
       msg (D_MULTI_LOW, "MULTI: Learn%s: %s -> %s",
 	   learn_succeeded ? "" : " FAILED",
-	   mroute_addr_print (&newroute->addr, &gc),
+	   mroute_addr_print (addr, &gc),
 	   multi_instance_string (mi, false, &gc));
 
-      if (!learn_succeeded)
-	free (newroute);
 
       gc_free (&gc);
     }
 
+  gc_free (&gcd);
   hash_bucket_unlock (bucket);
   return owner;
 }
@@ -991,8 +1083,25 @@
   /* does host route (possible cached) exist? */
   if (route && multi_route_defined (m, route))
     {
-      struct multi_instance *mi = route->instance;
+      struct multi_instance *mi;
+      int i;
+      bool found = false;
       route->last_reference = now;
+      for (i = 0; i < route->nb_use; i++) {
+        /* first, try to find match with "pending" */
+        if (route->instances[i] == m->pending) {
+	  mi = route->instances[i];
+	  found = true;
+	}
+      }
+      if (!found) {
+        for (i = 0; i < route->nb_use; i++) {
+          /* cycle thourgh not halted isntances */
+          if (!(route->instances[i]->halt)) {
+	    mi = route->instances[i];
+	  }
+        }
+      }
       ret = mi;
     }
   else if (cidr_routing) /* do we need to regenerate a host route cache entry? */
@@ -1017,7 +1126,14 @@
 	  if (route && multi_route_defined (m, route))
 	    {
 	      /* found an applicable route, cache host route */
-	      struct multi_instance *mi = route->instance;
+	      struct multi_instance *mi;
+              int i;
+              route->last_reference = now;
+              for (i = 0; i < route->nb_use; i++) {
+                if (!(route->instances[i]->halt)) {
+        	  mi = route->instances[i];
+        	}
+              }
 	      multi_learn_addr (m, mi, addr, MULTI_ROUTE_CACHE|MULTI_ROUTE_AGEABLE);
 	      ret = mi;
 	      break;

--CE+1k2dSO48ffgeK--

