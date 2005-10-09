Message-ID: <4348FD69.6010807@...361...>
From: Rolf Fokkens <r.fokkens@...361...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Patch: TAP usage made non ARP dependent
References: <43404D99.8080309@...361...>  <434189C7.5090304@...361...>  <1128369731.6952.59.camel@...399...> <4342703F.90607@...361...>  <1128428582.7061.18.camel@...399...>  <4342D092.4050502@...361...>  <1128619301.7000.58.camel@...399...>  <4346A01F.4030106@...361...> <1128702738.7000.97.camel@...399...> <4346ED46.4040204@...361...> <43478832.9050200@...361...> <Pine.LNX.4.58.0510081447170.32321@...41...> <4348E1EF.8020906@...361...>
In-Reply-To: <4348E1EF.8020906@...361...>
Content-Type: multipart/mixed;
 boundary="------------080203020909000702030000"
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
Date: Sun Oct  9 04:23:04 2005
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------080203020909000702030000
Content-Type: multipart/alternative;
 boundary="------------020508030709010309000106"

--------------020508030709010309000106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Rolf Fokkens wrote:

> James Yonan wrote:
>
>>Also, it would be great if you could #ifdef this code so that we can turn 
>>it on or off.
>>  
>>
> Sure, I'll do that. I'll do it based on mac_table.[ch], to save time. 
> OK? If you want we can integrate mac_table functionality into 
> lists.[ch], but it may require a lot of your help.

Attached the patch with #ifdefs. I added a #define MACTAB in 
config.h.in, though that may not be the proper way to do it.

I tested it with and without the #define MACTAB, both ways it compiles 
and runs OK with a TAP interface. I didn't test TUN.

Rolf

--------------020508030709010309000106
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Rolf Fokkens wrote:
<blockquote cite="mid4348E1EF.8020906@...361..." type="cite">
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
James Yonan wrote:
  <blockquote cite="midPine.LNX.4.58.0510081447170.32321@...41..."
 type="cite">
    <pre wrap="">Also, it would be great if you could #ifdef this code so that we can turn 
it on or off.
  </pre>
  </blockquote>
Sure, I'll do that. I'll do it based on mac_table.[ch], to save time.
OK? If you want we can integrate mac_table functionality into
lists.[ch], but it may require a lot of your help.<br>
</blockquote>
Attached the patch with #ifdefs. I added a #define MACTAB in
config.h.in, though that may not be the proper way to do it.<br>
<br>
I tested it with and without the #define MACTAB, both ways it compiles
and runs OK with a TAP interface. I didn't test TUN.<br>
<br>
Rolf<br>
</body>
</html>

--------------020508030709010309000106--

--------------080203020909000702030000
Content-Type: text/x-patch;
 name="openvpn-2.0.2-fks-mac3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="openvpn-2.0.2-fks-mac3.patch"

diff -ruN openvpn-2.0.2.orig/config.h.in openvpn-2.0.2/config.h.in
--- openvpn-2.0.2.orig/config.h.in	2005-08-25 17:48:07.000000000 +0200
+++ openvpn-2.0.2/config.h.in	2005-10-09 11:29:02.000000000 +0200
@@ -511,3 +511,7 @@
 /* Define to empty if the keyword `volatile' does not work. Warning: valid
    code using `volatile' can become incorrect without. Disable with care. */
 #undef volatile
