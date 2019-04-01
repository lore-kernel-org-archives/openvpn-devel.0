From: Christopher Schenk <cschenk@...2502...>
Date: Mon,  1 Apr 2019 13:21:39 +0200
Message-Id: <20190401112140.13212-3-cschenk@...2502...>
In-Reply-To: <20190401112140.13212-1-cschenk@...2502...>
References: <20190329193805.GQ31008@...1296...>
 <20190401112140.13212-1-cschenk@...2502...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/4] Use netioapi instead of netsh to set mtu
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

---
 src/openvpn/tun.c             | 68 +++++++++++++++++++----------------
 src/openvpnserv/interactive.c | 44 +++++------------------
 2 files changed, 46 insertions(+), 66 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index b0230a7c..9fe8444f 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -69,10 +69,8 @@ static void netsh_ifconfig(const struct tuntap_options *to,
                            const in_addr_t netmask,
                            const unsigned int flags);
 
-static void netsh_set_mtu_ipv4(const char *flex_name,
-                               const int mtu);
-
-static void netsh_set_mtu_ipv6(const char *flex_name,
+static void windows_set_mtu(const int iface_indey,
+								short family,
                                const int mtu);
 
 static void netsh_set_dns6_servers(const struct in6_addr *addr_list,
@@ -1064,7 +1062,7 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
         netsh_command(&argv, 4, M_FATAL);
         /* set ipv6 dns servers if any are specified */
         netsh_set_dns6_servers(tt->options.dns6, tt->options.dns6_len, ifname);
-        netsh_set_mtu_ipv6(ifname, tun_mtu);
+		windows_set_mtu(tt->adapter_index, AF_INET6, tun_mtu);
     }
 
     /* explicit route needed */
@@ -1464,7 +1462,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
 		}
 		else
 		{
-			netsh_set_mtu_ipv4(ifname, tun_mtu);
+			windows_set_mtu(tt->adapter_index, AF_INET, tun_mtu);
 		}
     }
 
@@ -5309,35 +5307,45 @@ out:
 }
 
 static void
-netsh_set_mtu_ipv4(const char *flex_name,
-                   const int mtu)
-{
-	struct argv argv = argv_new();
-	argv_printf(&argv, "%s%sc interface ipv4 set subinterface %s mtu = %d store=active",
-		get_win_sys_path(),
-		NETSH_PATH_SUFFIX,
-		flex_name,
-		mtu);
-
-	netsh_command(&argv, 3, M_WARN);
-	argv_reset(&argv);
-}
-
-static void
-netsh_set_mtu_ipv6(const char *flex_name,
+windows_set_mtu(const int iface_index, const short family,
 	const int mtu)
 {
-	struct argv argv = argv_new();
-	argv_printf(&argv, "%s%sc interface ipv6 set subinterface %s mtu = %d store=active",
-		get_win_sys_path(),
-		NETSH_PATH_SUFFIX,
-		flex_name,
-		mtu);
+	DWORD err = 0;
+	struct gc_arena gc = gc_new();
+	MIB_IPINTERFACE_ROW row;
+	InitializeIpInterfaceEntry(&row);
+	row.Family = family;
+	row.InterfaceIndex = iface_index;
+	row.NlMtu = mtu;
 
-	netsh_command(&argv, 3, M_WARN);
-	argv_reset(&argv);
+	err = SetIpInterfaceEntry(&row);
+	if (family == AF_INET)
+	{
+		if (err != NO_ERROR)
+		{
+			msg(M_WARN, "TUN: Setting IPv4 mtu failed: %s [status=%u if_index=%d]",
+				strerror_win32(err, &gc), err, iface_index);
+		}
+		else
+		{
+			msg(M_INFO, "Successfully set IPv4 mtu on interface %d", iface_index);
+		}
+	}
+	else if (family == AF_INET6)
+	{
+		if (err != NO_ERROR)
+		{
+			msg(M_WARN, "TUN: Setting IPv6 mtu failed: %s [status=%u if_index=%d]",
+				strerror_win32(err, &gc), err, iface_index);
+		}
+		else
+		{
+			msg(M_INFO, "Successfully set IPv6 mtu on interface %d", iface_index);
+		}
+	}
 }
 
+
 /*
  * Return a TAP name for netsh commands.
  */
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 31e4afa0..6e6a63fe 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -33,6 +33,7 @@
 #include <sddl.h>
 #include <shellapi.h>
 #include <mstcpip.h>
+#include <netioapi.h>
 
 #ifdef HAVE_VERSIONHELPERS_H
 #include <versionhelpers.h>
@@ -1202,42 +1203,13 @@ static DWORD
 HandleMTUMessage(const set_mtu_message_t *mtu)
 {
 	DWORD err = 0;
-	DWORD timeout = 5000; /* in milli seconds */
-	wchar_t argv0[MAX_PATH];
-
-	/* Path of netsh */
-	swprintf(argv0, _countof(argv0), L"%s\\%s", get_win_sys_path(), L"netsh.exe");
-	argv0[_countof(argv0) - 1] = L'\0';
-
-	/* cmd template:
-	 * netsh interface $family set subinterface "$if_name" mtu=$mtu
-	 */
-	const wchar_t *fmt;
-	if (mtu->family == AF_INET)
-	{
-		fmt = L"netsh interface ipv4 set subinterface \"%d\" mtu= %d";
-	}
-	else if (mtu->family == AF_INET6)
-	{
-		fmt = L"netsh interface ipv6 set subinterface \"%d\" mtu= %d";
-	}
-
-	/* max cmdline length in wchars -- include room for if index:
-	 * 20 chars for two 32 bit int in decimal and +1 for NUL
-	 */
-	size_t ncmdline = wcslen(fmt) + 20 + 1;
-	wchar_t *cmdline = malloc(ncmdline * sizeof(wchar_t));
-	if (!cmdline)
-	{
-		err = ERROR_OUTOFMEMORY;
-		return err;
-	}
-
-	openvpn_sntprintf(cmdline, ncmdline, fmt, mtu->iface.index, mtu->mtu);
-
-	err = ExecCommand(argv0, cmdline, timeout);
-
-	free(cmdline);
+	MIB_IPINTERFACE_ROW row;
+	InitializeIpInterfaceEntry(&row);
+	row.Family = mtu->family;
+	row.InterfaceIndex = mtu->iface.index;
+	row.NlMtu = mtu->mtu;
+
+	err = SetIpInterfaceEntry(&row);
 	return err;
 }
 
-- 
2.21.0.windows.1


