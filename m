From: Gert Doering <gert@...1296...>
Date: Sun,  1 Apr 2018 08:30:58 +0200
Message-Id: <20180401063058.23913-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Depreciate IPv4-related options.
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

As discussed in trac #208 and on IRC with Antonio, OpenVPN 2.5 will
be IPv6-only.  Removal of IPv4-related code and options will dramatically
reduce code complexity, confusing options, bugs and user questions.

Add deprecation warnings for IPv4-related config options to 2.4 branch,
so users have enough time to move their setups to work on IPv6-only
before 2.5 will be released.

This affects:

  --ifconfig
  --route
  --server
  --proto udp4/tcp4
  --ifconfig-pool

More IPv4-related options will be identified and depreciated later.

Trac: #208

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/options.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9fef3945..46d33c0b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5258,6 +5258,7 @@ add_option(struct options *options,
             msg(msglevel, "ifconfig parms '%s' and '%s' must be valid addresses", p[1], p[2]);
             goto err;
         }
+        msg(M_WARN, "DEPRECATED OPTION: --ifconfig, please update your configuration to use IPv6 (--ifconfig-ipv6). IPv4 support will be removed in OpenVPN v2.5.");
     }
     else if (streq(p[0], "ifconfig-ipv6") && p[1] && p[2] && !p[3])
     {
@@ -5928,6 +5929,10 @@ add_option(struct options *options,
         }
         options->ce.proto = proto;
         options->ce.af = af;
+	if (af == AF_INET)
+        {
+            msg(M_WARN, "DEPRECATED OPTION: --proto %s, please update your configuration to use IPv6. IPv4 support will be removed in OpenVPN v2.5.", p[1]);
+        }
     }
     else if (streq(p[0], "proto-force") && p[1] && !p[2])
     {
@@ -6151,6 +6156,7 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "route") && p[1] && !p[5])
     {
+	static int route_warning_printed = 0;
         VERIFY_PERMISSION(OPT_P_ROUTE);
         rol_check_alloc(options);
         if (pull_mode)
@@ -6172,6 +6178,10 @@ add_option(struct options *options,
             }
         }
         add_route_to_option_list(options->routes, p[1], p[2], p[3], p[4]);
+        if (route_warning_printed++ < 1)
+        {
+            msg(M_WARN, "DEPRECATED OPTION: --route, please update your configuration to use IPv6 (--route-ipv6). IPv4 support will be removed in OpenVPN v2.5.");
+        }
     }
     else if (streq(p[0], "route-ipv6") && p[1] && !p[4])
     {
@@ -6459,6 +6469,7 @@ add_option(struct options *options,
                 goto err;
             }
         }
+        msg(M_WARN, "DEPRECATED OPTION: --server, please update your configuration to use IPv6 (--server-ipv6). IPv4 support will be removed in OpenVPN v2.5.");
     }
     else if (streq(p[0], "server-ipv6") && p[1] && !p[3])
     {
@@ -6566,6 +6577,7 @@ add_option(struct options *options,
         {
             options->ifconfig_pool_netmask = netmask;
         }
+        msg(M_WARN, "DEPRECATED OPTION: --ifconfig-pool, please update your configuration to use IPv6 (--ifconfig-ipv6-pool). IPv4 support will be removed in OpenVPN v2.5.");
     }
     else if (streq(p[0], "ifconfig-pool-persist") && p[1] && !p[3])
     {
-- 
2.16.1