+
+/* Define to integrate new MAC table handling for TAP devices.
+   */
+#define MACTAB
diff -ruN openvpn-2.0.2.orig/mac_table.c openvpn-2.0.2/mac_table.c
--- openvpn-2.0.2.orig/mac_table.c	1970-01-01 01:00:00.000000000 +0100
+++ openvpn-2.0.2/mac_table.c	2005-10-09 12:22:11.000000000 +0200
@@ -0,0 +1,319 @@
+#include "config.h"
+
+#ifdef MACTAB
+
+#include "mac_table.h"
+#include <stdio.h>
+
+#define mix(a,b,c)               \
+{                                \
+  a -= b; a -= c; a ^= (c>>13);  \
+  b -= c; b -= a; b ^= (a<<8);   \
+  c -= a; c -= b; c ^= (b>>13);  \
+  a -= b; a -= c; a ^= (c>>12);  \
+  b -= c; b -= a; b ^= (a<<16);  \
+  c -= a; c -= b; c ^= (b>>5);   \
+  a -= b; a -= c; a ^= (c>>3);   \
+  b -= c; b -= a; b ^= (a<<10);  \
+  c -= a; c -= b; c ^= (b>>15);  \
+}
+
+static uint32_t mactab_hash_func (const uint8_t *k, uint32_t mask)
+{
+  uint32_t a, b, c;
+
+  /* Set up the internal state */
+  a = b = 0x9e3779b9;        /* the golden ratio; an arbitrary value */
+
+  c = 6;
+  b  = (uint32_t)*k++;
+  b += (uint32_t)*k++ + (a << 8);
+  b += 0x9e3779b9;
+
+
+  a  = (uint32_t)*k++;
+  a += (uint32_t)*k++ + (a << 8);
+  a += (uint32_t)*k++ + (a << 8);
+  a += (uint32_t)*k++ + (a << 8);
+
+  mix (a, b, c);
+
+  return c & mask;
+}
+
+struct mentry
+{
+  char mac[6];
+  short hval;
+  short active;
+
+  time_t expire;
+
+  struct multi_instance *mi;
+
+  struct mentry *hprev, *hnext; /* Hash Link  */
+  struct mentry *cprev, *cnext; /* Cache link */
+};
+
+struct mactab
+{
+  int bucketmask;
+  int nentries;
+  struct mentry **buckets;
+  struct mentry *entries, *free, *head, *tail;
+};
+
+struct mactab *mactab_init (int nentries)
+{
+  struct mactab *mh;
+  struct mentry *me;
+  uint32_t i, j, nbuckets;
+
+  for (i = nentries, j = 1; i != 0; i >>= 1, j++);
+
+  nbuckets = (1 << j);
+
+  mh = malloc (sizeof (struct mactab));
+
+  mh->bucketmask = nbuckets - 1;
+  mh->buckets    = (struct mentry **) calloc (nbuckets, sizeof (void *));
+
+  mh->nentries   = nentries;
+  mh->entries    = (struct mentry *) calloc (nentries, sizeof (struct mentry));
+
+  mh->head       = NULL;
+  mh->tail       = NULL;
+
+  me             = mh->entries;
+  me->cprev      = NULL;
+  me->cnext      = me + 1;
+  mh->free       = me++;
+  nentries      -= 2;
+
+  while (nentries--) {
+    me->cprev = me - 1;
+    me->cnext = me + 1;
+    me++;
+  }
+  me->cprev = me - 1;
+  me->cnext = NULL;
+
+  return mh;
+};
+
+void mactab_uninit (struct mactab *mh)
+{
+  if (!mh) return;
+
+  free (mh->entries);
+  free (mh->buckets);
+};
+
+static void mactab_unlink_entry (struct mactab *mh, struct mentry *me)
+{
+  struct mentry *mn, *mp;
+
+  mp = me->cprev;
+  mn = me->cnext;
+
+  if (mp) {
+    mp->cnext = mn;
+  } else {
+    mh->head  = mn;
+  }
+  if (mn) {
+    mn->cprev = mp;
+  } else {
+    mh->tail  = mp;
+  }
+}
+
+static void mactab_unhash_entry (struct mactab *mh, struct mentry *me)
+{
+  struct mentry *mn, *mp;
+
+  mp = me->hprev;
+  mn = me->hnext;
+
+  if (mp) {
+    mp->hnext             = mn;
+  } else {
+    mh->buckets[me->hval] = mn;
+  }
+  if (mn) {
+    mn->hprev = mp;
+  }
+};
+
+static void mactab_free_entry (struct mactab *mh, struct mentry *me)
+{
+  struct mentry *mn;
+
+  mactab_unlink_entry (mh, me);
+  mactab_unhash_entry (mh, me);
+
+  mn = mh->free;
+  mn->cprev = me;
+  me->cnext = mn;
+  me->cprev = NULL;
+  mh->free  = me;
+
+  me->active = 0;
+};
+
+static void mactab_link_entry (struct mactab *mh, struct mentry *me)
+{
+  struct mentry *mn;
+
+  mn = mh->head;
+  mh->head  = me;
+
+  me->cnext = mn;
+  me->cprev = NULL;
+
+  if (mn) {
+    mn->cprev = me;
+  } else {
+    mh->tail  = me;
+  }
+};
+
+static void mactab_hash_entry (struct mactab *mh, struct mentry *me)
+{
+  struct mentry *mn;
+
+  me->hval = mactab_hash_func (me->mac, mh->bucketmask);
+
+  mn = mh->buckets[me->hval];
+  mh->buckets[me->hval] = me;
+
+  me->hnext = mn;
+  me->hprev = NULL;
+
+  if (mn) {
+    mn->hprev = me;
+  }
+};
+
+static void mactab_refresh_entry (struct mactab *mh, struct mentry *me)
+{
+  struct mentry *mn, *mp;
+
+  if (mh->head == me) return;
+
+  mactab_unlink_entry (mh, me);
+  mactab_link_entry (mh, me);
+};
+
+static struct mentry *mactab_find_entry (struct mactab *mh, const uint8_t *mac)
+{
+  int hval;
+  struct mentry *me;
+
+  hval = mactab_hash_func (mac, mh->bucketmask);
+  me = mh->buckets[hval];
+  while (me) {
+    if (memcmp (me->mac, mac, 6) == 0) return me;
+    me = me->hnext;
+  }
+  return NULL;
+};
+
+static struct mentry *mactab_get_entry (struct mactab *mh)
+{
+  struct mentry *me;
+
+  if (mh->free) {
+    me = mh->free;
+    mh->free = me->cnext;
+    return me;
+  }
+  me = mh->tail;
+  mactab_unlink_entry (mh, me);
+  mactab_unhash_entry (mh, me);
+
+  return me;
+};
+
+void mactab_learn_mac
+  ( struct mactab *mh, const uint8_t *mac, time_t expire
+  , struct multi_instance *mi)
+{
+  struct mentry *me;
+
+  me = mactab_find_entry (mh, mac);
+  if (me) {
+    mactab_refresh_entry (mh, me);
+  } else {
+    me = mactab_get_entry (mh);
+    memcpy (me->mac, mac, 6);
+    me->mi     = mi;
+    me->active = 1;
+    mactab_hash_entry (mh, me);
+    mactab_link_entry (mh, me);
+  }
+  me->expire = expire;
+};
+
+struct multi_instance *mactab_lookup_mac
+  (struct mactab *mh, const uint8_t *mac, time_t now)
+{
+  struct mentry *me;
+
+  me = mactab_find_entry (mh, mac);
+
+  if (!me)              return NULL;
+  if (!me->active)      return NULL;
+  if (me->expire < now) return NULL;
+
+  return me->mi;
+};
+
+void mactab_remove_mi (struct mactab *mh, struct multi_instance *mi)
+{
+  struct mentry *me, *ml;
+
+  me = mh->entries;
+  ml = me + mh->nentries;
+
+  while (me < ml)
+    {
+      if (me->mi == mi) me->active = 0;
+      me++;
+    }
+};
+
+int mactab_getnext
+  ( struct mactab *mh, int cur, time_t now
+  , char *mac, int *ttl, struct multi_instance **mi)
+{
+  struct mentry *me;
+
+  while (cur < mh->nentries)
+    {
+      me = mh->entries + cur++;
+      if (me->mi && me->expire > now && me->active)
+        {
+          memcpy (mac, me->mac, 6);
+          *ttl = me->expire - now;
+          *mi  = me->mi;
+          return cur;
+        }
+    }
+  return 0;
+};
+
+char *mactab_print (uint8_t *mac)
+{
+  static char buf[19];
+  char *cp = buf;
+  int i;
+
+  for (i = 0; i < 6; i++)
+    {
+      cp += sprintf (cp, ":%02X", (int)*mac++);
+    }
+  return buf + 1;
+};
+
+#endif /* MACTAB */
diff -ruN openvpn-2.0.2.orig/mac_table.h openvpn-2.0.2/mac_table.h
--- openvpn-2.0.2.orig/mac_table.h	1970-01-01 01:00:00.000000000 +0100
+++ openvpn-2.0.2/mac_table.h	2005-10-09 11:31:41.000000000 +0200
@@ -0,0 +1,35 @@
+#ifndef H_MHASH
+#define H_MHASH
+
+#ifdef MACTAB
+
+#include <time.h>
+
+typedef unsigned int uint32_t;
+typedef unsigned char uint8_t;
+
+struct multi_instance;
+struct mactab;
+struct mactab_entry;
+
+extern struct mactab *mactab_init   (int nentries);
+extern void           mactab_uninit (struct mactab *mh);
+
+extern void mactab_learn_mac
+  ( struct mactab *mh, const uint8_t *mac, time_t expire
+  , struct multi_instance *mi);
+
+extern struct multi_instance *mactab_lookup_mac
+  (struct mactab *mh, const uint8_t *mac, time_t now);
+
+extern void mactab_remove_mi (struct mactab *mh, struct multi_instance *mi);
+
+extern int mactab_getnext
+  ( struct mactab *mh, int cur, time_t now
+  , char *mac, int *ttl, struct multi_instance **mi);
+
+extern char *mactab_print (uint8_t *mac);
+
+#endif /* MACTAB */
+
+#endif
diff -ruN openvpn-2.0.2.orig/Makefile.in openvpn-2.0.2/Makefile.in
--- openvpn-2.0.2.orig/Makefile.in	2005-08-25 17:48:10.000000000 +0200
+++ openvpn-2.0.2/Makefile.in	2005-10-06 08:46:16.000000000 +0200
@@ -102,7 +102,7 @@
 	route.$(OBJEXT) schedule.$(OBJEXT) session_id.$(OBJEXT) \
 	shaper.$(OBJEXT) sig.$(OBJEXT) socket.$(OBJEXT) \
 	socks.$(OBJEXT) ssl.$(OBJEXT) status.$(OBJEXT) \
