Message-ID: <4342D092.4050502@...361...>
From: Rolf Fokkens <r.fokkens@...361...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Patch: TAP usage made non ARP dependent
References: <43404D99.8080309@...361...>  <434189C7.5090304@...361...>	 <1128369731.6952.59.camel@...399...> <4342703F.90607@...361...> <1128428582.7061.18.camel@...399...>
In-Reply-To: <1128428582.7061.18.camel@...399...>
Content-Type: multipart/mixed;
 boundary="------------010705000203030400020307"
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Oct  4 11:59:28 2005
To: Marcelo Toledo <marcelo@...461...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------010705000203030400020307
Content-Type: multipart/alternative;
 boundary="------------050906070305080401000504"

--------------050906070305080401000504
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

Marcelo Toledo wrote:

>Em Ter, 2005-10-04 =C3=A0s 14:06 +0200, Rolf Fokkens escreveu:
>=20=20
>
>>So another thing that should be implemented probably is aging.
>>=20=20=20=20
>>
>
>Alright, I am aware. Are you planning working on this?
>=20=20
>
Attached you'll find find a new patch which includes aging. Could you try?

--------------050906070305080401000504
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content=3D"text/html;charset=3DUTF-8" http-equiv=3D"Content-Type">
  <title></title>
</head>
<body bgcolor=3D"#ffffff" text=3D"#000000">
Marcelo Toledo wrote:
<blockquote cite=3D"mid1128428582.7061.18.camel@...399..."
 type=3D"cite">
  <pre wrap=3D"">Em Ter, 2005-10-04 =C3=A0s 14:06 +0200, Rolf Fokkens escre=
veu:
  </pre>
  <blockquote type=3D"cite">
    <pre wrap=3D"">So another thing that should be implemented probably is =
aging.
    </pre>
  </blockquote>
  <pre wrap=3D""><!---->
Alright, I am aware. Are you planning working on this?
  </pre>
</blockquote>
Attached you'll find find a new patch which includes aging. Could you
try?<br>
</body>
</html>

--------------050906070305080401000504--

--------------010705000203030400020307
Content-Type: text/x-patch;
 name="openvpn-2.0.2-fks-mac1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="openvpn-2.0.2-fks-mac1.patch"

diff -ruN openvpn-2.0.2.orig/multi.c openvpn-2.0.2/multi.c
--- openvpn-2.0.2.orig/multi.c	2005-08-04 01:59:32.000000000 +0200
+++ openvpn-2.0.2/multi.c	2005-10-04 20:50:00.000000000 +0200
@@ -675,12 +675,13 @@
 
 		  if (route->flags & MULTI_ROUTE_CACHE)
 		    flags[0] = 'C';
-		  status_printf (so, "%s%s,%s,%s,%s",
+		  status_printf (so, "%s%s,%s,%s,%s,%d",
 				 mroute_addr_print (ma, &gc),
 				 flags,
 				 tls_common_name (mi->context.c2.tls_multi, false),
 				 mroute_addr_print (&mi->real, &gc),
-				 time_string (route->last_reference, 0, false, &gc));
+				 time_string (route->last_reference, 0, false, &gc),
+				 now - route->last_update);
 		}
 	      gc_free (&gc);
 	    }
@@ -737,12 +738,13 @@
 
 		  if (route->flags & MULTI_ROUTE_CACHE)
 		    flags[0] = 'C';
-		  status_printf (so, "ROUTING_TABLE,%s%s,%s,%s,%s,%u",
+		  status_printf (so, "ROUTING_TABLE,%s%s,%s,%s,%s,%d,%u",
 				 mroute_addr_print (ma, &gc),
 				 flags,
 				 tls_common_name (mi->context.c2.tls_multi, false),
 				 mroute_addr_print (&mi->real, &gc),
 				 time_string (route->last_reference, 0, false, &gc),
+				 now - route->last_update,
 				 (unsigned int)route->last_reference);
 		}
 	      gc_free (&gc);
@@ -791,7 +793,10 @@
   if (he)
     oldroute = (struct multi_route *) he->value;
   if (oldroute && multi_route_defined (m, oldroute))
-    owner = oldroute->instance;
+    {
+      owner = oldroute->instance;
+      oldroute->last_update = now;
+    }
 
   /* do we need to add address to hash table? */
   if ((!owner || owner != mi)
@@ -807,6 +812,7 @@
       newroute->instance = mi;
       newroute->flags = flags;
       newroute->last_reference = now;
+      newroute->last_update = now;
       newroute->cache_generation = 0;
 
       /* The cache is invalidated when cache_generation is incremented */
@@ -1665,7 +1671,7 @@
 
 	      if (mroute_flags & MROUTE_EXTRACT_SUCCEEDED)
 		{
-		  if (multi_learn_addr (m, m->pending, &src, 0) == m->pending)
+		  if (multi_learn_addr (m, m->pending, &src, MULTI_ROUTE_AGEABLE) == m->pending)
 		    {
 		      /* check for broadcast */
 		      if (m->enable_c2c)
@@ -1756,9 +1762,17 @@
 	    }
 	  else
 	    {
-	      multi_set_pending (m, multi_get_instance_by_virtual_addr (m, &dest, dev_type == DEV_TYPE_TUN));
+              struct multi_instance *mi;
+
+	      mi = multi_get_instance_by_virtual_addr (m, &dest, dev_type == DEV_TYPE_TUN);
+	      multi_set_pending (m, mi);
 
-	      if (m->pending)
+	      if (!mi)
+                {
+	          /* No known instance? Do like a switch: broadcast */
+	          if (dev_type == DEV_TYPE_TAP) multi_bcast (m, &m->top.c2.buf, NULL);
+                }
+              else
 		{
 		  /* get instance context */
 		  c = &m->pending->context;
diff -ruN openvpn-2.0.2.orig/multi.h openvpn-2.0.2/multi.h
--- openvpn-2.0.2.orig/multi.h	2005-08-04 21:30:33.000000000 +0200
+++ openvpn-2.0.2/multi.h	2005-10-04 18:44:39.000000000 +0200
@@ -134,6 +134,7 @@
 
   unsigned int cache_generation;
   time_t last_reference;
+  time_t last_update;
 };
 
 /*
@@ -291,7 +292,7 @@
 	   && r->cache_generation != m->route_helper->cache_generation)
     return false;
   else if ((r->flags & MULTI_ROUTE_AGEABLE)
-	   && r->last_reference + m->route_helper->ageable_ttl_secs < now)
+	   && r->last_update + m->route_helper->ageable_ttl_secs < now)
     return false;
   else
     return true;

--------------010705000203030400020307--

