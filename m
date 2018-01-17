From: Arne Schwabe <arne@...1227...>
Date: Wed, 17 Jan 2018 13:17:34 +0100
Message-Id: <1516191454-29034-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Treat dhcp-option DNS6 and DNS identical
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

OpenVPN3 accepts both IPv4 and IPv6 with option-dhcp DNS but throws
an error for option-dhcp DNS6.

This patch makes OpenVPN2 accept IPv4/IPv6 for both DNS and DNS6
---
 doc/openvpn.8         |  8 ++------
 src/openvpn/options.c | 33 ++++++++++++++++++---------------
 2 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 43bbc217..f9ccbb30 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -5886,14 +5886,10 @@ across the VPN.
 Set Connection\-specific DNS Suffix.
 
 .B DNS addr \-\-
-Set primary domain name server IPv4 address.  Repeat
+Set primary domain name server IPv4 or IPv6 address.  Repeat
 this option to set secondary DNS server addresses.
 
-.B DNS6 addr \-\-
-Set primary domain name server IPv6 address.  Repeat
-this option to set secondary DNS server IPv6 addresses.
-
-Note: currently this is handled using netsh (the
+Note: DNS IPv6 server are currently handled using netsh (the
 existing DHCP code can only do IPv4 DHCP, and that protocol only
 permits IPv4 addresses anywhere).  The option will be put into the
 environment, so an
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7c6528bc..48e6dbf6 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7088,6 +7088,7 @@ add_option(struct options *options,
     {
         struct tuntap_options *o = &options->tuntap_options;
         VERIFY_PERMISSION(OPT_P_IPWIN32);
+        bool ipv6dns = false;
 
         if (streq(p[1], "DOMAIN") && p[2])
         {
@@ -7108,22 +7109,24 @@ add_option(struct options *options,
             }
             o->netbios_node_type = t;
         }
-        else if (streq(p[1], "DNS") && p[2])
+        else if ((streq(p[1], "DNS") || streq(p[1], "DNS6")) && p[2] && (!strstr(p[2], ":") || ipv6_addr_safe(p[2])))
         {
-            dhcp_option_address_parse("DNS", p[2], o->dns, &o->dns_len, msglevel);
-        }
-        else if (streq(p[1], "DNS6") && p[2] && ipv6_addr_safe(p[2]))
-        {
-            struct in6_addr addr;
-            foreign_option(options, p, 3, es);
-            if (o->dns6_len >= N_DHCP_ADDR)
-            {
-                msg(msglevel, "--dhcp-option DNS6: maximum of %d dns servers can be specified",
-                    N_DHCP_ADDR);
-            }
-            else if (get_ipv6_addr(p[2], &addr, NULL, msglevel))
+            if (strstr(p[2], ":"))
             {
-                o->dns6[o->dns6_len++] = addr;
+                ipv6dns=true;
+                struct in6_addr addr;
+                foreign_option(options, p, 3, es);
+                if (o->dns6_len >= N_DHCP_ADDR)
+                {
+                    msg(msglevel, "--dhcp-option DNS: maximum of %d IPv6 dns servers can be specified",
+                        N_DHCP_ADDR);
+                }
+                else if (get_ipv6_addr(p[2], &addr, NULL, msglevel))
+                {
+                    o->dns6[o->dns6_len++] = addr;
+                }
+            } else {
+                dhcp_option_address_parse("DNS", p[2], o->dns, &o->dns_len, msglevel);
             }
         }
         else if (streq(p[1], "WINS") && p[2])
@@ -7151,7 +7154,7 @@ add_option(struct options *options,
         /* flag that we have options to give to the TAP driver's DHCPv4 server
          *  - skipped for "DNS6", as that's not a DHCPv4 option
          */
-        if (!streq(p[1], "DNS6"))
+        if (!ipv6dns)
         {
             o->dhcp_options = true;
         }
-- 
2.15.1