-	thread.$(OBJEXT) tun.$(OBJEXT)
+	thread.$(OBJEXT) tun.$(OBJEXT) mac_table.$(OBJEXT)
 nodist_openvpn_OBJECTS =
 openvpn_OBJECTS = $(am_openvpn_OBJECTS) $(nodist_openvpn_OBJECTS)
 openvpn_LDADD = $(LDADD)
@@ -135,7 +135,7 @@
 @AMDEP_TRUE@	./$(DEPDIR)/sig.Po ./$(DEPDIR)/socket.Po \
 @AMDEP_TRUE@	./$(DEPDIR)/socks.Po ./$(DEPDIR)/ssl.Po \
 @AMDEP_TRUE@	./$(DEPDIR)/status.Po ./$(DEPDIR)/thread.Po \
-@...471...@	./$(DEPDIR)/tun.Po
+@AMDEP_TRUE@	./$(DEPDIR)/tun.Po ./$(DEPDIR)/mac_table.Po
 COMPILE = $(CC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(AM_CPPFLAGS) \
 	$(CPPFLAGS) $(AM_CFLAGS) $(CFLAGS)
 CCLD = $(CC)
@@ -308,7 +308,8 @@
 	status.c status.h \
 	syshead.h \
 	thread.c thread.h \
-	tun.c tun.h
+	tun.c tun.h \
+	mac_table.c mac_table.h
 
 LDADD = @LIBOBJS@
 man_MANS = openvpn.8
@@ -484,6 +485,7 @@
 @AMDEP_TRUE@@am__include@ @am__quote@...220.../$(DEPDIR)/status.Po@...472...@
 @AMDEP_TRUE@@am__include@ @am__quote@...220.../$(DEPDIR)/thread.Po@...472...@
 @AMDEP_TRUE@@am__include@ @am__quote@...220.../$(DEPDIR)/tun.Po@...472...@
+@AMDEP_TRUE@@am__include@ @am__quote@...220.../$(DEPDIR)/mac_table.Po@...472...@
 
 .c.o:
 @am__fastdepCC_TRUE@	if $(COMPILE) -MT $@ -MD -MP -MF "$(DEPDIR)/$*.Tpo" -c -o $@ $<; \
diff -ruN openvpn-2.0.2.orig/multi.c openvpn-2.0.2/multi.c
--- openvpn-2.0.2.orig/multi.c	2005-08-04 01:59:32.000000000 +0200
+++ openvpn-2.0.2/multi.c	2005-10-09 12:00:40.000000000 +0200
@@ -55,6 +55,10 @@
 }
 #endif
 
