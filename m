From: Antonio Quartulli <a@...2181...>
Date: Sun,  3 Dec 2017 00:24:52 +0800
Message-Id: <20171202162453.29838-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH 1/2] PF: implement support for IPv6 subnets
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
Cc: Antonio Quartulli <a@...2181...>

The PF subnets component has been extended to also accept
IPv6 networks. The syntax is exactly the same as the IPv4
subnets.

The user only needs to list the IPv6 networks in the same
"[SUBNETS DROP/ACCEPT]" block as the IPv4 ones.

Example:

[SUBNETS ACCEPT]
-180.180.0.0/16
-2001:caca:beef::/48

The PF rule parser was improved to also accept subnets without any
netmask: a host address (full netmask) is assumed in this case.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/mroute.c |   1 +
 src/openvpn/mroute.h |  19 +++
 src/openvpn/pf.c     | 447 ++++++++++++++++++++++++++++++++++++++++++++-------
 src/openvpn/pf.h     |  13 +-
 src/openvpn/route.h  |  23 +++
 src/openvpn/socket.c |  16 ++
 src/openvpn/socket.h |   9 ++
 7 files changed, 465 insertions(+), 63 deletions(-)

diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 74ee360c..8b364efd 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -265,6 +265,7 @@ mroute_extract_addr_ether(struct mroute_addr *src,
             {
                 switch (ntohs(eth->proto))
                 {
+                    case OPENVPN_ETH_P_IPV6:
                     case OPENVPN_ETH_P_IPV4:
                         ret |= (mroute_extract_addr_ip(esrc, edest, &b) << MROUTE_SEC_SHIFT);
                         break;
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index 35361fbd..eacb1239 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -257,6 +257,25 @@ in_addr_t_from_mroute_addr(const struct mroute_addr *addr)
     }
 }
 
+/**
+ * Extract host address from mroute_addr object.
+ *
+ * @param addr	mroute object to extract the address from
+ */
+static inline struct in6_addr
+in6_addr_from_mroute_addr(const struct mroute_addr *addr)
+{
+    if (((addr->type & MR_ADDR_MASK) == MR_ADDR_IPV6) && (addr->netbits == 0) &&
+        (addr->len == 16))
+    {
+        return addr->v6.addr;
+    }
+    else
+    {
+        return in6addr_any;
+    }
+}
+
 static inline void
 mroute_addr_reset(struct mroute_addr *ma)
 {
diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
index 6e4107c5..27bc39e4 100644
--- a/src/openvpn/pf.c
+++ b/src/openvpn/pf.c
@@ -6,6 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2016-2017 Antonio Quartulli <a@...2181...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -84,61 +85,260 @@ add_client(const char *line, const char *prefix, const int line_num, struct pf_c
     return true;
 }
 
+/**
+ * Parse line and try to add an IPv6 subnet to the PF subnet list
+ *
+ * @param line          the line to parse
+ * @param prefix        logging prefix
+ * @param line_num      line number in the PF file
+ * @param div           pointer to the character after the '/', if any
+ * @param next          pointer to the location where the next subnet has to be
+ *                  stored
+ * @param exclude       if true, the opposite of the default policy is applied
+ */
 static bool
-add_subnet(const char *line, const char *prefix, const int line_num, struct pf_subnet ***next, const bool exclude)
+add_subnet_v4(const char *line, const char *prefix, const int line_num,
+              const char *div, struct pf_subnet ***next, const bool exclude)
 {
     struct in_addr network;
     in_addr_t netmask = 0;
+    int netbits = 32;
+
+    if (div)
+    {
+        if (sscanf(div, "%d", &netbits) != 1)
+        {
+            msg(D_PF_INFO, "PF: %s/%d: bad '/n' v4 subnet specifier: '%s'",
+                prefix, line_num, div);
+            return false;
+        }
+    }
+
+    if ((netbits < 0) || (netbits > 32))
+    {
+        msg(D_PF_INFO,
+            "PF: %s/%d: bad '/n' v4 subnet specifier: must be between 0 and 32: '%s'",
+            prefix, line_num, div);
+        return false;
+    }
+
+    if (openvpn_inet_aton(line, &network) != OIA_IP)
+    {
+        msg(D_PF_INFO, "PF: %s/%d: bad v4 network address: '%s'", prefix, line_num,
+            line);
+        return false;
+    }
+
+    netmask = netbits_to_netmask(netbits);
+    if ((network.s_addr & htonl(netmask)) != network.s_addr)
+    {
+        network.s_addr &= htonl(netmask);
+        msg(M_WARN,
+            "WARNING: PF: %s/%d: incorrect v4 subnet %s/%d changed to %s/%d",
+            prefix, line_num, line, netbits, inet_ntoa(network), netbits);
+    }
+
+    {
+        struct pf_subnet *e;
+        ALLOC_OBJ_CLEAR(e, struct pf_subnet);
+        e->addr_family = AF_INET;
+        e->exclude = exclude;
+        e->rule.v4.network = ntohl(network.s_addr);
+        e->rule.v4.netmask = netmask;
+        **next = e;
+        *next = &e->next;
+
+        return true;
+    }
+}
+
+/**
+ * Return actual network class based on the specified address and mask
+ *
+ * @param addr  address to extract the class from
+ * @param mask  the network mask
+ */
+static struct in6_addr
+pf_addr_v6_mask(const struct in6_addr *addr, const struct in6_addr *mask)
+{
+    struct in6_addr res;
+    int i;
+
+    for (i = 0; i < sizeof(*addr); i++)
+    {
+        res.s6_addr[i] = addr->s6_addr[i] & mask->s6_addr[i];
+    }
+
+    return res;
+}
+
+/**
+ * Check if two IPv6 addresses belongs to the same class
+ *
+ * @param addr1 first address to check
+ * @param addr2 second address to check
+ * @param mask  netmask to use to extract the IP class
+ */
+static bool
+pf_addr_v6_masked_eq(const struct in6_addr *addr1,
+                     const struct in6_addr *addr2,
+                     const struct in6_addr *mask)
+{
+    uint8_t res = 0;
+    int i;
+
+    for (i = 0; i < sizeof(*addr1); i++)
+    {
+        res |= (addr1->s6_addr[i] ^ addr2->s6_addr[i]) & mask->s6_addr[i];
+    }
 
-    if (strcmp(line, "unknown"))
+    return res;
+}
+
+/**
+ * Compare two IPv6 addresses
+ *
+ * @param addr1 first address to check
+ * @param addr2 second address to check
+ */
+static int
+pf_addr_v6_cmp(struct in6_addr *addr1, struct in6_addr *addr2)
+{
+    return memcmp(addr1, addr2, sizeof(*addr1));
+}
+
+
+/**
+ * Parse line and try to add an IPv6 subnet to the PF subnet list
+ *
+ * @param line          the line to parse
+ * @param prefix        logging prefix
+ * @param line_num      line number in the PF file/buffer
+ * @param div           pointer to the character after the '/', if any
+ * @param next          pointer to the location where the next subnet has to be
+ *                      stored
+ * @param exclude       if true, the opposite of the default policy is applied
+ */
+static bool
+add_subnet_v6(const char *line, const char *prefix, const int line_num,
+              const char *div, struct pf_subnet ***next, const bool exclude)
+
+{
+    struct in6_addr network, tmp;
+    struct in6_addr netmask;
+    int netbits = 128;
+
+    if (div)
+    {
+        if (sscanf(div, "%d", &netbits) != 1)
+        {
+            msg(D_PF_INFO, "PF: %s/%d: bad '/n' v6 subnet specifier: '%s'",
+                prefix, line_num, div);
+            return false;
+        }
+    }
+
+    if ((netbits < 0) || (netbits > 128))
+    {
+        msg(D_PF_INFO,
+            "PF: %s/%d: bad '/n' v6 subnet specifier: must be between 0 and 128: '%s'",
+            prefix, line_num, div);
+        return false;
+    }
+
+    if (openvpn_inet_aton_v6(line, &network) != OIA_IP)
+    {
+        msg(D_PF_INFO, "PF: %s/%d: bad v6 network address: '%s'", prefix, line_num,
+            line);
+        return false;
+    }
+
+    netmask = netbits_to_netmask_v6(netbits);
+    tmp = network;
+    network = pf_addr_v6_mask(&network, &netmask);
+    if (pf_addr_v6_cmp(&network, &tmp) != 0)
+    {
+        char v6_str[INET6_ADDRSTRLEN] = {0};
+
+        inet_ntop(AF_INET6, &network, v6_str, INET6_ADDRSTRLEN);
+        msg(M_WARN,
+            "WARNING: PF: %s/%d: incorrect v6 subnet %s/%d changed to %s/%d",
+            prefix, line_num, line, netbits, v6_str, netbits);
+    }
+
+    {
+        struct pf_subnet *e;
+        ALLOC_OBJ_CLEAR(e, struct pf_subnet);
+        e->addr_family = AF_INET6;
+        e->exclude = exclude;
+        e->rule.v6.network = network;
+        e->rule.v6.netmask = netmask;
+        **next = e;
+        *next = &e->next;
+
+        return true;
+    }
+}
+
+/**
+ * Parse line and try to add a subnet to the PF subnet list (either IPv4 or
+ * IPv6)
+ *
+ * @param line          the line to parse
+ * @param prefix        some prefix
+ * @param line_num      line number in the PF file/buffer
+ * @param next          pointer to the location where the next subnet has to be
+ *                      stored
+ * @param exclude       if true, the opposite of the default policy is applied
+ */
+static bool
+add_subnet(const char *line, const char *prefix, const int line_num,
+           struct pf_subnet ***next, const bool exclude)
+{
+    if (strcmp(line, "unknown") != 0)
     {
-        int netbits = 32;
         char *div = strchr(line, '/');
 
+        /* if no '/' is found, assume maximum mask */
         if (div)
         {
             *div++ = '\0';
-            if (sscanf(div, "%d", &netbits) != 1)
-            {
-                msg(D_PF_INFO, "PF: %s/%d: bad '/n' subnet specifier: '%s'", prefix, line_num, div);
-                return false;
-            }
-            if (netbits < 0 || netbits > 32)
-            {
-                msg(D_PF_INFO, "PF: %s/%d: bad '/n' subnet specifier: must be between 0 and 32: '%s'", prefix, line_num, div);
-                return false;
-            }
         }
 
-        if (openvpn_inet_aton(line, &network) != OIA_IP)
+        if (!strchr(line, ':'))
+        /* ':' NOT found -> try parsing as IPv4 */
         {
-            msg(D_PF_INFO, "PF: %s/%d: bad network address: '%s'", prefix, line_num, line);
-            return false;
+            return add_subnet_v4(line, prefix, line_num, div, next, exclude);
         }
-        netmask = netbits_to_netmask(netbits);
-        if ((network.s_addr & htonl(netmask)) != network.s_addr)
+        else
+        /* ':' found -> try parsing as IPv6 */
         {
-            network.s_addr &= htonl(netmask);
-            msg(M_WARN, "WARNING: PF: %s/%d: incorrect subnet %s/%d changed to %s/%d", prefix, line_num, line, netbits, inet_ntoa(network), netbits);
+            return add_subnet_v6(line, prefix, line_num, div, next, exclude);
         }
     }
     else
     {
         /* match special "unknown" tag for addresses unrecognized by mroute */
-        network.s_addr = htonl(0);
-        netmask = IPV4_NETMASK_HOST;
-    }
-
-    {
         struct pf_subnet *e;
+
         ALLOC_OBJ_CLEAR(e, struct pf_subnet);
-        e->rule.exclude = exclude;
-        e->rule.network = ntohl(network.s_addr);
-        e->rule.netmask = netmask;
+        e->addr_family = AF_INET;
+        e->exclude = exclude;
+        e->rule.v4.network = 0;
+        e->rule.v4.netmask = IPV4_NETMASK_HOST;
+        **next = e;
+        *next = &e->next;
+
+        ALLOC_OBJ_CLEAR(e, struct pf_subnet);
+        e->addr_family = AF_INET6;
+        e->exclude = exclude;
+        e->rule.v6.network = in6addr_any;
+        e->rule.v6.netmask = in6addr_any;
         **next = e;
         *next = &e->next;
-        return true;
     }
+
+    return true;
 }
 
 static uint32_t
@@ -393,25 +593,37 @@ pf_cn_test_print(const char *prefix,
 }
 
 static void
-pf_addr_test_print(const char *prefix,
-                   const char *prefix2,
-                   const struct context *src,
-                   const struct mroute_addr *dest,
-                   const bool allow,
-                   const struct ipv4_subnet *rule)
+pf_addr_test_print(const char *prefix, const char *prefix2,
+                   const struct context *src, const struct mroute_addr *dest,
+                   const bool allow, const struct pf_subnet *subnet)
 {
     struct gc_arena gc = gc_new();
-    if (rule)
+    const char *network, *netmask;
+
+    if (subnet)
     {
+        switch (subnet->addr_family)
+        {
+            case AF_INET:
+                network = print_in_addr_t(subnet->rule.v4.network, 0, &gc);
+                netmask = print_in_addr_t(subnet->rule.v4.netmask, 0, &gc);
+                break;
+            case AF_INET6:
+                network = print_in6_addr(subnet->rule.v6.network, 0, &gc);
+                netmask = print_in6_addr(subnet->rule.v6.netmask, 0, &gc);
+                break;
+            default:
+                return;
+        }
+
+
         dmsg(D_PF_DEBUG, "PF: %s/%s %s %s %s rule=[%s/%s %s]",
              prefix,
              prefix2,
              tls_common_name(src->c2.tls_multi, false),
              mroute_addr_print_ex(dest, MAPF_SHOW_ARP, &gc),
-             drop_accept(allow),
-             print_in_addr_t(rule->network, 0, &gc),
-             print_in_addr_t(rule->netmask, 0, &gc),
-             drop_accept(!rule->exclude));
+             drop_accept(allow), network, netmask,
+             drop_accept(!subnet->exclude));
     }
     else
     {
@@ -496,35 +708,137 @@ pf_cn_test(struct pf_set *pfs, const struct tls_multi *tm, const int type, const
     return false;
 }
 
+/**
+ * Check if the IPv4 source address matches against the subnet rules
+ *
+ * @param src           the packet source IPv4 address
+ * @param dest          the packet destination IPv4 address
+ * @param prefix        logging prefix
+ */
 bool
-pf_addr_test_dowork(const struct context *src, const struct mroute_addr *dest, const char *prefix)
+pf_addr_v4_test_dowork(const struct context *src,
+                       const struct mroute_addr *dest, const char *prefix)
 {
+    const in_addr_t addr = in_addr_t_from_mroute_addr(dest);
     struct pf_set *pfs = src->c2.pf.pfs;
-    if (pfs && !pfs->kill)
+    const struct pf_subnet *se = pfs->sns.list;
+
+    while (se)
     {
-        const in_addr_t addr = in_addr_t_from_mroute_addr(dest);
-        const struct pf_subnet *se = pfs->sns.list;
-        while (se)
-        {
-            if ((addr & se->rule.netmask) == se->rule.network)
-            {
 #ifdef ENABLE_DEBUG
-                if (check_debug_level(D_PF_DEBUG))
-                {
-                    pf_addr_test_print("PF_ADDR_MATCH", prefix, src, dest, !se->rule.exclude, &se->rule);
-                }
+        if (check_debug_level(D_PF_DEBUG))
+        {
+            pf_addr_test_print("PF_ADDR_CHECK", prefix, src, dest, !se->exclude,
+                               se);
+        }
 #endif
-                return !se->rule.exclude;
+        if ((se->addr_family == AF_INET) &&
+            (addr & se->rule.v4.netmask) == se->rule.v4.network)
+        {
+#ifdef ENABLE_DEBUG
+            if (check_debug_level(D_PF_DEBUG))
+            {
+                pf_addr_test_print("PF_ADDR_MATCH", prefix, src, dest,
+                                   !se->exclude, se);
             }
-            se = se->next;
+#endif
+            return !se->exclude;
         }
+        se = se->next;
+    }
+#ifdef ENABLE_DEBUG
+    if (check_debug_level(D_PF_DEBUG))
+    {
+        pf_addr_test_print("PF_ADDR_DEFAULT", prefix, src, dest,
+                           pfs->sns.default_allow, NULL);
+    }
+#endif
+    return pfs->sns.default_allow;
+}
+
+/**
+ * Check if the IPv6 source address matches against the subnet rules
+ *
+ * @param src           the packet source IPv6 address
+ * @param dest          the packet destination IPv6 address
+ * @param prefix        logging prefix
+ */
+bool
+pf_addr_v6_test_dowork(const struct context *src,
+                       const struct mroute_addr *dest, const char *prefix)
+{
+    const struct in6_addr addr = in6_addr_from_mroute_addr(dest);
+    struct pf_set *pfs = src->c2.pf.pfs;
+    const struct pf_subnet *se = pfs->sns.list;
+
+    while (se)
+    {
 #ifdef ENABLE_DEBUG
         if (check_debug_level(D_PF_DEBUG))
         {
-            pf_addr_test_print("PF_ADDR_DEFAULT", prefix, src, dest, pfs->sns.default_allow, NULL);
+            pf_addr_test_print("PFv6_ADDR_CHECK", prefix, src, dest, !se->exclude,
+                               se);
         }
 #endif
-        return pfs->sns.default_allow;
+        if ((se->addr_family == AF_INET6)
+            && (pf_addr_v6_masked_eq(&addr, &se->rule.v6.network,
+                                     &se->rule.v6.netmask) == 0))
+        {
+#ifdef ENABLE_DEBUG
+            if (check_debug_level(D_PF_DEBUG))
+            {
+                pf_addr_test_print("PFv6_ADDR_MATCH", prefix, src, dest,
+                                   !se->exclude, se);
+            }
+#endif
+            return !se->exclude;
+        }
+        se = se->next;
+    }
+#ifdef ENABLE_DEBUG
+    if (check_debug_level(D_PF_DEBUG))
+    {
+        pf_addr_test_print("PFv6_ADDR_DEFAULT", prefix, src, dest,
+                           pfs->sns.default_allow, NULL);
+    }
+#endif
+    return pfs->sns.default_allow;
+}
+
+/**
+ * Check if the source address matches against the subnet rules (either IPv4
+ * or IPv6)
+ *
+ * @param src           the packet source address
+ * @param dest          the packet destination address
+ * @param prefix        logging prefix
+ */
+bool
+pf_addr_test_dowork(const struct context *src, const struct mroute_addr *dest,
+                    const char *prefix)
+{
+    struct pf_set *pfs = src->c2.pf.pfs;
+
+    if (pfs && !pfs->kill)
+    {
+        bool ret = true;
+
+        msg(D_PF_DEBUG, "PF: packet_type: %d", dest->type & MR_ADDR_MASK);
+        switch (dest->type & MR_ADDR_MASK)
+        {
+            case MR_ADDR_IPV4:
+                ret = pf_addr_v4_test_dowork(src, dest, prefix);
+                break;
+
+            case MR_ADDR_IPV6:
+                ret = pf_addr_v6_test_dowork(src, dest, prefix);
+                break;
+
+            default:
+                /* ignore non-IP traffic */
+                break;
+        }
+        return ret;
     }
     else
     {
@@ -534,8 +848,9 @@ pf_addr_test_dowork(const struct context *src, const struct mroute_addr *dest, c
             pf_addr_test_print("PF_ADDR_FAULT", prefix, src, dest, false, NULL);
         }
 #endif
-        return false;
     }
+
+    return false;
 }
 
 #ifdef PLUGIN_PF
@@ -691,10 +1006,20 @@ pf_subnet_set_print(const struct pf_subnet_set *s, const int lev)
 
         for (e = s->list; e != NULL; e = e->next)
         {
-            msg(lev, "   %s/%s %s",
-                print_in_addr_t(e->rule.network, 0, &gc),
-                print_in_addr_t(e->rule.netmask, 0, &gc),
-                drop_accept(!e->rule.exclude));
+            if (e->addr_family == AF_INET)
+            {
+                msg(lev, "   %s/%s %s",
+                    print_in_addr_t(e->rule.v4.network, 0, &gc),
+                    print_in_addr_t(e->rule.v4.netmask, 0, &gc),
+                    drop_accept(!e->exclude));
+            }
+            else
+            {
+                msg(lev, "   %s/%s %s",
+                    print_in6_addr(e->rule.v6.network, 0, &gc),
+                    print_in6_addr(e->rule.v6.netmask, 0, &gc),
+                    drop_accept(!e->exclude));
+            }
         }
     }
     gc_free(&gc);
diff --git a/src/openvpn/pf.h b/src/openvpn/pf.h
index b839fd2e..de21381f 100644
--- a/src/openvpn/pf.h
+++ b/src/openvpn/pf.h
@@ -34,14 +34,23 @@
 struct context;
 
 struct ipv4_subnet {
-    bool exclude;
     in_addr_t network;
     in_addr_t netmask;
 };
 
+struct ipv6_subnet {
+    struct in6_addr network;
+    struct in6_addr netmask;
+};
+
 struct pf_subnet {
     struct pf_subnet *next;
-    struct ipv4_subnet rule;
+    int addr_family;
+    bool exclude;
+    union {
+        struct ipv4_subnet v4;
+        struct ipv6_subnet v6;
+    } rule;
 };
 
 struct pf_subnet_set {
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 6414d6c9..91520c65 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -375,6 +375,29 @@ netbits_to_netmask(const int netbits)
     return mask;
 }
 
+/**
+ * Convert a netmask in the form of "netbits" to an actual bitmask
+ *
+ * @param netbits number of bits representing the netmask
+ */
+static inline struct in6_addr
+netbits_to_netmask_v6(const int netbits)
+{
+    struct in6_addr mask = {0};
+    int full = netbits / 8;
+    int rest = netbits % 8;
+
+    /* fill whole bytes first.. */
+    memset(&mask, 0xff, full);
+    if (rest != 0)
+    {
+        /* ..partly fill the last byte now */
+        mask.s6_addr[full] = (0xff00 >> rest);
+    }
+
+    return mask;
+}
+
 static inline bool
 route_list_vpn_gateway_needed(const struct route_list *rl)
 {
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 0fc91f21..c4f37b3b 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -564,6 +564,22 @@ openvpn_inet_aton(const char *dotted_quad, struct in_addr *addr)
     }
 }
 
+int
+openvpn_inet_aton_v6(const char *addr_str, struct in6_addr *addr)
+{
+    CLEAR (*addr);
+
+    if (inet_pton (AF_INET6, addr_str, addr) == 1)
+    {
+        return OIA_IP; /* good well formatted IPv6 */
+    }
+
+    if (string_class (addr_str, CC_XDIGIT|CC_COLON, 0))
+        return OIA_ERROR;    /* probably a badly formatted IPv6 addr */
+    else
+        return OIA_HOSTNAME; /* probably a hostname */
+}
+
 bool
 ip_addr_dotted_quad_safe(const char *dotted_quad)
 {
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 2d7f2187..2369956b 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -462,6 +462,15 @@ void link_socket_update_buffer_sizes(struct link_socket *ls, int rcvbuf, int snd
 #define OIA_ERROR     -1
 int openvpn_inet_aton(const char *dotted_quad, struct in_addr *addr);
 
+/**
+ * Convert an IPv6 from text notation to in6_addr. Error reporting is
+ * enhanced compared to the pure inet_pton.
+ *
+ * @param addr_str	the address in text form
+ * @param addr		pointer where the result has to be stored on success
+ */
+int openvpn_inet_aton_v6(const char *addr_str, struct in6_addr *addr);
+
 /* integrity validation on pulled options */
 bool ip_addr_dotted_quad_safe(const char *dotted_quad);
 
-- 
2.15.1


