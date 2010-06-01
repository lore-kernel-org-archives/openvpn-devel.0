Message-ID: <311164.26909.qm@...1373...>
Date: Tue, 1 Jun 2010 05:35:47 -0700 (PDT)
From: ja nein <reg9009@...360...>
MIME-Version: 1.0
Subject: [Openvpn-devel] first Alpha patch /dynamic iroutes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi all,

please find attached the first attempt to dynamically update iroute table. =
Diff is against OpenVPN 2.1.1 source.

There are some caveats, though:

- Only tested (and probably only works) with linux based systems, yet.

- It only works with "topology subnet". The problem is that only "topology =
subnet" ensures the correct determination of the gateway behind the kernel =
route in iroute table.

- We filter for zebra routing messages. Therefore a running quagga daemon i=
s needed. For testing purposes, one can manually add routes through zebra.

Any comments and thoughts are welcome.

Regards,
Sebastian

diff -rupN openvpn.orig/dynroute.h openvpn.patch/dynroute.h
--- openvpn.orig/dynroute.h1970-01-01 01:00:00.000000000 +0100
+++ openvpn.patch/dynroute.h2010-05-27 17:49:50.000000000 +0200
@@ -0,0 +1,370 @@
+//#include <stdbool.h>
+
+#include <stdio.h>
+#include <stdint.h>
+#include <sys/socket.h>
+#include <linux/netlink.h>
+#include <linux/rtnetlink.h>
+#include <string.h>
+#include <fcntl.h>
+
+#ifndef DYNROUTE_H
+#define DYNROUTE_H
+
+#define DYNROUTE_DEBUG_CHATTY 99
+#define DYNROUTE_DEBUG DYNROUTE_DEBUG_CHATTY-1
+
+#define DRA_NONE 0
+#define DRA_NEW 1
+#define DRA_REP 2
+#define DRA_DEL 3
+
+struct dynroute
+{
+int sock;
+int last_error;
+int count;
+bool ready;
+bool nope;//* 2come
+int action;
+in_addr_t gateway;
+struct iroute ir;
+};
+
+static struct multi_instance *
+multi_learn_in_addr_t (struct multi_context *m,
+       struct multi_instance *mi,
+       in_addr_t a,
+       int netbits, /* -1 if host route, otherwise # of network bits in ad=
dress */
+       bool primary);
+
+/* Utility function for parse rtattr. */
+static void netlink_parse_rtattr (struct rtattr **tb, int max, struct rtat=
tr *rta, int len)
+{
+while (RTA_OK (rta, len))
+{
+if (rta->rta_type <=3D max)
+tb[rta->rta_type] =3D rta;
+rta =3D RTA_NEXT (rta, len);
+}
+}
+
+static uint32_t endian_swap (uint32_t x)
+{
+x =3D (x>>24) |=20
+((x<<8) & 0x00FF0000) |
+((x>>8) & 0x0000FF00) |
+(x<<24);
+return x;
+}
+
+static bool dynroute_init (struct dynroute *dr)
+{
+if (dr->ready !=3D true)
+{
+dr->count =3D 0;
+dr->last_error =3D 0;
+dr->action =3D DRA_NONE;
+dr->ready =3D false;
+dr->nope =3D false;
+dr->sock =3D socket (AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
+if (dr->sock < 0)
+{
+#ifdef DYNROUTE_DEBUG
+dr->last_error =3D dr->sock;
+fprintf (stderr, "dynroute_init: ERROR socket() : %d\n", dr->last_error);
+#endif
+return dr->ready;
+}
+struct sockaddr_nl addr;
+memset ((void *) &addr, 0, sizeof (addr));
+addr.nl_family =3D AF_NETLINK;
+addr.nl_pid =3D getpid ();
+addr.nl_groups =3D RTMGRP_IPV4_ROUTE;
+dr->last_error =3D bind (dr->sock, (struct sockaddr *) &addr, sizeof (addr=
));
+if (dr->last_error < 0)
+{
+#ifdef DYNROUTE_DEBUG
+fprintf (stderr, "dynroute_init: ERROR bind() : %d\n", dr->last_error);
+#endif
+return dr->ready;
+}
+dr->last_error =3D fcntl (dr->sock, F_SETFL, O_NONBLOCK);
+if (dr->last_error < 0)
+{
+#ifdef DYNROUTE_DEBUG
+fprintf (stderr, "dynroute_init: ERROR fcntl() : %d\n", dr->last_error);
+#endif
+return dr->ready;
+}
+#ifdef DYNROUTE_DEBUG
+fprintf (stderr, "dynroute_init: OK\n");
+#endif
+dr->ready =3D true;
+}
+#ifdef DYNROUTE_DEBUG
+else
+{
+fprintf (stderr, "dynroute_init: allready initialised, skipped.\n");
+}
+#endif
+return dr->ready;
+}//* int open_socket ()
+
+static bool dynroute_read (struct dynroute *dr)
+{
+dr->action =3D DRA_NONE;
+bool retval =3D false;
+if (dr->ready !=3D true)
+{
+#ifdef DYNROUTE_DEBUG
+fprintf (stderr, "dynroute_read: not ready, trying dynroute_init().\n");
+#endif
+if (dynroute_init (dr) !=3D true)
+return dr->ready;
+}
+
+struct nlmsghdr *nlh;
+struct rtmsg *rtm;
+struct sockaddr_nl addr;
+struct rtattr *tb[RTA_MAX + 1];
+
+char buf [4096];
+struct iovec iov =3D { buf, sizeof (buf) };
+struct msghdr msg;
+int len;
+
+msg.msg_name =3D (void *) &addr;
+msg.msg_namelen =3D sizeof (addr);
+msg.msg_iov =3D &iov;
+msg.msg_iovlen =3D 1;
+
+dr->last_error =3D recvmsg (dr->sock, &msg, 0);
+if (dr->last_error < 0)
+{
+#ifdef DYNROUTE_DEBUG
+if (DYNROUTE_DEBUG =3D=3D DYNROUTE_DEBUG_CHATTY)
+fprintf (stderr, "dynroute_read: recvmsg() : %d\n", dr->last_error);
+#endif
+return false;
+}
+nlh =3D (struct nlmsghdr *) buf;
+rtm =3D NLMSG_DATA(nlh);
+
+if (rtm->rtm_protocol !=3D RTPROT_ZEBRA)
+{
+#ifdef DYNROUTE_DEBUG
+//if (DYNROUTE_DEBUG =3D=3D DYNROUTE_DEBUG_CHATTY)
+fprintf (stderr, "dynroute_read: no zebra\n");
+#endif
+return false;
+}
+
+
+len =3D nlh->nlmsg_len - NLMSG_LENGTH (sizeof (struct rtmsg));
+dr->last_error =3D len;
+if (dr->last_error < 0)
+{
+#ifdef DYNROUTE_DEBUG
+fprintf (stderr, "dynroute_read: ERROR nlh->nlmsg_len : %d\n", dr->last_er=
ror);
+#endif
+return false;
+}
+
+memset (tb, 0, sizeof tb);
+netlink_parse_rtattr (tb, RTA_MAX, RTM_RTA (rtm), len);
+
+in_addr_t *dstp;
+in_addr_t *gw;
+
+if (tb[RTA_GATEWAY])
+gw =3D RTA_DATA (tb[RTA_GATEWAY]);
+if (tb[RTA_DST])
+dstp =3D RTA_DATA (tb[RTA_DST]);
+
+in_addr_t *srcp;
+if (tb[RTA_SRC])
+srcp =3D RTA_DATA (tb[RTA_SRC]);
+if (tb[RTA_MULTIPATH])
+{
+//fprintf (stderr, "\nRTA_MULTIPATH\n");
+      struct rtnexthop *rtnh =3D
+        (struct rtnexthop *) RTA_DATA (tb[RTA_MULTIPATH]);
+      len =3D RTA_PAYLOAD (tb[RTA_MULTIPATH]);
+
+      if (len < (int) sizeof (*rtnh))
+        return 0;
+      if (rtnh->rtnh_len > len)
+        return 0;
+
+      int index =3D rtnh->rtnh_ifindex;
+      if (rtnh->rtnh_len > sizeof (*rtnh))
+        {
+          memset (tb, 0, sizeof (tb));
+          netlink_parse_rtattr (tb, RTA_MAX, RTNH_DATA (rtnh),
+                                rtnh->rtnh_len - sizeof (*rtnh));
+          if (tb[RTA_GATEWAY])
+            gw =3D RTA_DATA (tb[RTA_GATEWAY]);
+        }
+    }
+
+/*
++  if (tb[RTA_MULTIPATH])
++    {
++      //* Look for the interface and gateway from the first path *
++      struct rtnexthop *rtnh =3D
++        (struct rtnexthop *) RTA_DATA (tb[RTA_MULTIPATH]);
++      len =3D RTA_PAYLOAD (tb[RTA_MULTIPATH]);
++
++      if (len < (int) sizeof (*rtnh))
++        return 0;
++      if (rtnh->rtnh_len > len)
++        return 0;
++
++      index =3D rtnh->rtnh_ifindex;
++      if (rtnh->rtnh_len > sizeof (*rtnh))
++        {
++          memset (tb, 0, sizeof (tb));
++          netlink_parse_rtattr (tb, RTA_MAX, RTNH_DATA (rtnh),
++                                rtnh->rtnh_len - sizeof (*rtnh));
++          if (tb[RTA_GATEWAY])
++            gate =3D RTA_DATA (tb[RTA_GATEWAY]);
++        }
++    }
+*/
+//fprintf (stderr, "dynroute_read: rtm_dst/src_len : %d/%d\n", rtm->rtm_ds=
t_len,rtm->rtm_src_len);
+
+#ifdef DYNROUTE_DEBUG
+if (DYNROUTE_DEBUG =3D=3D DYNROUTE_DEBUG_CHATTY)
+fprintf (stderr, "dynroute_read: [#%d]", dr->count++);
+//fprintf (stderr, "[PROT %d]", rtm->rtm_protocol);
+#endif
+
+switch (nlh->nlmsg_type)
+{
+case RTM_NEWROUTE:
+switch (nlh->nlmsg_flags)
+{
+case 0:
+case NLM_F_CREATE:
+dr->action =3D DRA_NEW;
+#ifdef DYNROUTE_DEBUG
+if (DYNROUTE_DEBUG =3D=3D DYNROUTE_DEBUG_CHATTY)
+fprintf (stderr, "[NEW]");
+#endif
+break;
+case NLM_F_REPLACE:
+dr->action =3D DRA_REP;
+#ifdef DYNROUTE_DEBUG
+if (DYNROUTE_DEBUG =3D=3D DYNROUTE_DEBUG_CHATTY)
+fprintf (stderr, "[CHANGED]");
+#endif
+break;
+default:
+dr->action =3D DRA_NONE;
+#ifdef DYNROUTE_DEBUG
+if (DYNROUTE_DEBUG =3D=3D DYNROUTE_DEBUG_CHATTY)
+fprintf (stderr, "[Dunno what %d means (nlh->nlmsg_flags)]", nlh->nlmsg_fl=
ags);
+#endif
+break;
+}
+break;
+case RTM_DELROUTE:
+dr->action =3D DRA_DEL;
+#ifdef DYNROUTE_DEBUG
+if (DYNROUTE_DEBUG =3D=3D DYNROUTE_DEBUG_CHATTY)
+fprintf (stderr, "[DEL]");
+#endif
+break;
+}
+dr->gateway =3D endian_swap (*gw);
+dr->ir.network =3D endian_swap (*dstp);
+dr->ir.netbits =3D rtm->rtm_dst_len;
+#ifdef DYNROUTE_DEBUG
+if (DYNROUTE_DEBUG =3D=3D DYNROUTE_DEBUG_CHATTY)
+fprintf (stderr, "dynroute_read: OK\n");
+#endif
+return dr->ready;
+}
+
+static bool dynroute_re (struct multi_context *m, struct iroute ir)
+{
+bool ret =3D false;
+struct openvpn_sockaddr remote_si;
+struct mroute_addr addr;
+struct hash_element *he;
+
+CLEAR (remote_si);
+remote_si.sa.sin_family =3D AF_INET;
+remote_si.sa.sin_addr.s_addr =3D htonl (ir.network);
+ASSERT (mroute_extract_openvpn_sockaddr (&addr, &remote_si, false));
+if (ir.netbits >=3D 0)
+{
+addr.type |=3D MR_WITH_NETBITS;
+addr.netbits =3D (uint8_t) ir.netbits;
+}
+const uint32_t hv =3D hash_value (m->vhash, &addr);
+struct hash_bucket *bucket =3D hash_bucket (m->vhash, hv);
+struct multi_route *oldroute =3D NULL;
+
+hash_bucket_lock (bucket);
+/* if route currently exists, get the instance which owns it */
+he =3D hash_lookup_fast (m->vhash, bucket, &addr, hv);
+if (he)
+oldroute =3D (struct multi_route *) he->value;
+hash_bucket_unlock (bucket);
+ret =3D (oldroute && multi_route_defined (m, oldroute));
+return ret;
+}
+
+static bool dynroute_eval (struct multi_context *m, struct dynroute *dr)
+{
+bool ret =3D true;
+if (dr->action > DRA_NONE)// route added / deleted
+{
+struct hash_iterator hi;
+struct hash_element *he;
+hash_iterator_init (m->hash, &hi, true);
+while ((he =3D hash_iterator_next (&hi)))
+{
+struct gc_arena gc =3D gc_new ();
+struct multi_instance *mi =3D (struct multi_instance *) he->value;
+struct openvpn_sockaddr remote_si;
+struct mroute_addr addr;
+if (!mi->halt)
+{
+if (mi->reporting_addr =3D=3D dr->gateway)// route gateway matches instanc=
e ip
+{
+switch (dr->action)
+{
+case DRA_NEW:
+msg (D_MULTI_LOW, "DYNROUTE: New: %s/%d -> %s",
+print_in_addr_t (dr->ir.network, IA_EMPTY_IF_UNDEF, &gc),
+dr->ir.netbits,
+multi_instance_string (mi, false, &gc));
+mroute_helper_add_iroute (m->route_helper, (struct iroute *) &dr->ir);
+multi_learn_in_addr_t (m, mi, dr->ir.network, dr->ir.netbits, false);
+break;
+case DRA_DEL:
+if (dynroute_re (m, dr->ir))
+{
+mroute_helper_del_iroute (m->route_helper, (struct iroute *) &dr->ir);
+msg (D_MULTI_LOW, "DYNROUTE: Delete: %s/%d -> %s",
+print_in_addr_t (dr->ir.network, IA_EMPTY_IF_UNDEF, &gc), dr->ir.netbits,
+print_in_addr_t (dr->gateway, IA_EMPTY_IF_UNDEF, &gc));
+}
+break;
+default:
+msg (D_MULTI_LOW, "DYNROUTE: UNKNOWN ACTION: %d", dr->action);
+break;
+}
+}// if (mi->reporting_addr =3D=3D dr->gateway)
+}// if (!mi->halt)
+gc_free (&gc);
+}// while ((he =3D hash_iterator_next (&hi)))
+hash_iterator_free (&hi);
+}// if (dr->action > DRA_NONE)
+return ret;
+}
+
+#endif /* DYNROUTE_H */
diff -rupN openvpn.orig/multi.c openvpn.patch/multi.c
--- openvpn.orig/multi.c2009-10-24 17:17:30.000000000 +0200
+++ openvpn.patch/multi.c2010-05-31 12:39:09.406250000 +0200
@@ -37,6 +37,9 @@
 #include "forward-inline.h"
 #include "pf-inline.h"
=20
+#include "dynroute.h"
+struct dynroute dr;
+
 /*#define MULTI_DEBUG_EVENT_LOOP*/
=20
 #ifdef MULTI_DEBUG_EVENT_LOOP
@@ -2266,6 +2269,9 @@ multi_process_timeout (struct multi_cont
 {
   bool ret =3D true;
=20
+ if (dynroute_read (&dr))// checking socket
+dynroute_eval (m, &dr);
+
 #ifdef MULTI_DEBUG_EVENT_LOOP
   printf ("%s -> TIMEOUT\n", id(m->earliest_wakeup));
 #endif