+#ifdef MACTAB
+static struct multi_instance mi_tap;
+#endif /* MACTAB */
+
 static bool
 learn_address_script (const struct multi_context *m,
 		      const struct multi_instance *mi,
@@ -130,6 +134,10 @@
   struct hash_iterator hi;
   struct hash_element *he;
 
+#ifdef MACTAB
+  if (!m->vhash) return;
+#endif /* MACTAB */
+
   if (start_bucket < 0)
     {
       start_bucket = 0;
@@ -175,6 +183,11 @@
 multi_reap_process_dowork (const struct multi_context *m)
 {
   struct multi_reap *mr = m->reaper;
+
+#ifdef MACTAB
+  if (!m->vhash) return;
+#endif /* MACTAB */
+
   if (mr->bucket_base >= hash_n_buckets (m->vhash))
     mr->bucket_base = 0;
   multi_reap_range (m, mr->bucket_base, mr->bucket_base + mr->buckets_per_pass); 
@@ -231,13 +244,26 @@
 		       mroute_addr_hash_function,
 		       mroute_addr_compare_function);
 
-  /*
-   * Virtual address hash table.  Used to determine
-   * which client to route a packet to. 
-   */
-  m->vhash = hash_init (t->options.virtual_hash_size,
-			mroute_addr_hash_function,
-			mroute_addr_compare_function);
+#ifdef MACTAB
+  if (dev == DEV_TYPE_TAP)
+    {
+      m->vhash = NULL;
+      m->mtab  = mactab_init (1024);
+    }
+  else
+    {
+      m->mtab  = NULL;
+#endif /* MACTAB */
+      /*
+       * Virtual address hash table.  Used to determine
+       * which client to route a packet to. 
+       */
+      m->vhash = hash_init (t->options.virtual_hash_size,
+			    mroute_addr_hash_function,
+			    mroute_addr_compare_function);
+#ifdef MACTAB
+    }
+#endif /* MACTAB */
 
   /*
    * This hash table is a clone of m->hash but with a
@@ -485,6 +511,10 @@
 
   ungenerate_prefix (mi);
 
+#ifdef MACTAB
+  if (m->mtab) mactab_remove_mi (m->mtab, mi);
+#endif /* MACTAB */
+
   /*
    * Don't actually delete the instance memory allocation yet,
    * because virtual routes may still point to it.  Let the
@@ -525,7 +555,12 @@
 	  multi_reap_all (m);
 
 	  hash_free (m->hash);
+#ifdef MACTAB
+	  if (m->vhash) hash_free (m->vhash);
+	  if (m->mtab)  mactab_uninit (m->mtab);
+#else
 	  hash_free (m->vhash);
+#endif /* MACTAB */
 	  hash_free (m->iter);
 	  m->hash = NULL;
 
@@ -660,7 +695,44 @@
 	  hash_iterator_free (&hi);
 
 	  status_printf (so, "ROUTING TABLE");
+
+#ifdef MACTAB
+	  if (m->mtab)
+	    {
+	      struct mactab *mh = m->mtab;
+	      struct multi_instance *mi;
+	      struct gc_arena gc = gc_new ();
+	      int ttl, cur = 0;
+              char mac[6];
+
+	      status_printf (so, "Virtual Address,Common Name,Real Address,TTL");
+	      while (cur = mactab_getnext (mh, cur, now, mac, &ttl, &mi))
+		{
+		  if (mi == &mi_tap)
+		    {
+		      status_printf (so, "%s,%s,%s,%d",
+				     mactab_print (mac),
+				     "LOCAL",
+				     "LOCAL",
+				     ttl);
+		    }
+		  else
+		    {
+		      status_printf (so, "%s,%s,%s,%d",
+				     mactab_print (mac),
+				     tls_common_name (mi->context.c2.tls_multi, false),
+				     mroute_addr_print (&mi->real, &gc),
+				     ttl);
+		    }
+		}
+	      gc_free (&gc);
+	    }
+
+	  if (m->vhash)
+          {
+#endif /* MACTAB */
 	  status_printf (so, "Virtual Address,Common Name,Real Address,Last Ref");
+
 	  hash_iterator_init (m->vhash, &hi, true);
 	  while ((he = hash_iterator_next (&hi)))
 	    {
@@ -685,6 +757,9 @@
 	      gc_free (&gc);
 	    }
 	  hash_iterator_free (&hi);
+#ifdef MACTAB
+	  }
+#endif /* MACTAB */
 
 	  status_printf (so, "GLOBAL STATS");
 	  if (m->mbuf)
@@ -722,7 +797,13 @@
 	    }
 	  hash_iterator_free (&hi);
 
+#ifdef MACTAB
+/* TODO: */
+	  if (m->vhash)
+          {
+#endif /* MACTAB */
 	  status_printf (so, "HEADER,ROUTING_TABLE,Virtual Address,Common Name,Real Address,Last Ref,Last Ref (time_t)");
+
 	  hash_iterator_init (m->vhash, &hi, true);
 	  while ((he = hash_iterator_next (&hi)))
 	    {
@@ -748,6 +829,9 @@
 	      gc_free (&gc);
 	    }
 	  hash_iterator_free (&hi);
+#ifdef MACTAB
+	  }
+#endif /* MACTAB */
 
 	  if (m->mbuf)
 	    status_printf (so, "GLOBAL_STATS,Max bcast/mcast queue length,%d",
@@ -779,11 +863,21 @@
 		  const unsigned int flags)
 {
   struct hash_element *he;
-  const uint32_t hv = hash_value (m->vhash, addr);
-  struct hash_bucket *bucket = hash_bucket (m->vhash, hv);
+  uint32_t hv;
+  struct hash_bucket *bucket;
   struct multi_route *oldroute = NULL;
   struct multi_instance *owner = NULL;
 
+#ifdef MACTAB
+  if (m->mtab) {
+    mactab_learn_mac (m->mtab, addr->addr, now + MULTI_CACHE_ROUTE_TTL, mi);
+    return mi;
+  }
+#endif /* MACTAB */
+
+  hv = hash_value (m->vhash, addr);
+  bucket = hash_bucket (m->vhash, hv);
+
   hash_bucket_lock (bucket);
 
   /* if route currently exists, get the instance which owns it */
@@ -874,6 +968,12 @@
   if (mroute_addr_equal (addr, &m->local))
     return NULL;
 
+#ifdef MACTAB
+  if (m->mtab) {
+    return mactab_lookup_mac (m->mtab, addr->addr, now);
+  }
+#endif /* MACTAB */
+
   route = (struct multi_route *) hash_lookup (m->vhash, addr);
 
   /* does host route (possible cached) exist? */
@@ -1577,6 +1677,7 @@
   unsigned int mroute_flags;
   struct multi_instance *mi;
   bool ret = true;
+  int dev_type;
 
   ASSERT (!m->pending);
 
@@ -1611,7 +1712,8 @@
 	  /* decrypt in instance context */
 	  process_incoming_link (c);
 
-	  if (TUNNEL_TYPE (m->top.c1.tuntap) == DEV_TYPE_TUN)
+	  dev_type = TUNNEL_TYPE (m->top.c1.tuntap);
+	  if (dev_type == DEV_TYPE_TUN)
 	    {
 	      /* extract packet source and dest addresses */
 	      mroute_flags = mroute_extract_addr_from_packet (&src,
@@ -1655,7 +1757,7 @@
 		    }
 		}
 	    }
-	  else if (TUNNEL_TYPE (m->top.c1.tuntap) == DEV_TYPE_TAP)
+	  else if (dev_type == DEV_TYPE_TAP)
 	    {
 	      /* extract packet source and dest addresses */
 	      mroute_flags = mroute_extract_addr_from_packet (&src,
@@ -1677,10 +1779,18 @@
 			  else /* try client-to-client routing */
 			    {
 			      mi = multi_get_instance_by_virtual_addr (m, &dest, false);
-
-			      /* if dest addr is a known client, route to it */
+#ifdef MACTAB
+			      if (!mi)
+				{
+				  /* No known client? Do like a switch: broadcast */
+				  if (dev_type == DEV_TYPE_TAP) multi_bcast (m, &c->c2.to_tun, m->pending);
+				}
+			      else if (mi != &mi_tap)
+#else
 			      if (mi)
+#endif /* MACTAB */
 				{
+				  /* if dest addr is a known client, route to it */
 				  multi_unicast (m, &c->c2.to_tun, mi);
 				  register_activity (c);
 				  c->c2.to_tun.len = 0;
@@ -1748,6 +1858,10 @@
 	{
 	  struct context *c;
 
+#ifdef MACTAB
+	  if (dev_type == DEV_TYPE_TAP) multi_learn_addr (m, &mi_tap, &src, 0);
+#endif /* MACTAB */
+
 	  /* broadcast or multicast dest addr? */
 	  if (mroute_flags & (MROUTE_EXTRACT_BCAST|MROUTE_EXTRACT_MCAST))
 	    {
@@ -1756,9 +1870,22 @@
 	    }
 	  else
 	    {
-	      multi_set_pending (m, multi_get_instance_by_virtual_addr (m, &dest, dev_type == DEV_TYPE_TUN));
+#ifdef MACTAB
+              struct multi_instance *mi;
+
+	      mi = multi_get_instance_by_virtual_addr (m, &dest, dev_type == DEV_TYPE_TUN);
+	      multi_set_pending (m, mi);
 
+	      if (!mi)
+                {
+	          /* No known instance? Do like a switch: broadcast */
+	          if (dev_type == DEV_TYPE_TAP) multi_bcast (m, &m->top.c2.buf, NULL);
+                }
+              else if (mi != &mi_tap)
+#else
+	      multi_set_pending (m, multi_get_instance_by_virtual_addr (m, &dest, dev_type == DEV_TYPE_TUN));
 	      if (m->pending)
+#endif /* MACTAB */
 		{
 		  /* get instance context */
 		  c = &m->pending->context;
diff -ruN openvpn-2.0.2.orig/multi.h openvpn-2.0.2/multi.h
--- openvpn-2.0.2.orig/multi.h	2005-08-04 21:30:33.000000000 +0200
+++ openvpn-2.0.2/multi.h	2005-10-09 11:48:14.000000000 +0200
@@ -37,6 +37,7 @@
 #include "mudp.h"
 #include "mtcp.h"
 #include "perf.h"
+#include "mac_table.h"
 
 /*
  * Walk (don't run) through the routing table,
@@ -97,6 +98,9 @@
 
   struct hash *hash;   /* client instances indexed by real address */
   struct hash *vhash;  /* client instances indexed by virtual address */
+#ifdef MACTAB
+  struct mactab *mtab; /* client instances indexed by virtual MAC address */
+#endif /* MACTAB */
   struct hash *iter;   /* like real address hash but optimized for iteration */
   struct schedule *schedule;
   struct mbuf_set *mbuf;

--------------080203020909000702030000--

