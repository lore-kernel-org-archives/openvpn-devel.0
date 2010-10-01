From: "Sven-Ola Tuecke" <sven-ola@...68...>
Date: Fri, 1 Oct 2010 10:58:24 +0200
References: <201010011051.32813.sven-ola@...68...>
In-Reply-To: <201010011051.32813.sven-ola@...68...>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_wKapMEPQHZ/Oxvg"
Message-Id: <201010011058.24902.sven-ola@...68...>
Subject: Re: [Openvpn-devel] [PATCH] dynamic-Iroute config option for
	automatic iroutes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--Boundary-00=_wKapMEPQHZ/Oxvg
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Oops,

my mail client insist on breaking lines. Sorry for that - this mail attaches 
the patch in it's original form.

// Sven-Ola

Am Freitag, 1. Oktober 2010, um 10:51:32 schrieb Sven-Ola Tuecke:
> Signed-off-by: Sven-Ola Tuecke <sven-ola()gmx.de>


--Boundary-00=_wKapMEPQHZ/Oxvg
Content-Type: text/x-patch; charset="UTF-8";
	name="dynamic-iroutes-git-allmerged.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dynamic-iroutes-git-allmerged.patch"

diff --git a/multi.c b/multi.c
index 5d15ea9..ab40e6c 100644
--- a/multi.c
+++ b/multi.c
@@ -974,6 +974,7 @@ multi_learn_addr (struct multi_context *m,
 static struct multi_instance *
 multi_get_instance_by_virtual_addr (struct multi_context *m,
 				    const struct mroute_addr *addr,
+				    bool dynamic_iroute,
 				    bool cidr_routing)
 {
   struct multi_route *route;
@@ -1020,6 +1021,24 @@ multi_get_instance_by_virtual_addr (struct multi_context *m,
 	      break;
 	    }
 	}
+      if (!ret && dynamic_iroute)
+	{
+	  const struct iroute *ir;
+
+	  /* does address match a dynamic_iroute? */
+	  for (ir = m->top.options.dynamic_iroutes; ir != NULL; ir = ir->next)
+	    {
+	      in_addr_t cmp_addr = ntohl(*(in_addr_t*)addr->addr);
+	      ASSERT ((addr->type & MR_ADDR_MASK) == MR_ADDR_IPV4);
+	      cmp_addr &= netbits_to_netmask (ir->netbits);
+	      if (cmp_addr == ir->network)
+		{
+		  multi_learn_addr (m, m->pending, addr, MULTI_ROUTE_CACHE|MULTI_ROUTE_AGEABLE);
+		  ret = m->pending;
+		  break;
+		}
+	    }
+	}
       
       mroute_helper_unlock (rh);
     }
@@ -2100,7 +2119,7 @@ multi_process_incoming_link (struct multi_context *m, struct multi_instance *ins
 		  c->c2.to_tun.len = 0;
 		}
 	      /* make sure that source address is associated with this client */
