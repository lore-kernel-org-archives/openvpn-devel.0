From: Gert Doering <gert@...1296...>
Date: Fri,  6 Aug 2021 13:01:14 +0200
Message-Id: <20210806110114.21722-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Make 2nd parameter to --ifconfig-ipv6 no
 longer mandatory.
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

--ifconfig-ipv6 takes two parameters, "local ipv6 address / netbits"
and "remote ipv6 address".

We only *need* a remote ipv6 address if we are in TAP mode, want to
install --route-ipv6 routes, and neither --route-ipv6-gateway is set
nor a gateway is included in the --route-ipv6 statement.

The documentation always implied "this is optional", but the option
checking code and init_tun() always mandated it, with no good reason.

Remove requirement, adjust help message.

NOTE: on SOLARIS, this is actually required for "ifconfig", so this
add a new #ifdef check to init_tun().  Sorry.

Reported-By: François Kooman <fkooman@...2318...>
Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/options.c | 27 +++++++++++++++++++--------
 src/openvpn/tun.c     | 15 ++++++++++-----
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7e146db9..149e17de 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -185,8 +185,8 @@ static const char usage_message[] =
     "                  addresses outside of the subnets used by either peer.\n"
     "                  TAP: configure device to use IP address l as a local\n"
     "                  endpoint and rn as a subnet mask.\n"
-    "--ifconfig-ipv6 l r : configure device to use IPv6 address l as local\n"
-    "                      endpoint (as a /64) and r as remote endpoint\n"
+    "--ifconfig-ipv6 l/nn [r] : configure device to use IPv6 address l as local\n"
+    "                      endpoint (as a /nn) and r as remote endpoint\n"
     "--ifconfig-noexec : Don't actually execute ifconfig/netsh command, instead\n"
     "                    pass --ifconfig parms by environment to scripts.\n"
     "--ifconfig-nowarn : Don't warn if the --ifconfig option on this side of the\n"
@@ -201,7 +201,7 @@ static const char usage_message[] =
     "                  Add IPv6 route to routing table after connection\n"
     "                  is established.  Multiple routes can be specified.\n"
     "                  gateway default: taken from --route-ipv6-gateway or 'remote'\n"
-    "                  in --ifconfig-ipv6\n"
+    "                  in --ifconfig-ipv6 (only required in TAP mode)\n"
     "--route-gateway gw|'dhcp' : Specify a default gateway for use with --route.\n"
     "--route-ipv6-gateway gw : Specify a default gateway for use with --route-ipv6.\n"
     "--route-metric m : Specify a default metric for use with --route.\n"
@@ -5600,13 +5600,12 @@ add_option(struct options *options,
             goto err;
         }
     }
-    else if (streq(p[0], "ifconfig-ipv6") && p[1] && p[2] && !p[3])
+    else if (streq(p[0], "ifconfig-ipv6") && p[1] && !p[3])
     {
         unsigned int netbits;
 
         VERIFY_PERMISSION(OPT_P_UP);
-        if (get_ipv6_addr( p[1], NULL, &netbits, msglevel )
-            && ipv6_addr_safe( p[2] ) )
+        if (get_ipv6_addr( p[1], NULL, &netbits, msglevel ))
         {
             if (netbits < 64 || netbits > 124)
             {
@@ -5616,13 +5615,25 @@ add_option(struct options *options,
 
             options->ifconfig_ipv6_local = get_ipv6_addr_no_netbits(p[1], &options->gc);
             options->ifconfig_ipv6_netbits = netbits;
-            options->ifconfig_ipv6_remote = p[2];
         }
         else
         {
-            msg(msglevel, "ifconfig-ipv6 parms '%s' and '%s' must be valid addresses", p[1], p[2]);
+            msg(msglevel, "ifconfig-ipv6 '%s' must be valid IPv6 address", p[1]);
             goto err;
         }
+
+        if (p[2])               /* "ipv6_remote" is optional */
+        {
+            if (ipv6_addr_safe(p[2]))
+            {
+                options->ifconfig_ipv6_remote = p[2];
+            }
+            else
+            {
+                msg(msglevel, "ifconfig-ipv6 '%s' must be valid IPv6 address", p[2]);
+                goto err;
+            }
+        }
     }
     else if (streq(p[0], "ifconfig-noexec") && !p[1])
     {
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 28f803ec..1002054b 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -852,17 +852,22 @@ init_tun(const char *dev,        /* --dev option */
         tt->did_ifconfig_setup = true;
     }
 
-    if (ifconfig_ipv6_local_parm && ifconfig_ipv6_remote_parm)
+    if (ifconfig_ipv6_local_parm)
     {
-
+#ifdef TARGET_SOLARIS
+        if (!ifconfig_ipv6_remote_parm ||
+            || inet_pton( AF_INET6, ifconfig_ipv6_remote_parm, &tt->remote_ipv6 ) != 1)
+        {
+            msg(M_FATAL, "init_tun: Solaris needs valid IPv6 address as second parameter to '--ifconfig-ipv6'");
+        }
+#endif
         /*
          * Convert arguments to binary IPv6 addresses.
          */
 
-        if (inet_pton( AF_INET6, ifconfig_ipv6_local_parm, &tt->local_ipv6 ) != 1
-            || inet_pton( AF_INET6, ifconfig_ipv6_remote_parm, &tt->remote_ipv6 ) != 1)
+        if (inet_pton( AF_INET6, ifconfig_ipv6_local_parm, &tt->local_ipv6 ) != 1)
         {
-            msg( M_FATAL, "init_tun: problem converting IPv6 ifconfig addresses %s and %s to binary", ifconfig_ipv6_local_parm, ifconfig_ipv6_remote_parm );
+            msg(M_FATAL, "init_tun: problem converting IPv6 ifconfig address %s to binary", ifconfig_ipv6_local_parm);
         }
         tt->netbits_ipv6 = ifconfig_ipv6_netbits_parm;
 
-- 
2.26.3


