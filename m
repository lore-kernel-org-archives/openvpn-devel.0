From: Christopher Schenk <cschenk@...2502...>
Date: Mon,  1 Apr 2019 13:21:37 +0200
Message-Id: <20190401112140.13212-1-cschenk@...2502...>
In-Reply-To: <20190329193805.GQ31008@...1296...>
References: <20190329193805.GQ31008@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/4] Setting adapter mtu on windows systems
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
Cc: Christopher Schenk <Christopher.Schenk@...160...>

From: Christopher Schenk <Christopher.Schenk@...160...>

---
 src/openvpn/tun.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 48a8fdf7..93d028c8 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -69,6 +69,12 @@ static void netsh_ifconfig(const struct tuntap_options *to,
                            const in_addr_t netmask,
                            const unsigned int flags);
 
+static void netsh_set_mtu_ipv4(const char *flex_name,
+                               const int mtu);
+
+static void netsh_set_mtu_ipv6(const char *flex_name,
+                               const int mtu);
+
 static void netsh_set_dns6_servers(const struct in6_addr *addr_list,
                                    const int addr_len,
                                    const char *flex_name);
@@ -1000,6 +1006,7 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
         netsh_command(&argv, 4, M_FATAL);
         /* set ipv6 dns servers if any are specified */
         netsh_set_dns6_servers(tt->options.dns6, tt->options.dns6_len, ifname);
+        netsh_set_mtu_ipv6(ifname, tun_mtu);
     }
 
     /* explicit route needed */
@@ -1391,9 +1398,9 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
             case IPW32_SET_NETSH:
                 netsh_ifconfig(&tt->options, ifname, tt->local,
                                tt->adapter_netmask, NI_IP_NETMASK|NI_OPTIONS);
-
                 break;
         }
+		netsh_set_mtu_ipv4(ifname, tun_mtu);
     }
 
 #else  /* if defined(TARGET_LINUX) */
@@ -5236,6 +5243,36 @@ out:
     return ret;
 }
 
+static void
+netsh_set_mtu_ipv4(const char *flex_name,
+                   const int mtu)
+{
+	struct argv argv = argv_new();
+	argv_printf(&argv, "%s%sc interface ipv4 set subinterface %s mtu = %d store=active",
+		get_win_sys_path(),
+		NETSH_PATH_SUFFIX,
+		flex_name,
+		mtu);
+
+	netsh_command(&argv, 3, M_WARN);
+	argv_reset(&argv);
+}
+
+static void
+netsh_set_mtu_ipv6(const char *flex_name,
+	const int mtu)
+{
+	struct argv argv = argv_new();
+	argv_printf(&argv, "%s%sc interface ipv6 set subinterface %s mtu = %d store=active",
+		get_win_sys_path(),
+		NETSH_PATH_SUFFIX,
+		flex_name,
+		mtu);
+
+	netsh_command(&argv, 3, M_WARN);
+	argv_reset(&argv);
+}
+
 /*
  * Return a TAP name for netsh commands.
  */
-- 
2.21.0.windows.1