-	      else if (multi_get_instance_by_virtual_addr (m, &src, true) != m->pending)
+	      else if (multi_get_instance_by_virtual_addr (m, &src, true, true) != m->pending)
 		{
 		  msg (D_MULTI_DROPPED, "MULTI: bad source address from client [%s], packet dropped",
 		       mroute_addr_print (&src, &gc));
@@ -2118,7 +2137,7 @@ multi_process_incoming_link (struct multi_context *m, struct multi_instance *ins
 		  else /* possible client to client routing */
 		    {
 		      ASSERT (!(mroute_flags & MROUTE_EXTRACT_BCAST));
-		      mi = multi_get_instance_by_virtual_addr (m, &dest, true);
+		      mi = multi_get_instance_by_virtual_addr (m, &dest, false, true);
 		  
 		      /* if dest addr is a known client, route to it */
 		      if (mi)
@@ -2179,7 +2198,7 @@ multi_process_incoming_link (struct multi_context *m, struct multi_instance *ins
 			    }
 			  else /* try client-to-client routing */
 			    {
-			      mi = multi_get_instance_by_virtual_addr (m, &dest, false);
+			      mi = multi_get_instance_by_virtual_addr (m, &dest, false, false);
 
 			      /* if dest addr is a known client, route to it */
 			      if (mi)
@@ -2302,7 +2321,7 @@ multi_process_incoming_tun (struct multi_context *m, const unsigned int mpp_flag
 	    }
 	  else
 	    {
-	      multi_set_pending (m, multi_get_instance_by_virtual_addr (m, &dest, dev_type == DEV_TYPE_TUN));
+	      multi_set_pending (m, multi_get_instance_by_virtual_addr (m, &dest, false, dev_type == DEV_TYPE_TUN));
 
 	      if (m->pending)
 		{
diff --git a/options.c b/options.c
index 4aec5cb..5c5c4be 100644
--- a/options.c
+++ b/options.c
@@ -417,6 +417,9 @@ static const char usage_message[] =
   "--iroute-ipv6 network/bits : Route IPv6 subnet to client.\n"
   "                  Sets up internal routes only.\n"
   "                  Only valid in a client-specific config file.\n"
+  "--dynamic-iroute network [netmask] : Define subnet for iroute autocreation.\n"
+  "                  Defines a range of IPs to be accepted behind clients.\n"
+  "                  Only useful with a learn-address script.\n"
   "--disable       : Client is disabled.\n"
   "                  Only valid in a client-specific config file.\n"
   "--client-cert-not-required : Don't require client certificate, client\n"
@@ -1150,6 +1153,7 @@ static void
 option_iroute (struct options *o,
 	       const char *network_str,
 	       const char *netmask_str,
+	       bool dynamic_iroute,
 	       int msglevel)
 {
   struct iroute *ir;
@@ -1163,15 +1167,24 @@ option_iroute (struct options *o,
       const in_addr_t netmask = getaddr (GETADDR_HOST_ORDER, netmask_str, 0, NULL, NULL);
       if (!netmask_to_netbits (ir->network, netmask, &ir->netbits))
 	{
-	  msg (msglevel, "in --iroute %s %s : Bad network/subnet specification",
+	  msg (msglevel, "in --%siroute %s %s : Bad network/subnet specification",
+	       dynamic_iroute ? "auto" : "",
 	       network_str,
 	       netmask_str);
 	  return;
 	}
     }
 
-  ir->next = o->iroutes;
-  o->iroutes = ir;
+  if (dynamic_iroute)
+    {
+      ir->next = o->dynamic_iroutes;
+      o->dynamic_iroutes = ir;
+    }
+  else
+    {
+      ir->next = o->iroutes;
+      o->iroutes = ir;
+    }
 }
 
 static void
@@ -5377,7 +5390,18 @@ add_option (struct options *options,
 	{
 	  netmask = p[2];
 	}
-      option_iroute (options, p[1], netmask, msglevel);
+      option_iroute (options, p[1], netmask, false, msglevel);
+    }
+  else if (streq (p[0], "dynamic-iroute") && p[1])
+    {
+      const char *netmask = NULL;
+
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      if (p[2])
+	{
+	  netmask = p[2];
+	}
+      option_iroute (options, p[1], netmask, true, msglevel);
     }
   else if (streq (p[0], "iroute-ipv6") && p[1])
     {
diff --git a/options.h b/options.h
index 1ef96ca..70cac55 100644
--- a/options.h
+++ b/options.h
@@ -410,6 +410,7 @@ struct options
   int n_bcast_buf;
   int tcp_queue_limit;
   struct iroute *iroutes;
+  struct iroute *dynamic_iroutes;
   struct iroute_ipv6 *iroutes_ipv6;			/* IPv6 */
   bool push_ifconfig_defined;
   in_addr_t push_ifconfig_local;

--Boundary-00=_wKapMEPQHZ/Oxvg--

