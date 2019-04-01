From: Christopher Schenk <cschenk@...2502...>
Date: Mon,  1 Apr 2019 13:21:38 +0200
Message-Id: <20190401112140.13212-2-cschenk@...2502...>
In-Reply-To: <20190401112140.13212-1-cschenk@...2502...>
References: <20190329193805.GQ31008@...1296...>
 <20190401112140.13212-1-cschenk@...2502...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/4] Setting MTU also via interactive service
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
 include/openvpn-msg.h         |  8 +++++
 src/openvpn/tun.c             | 67 ++++++++++++++++++++++++++++++++++-
 src/openvpnserv/interactive.c | 50 ++++++++++++++++++++++++++
 3 files changed, 124 insertions(+), 1 deletion(-)

diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index 66177a21..f59c5a21 100644
--- a/include/openvpn-msg.h
+++ b/include/openvpn-msg.h
@@ -39,6 +39,7 @@ typedef enum {
     msg_del_block_dns,
     msg_register_dns,
     msg_enable_dhcp,
+	msg_set_mtu,
 } message_type_t;
 
 typedef struct {
@@ -117,4 +118,11 @@ typedef struct {
     interface_t iface;
 } enable_dhcp_message_t;
 
+typedef struct {
+	message_header_t header;
+	interface_t iface;
+	short family;
+	int mtu;
+} set_mtu_message_t;
+
 #endif /* ifndef OPENVPN_MSG_H_ */
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 93d028c8..b0230a7c 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -207,6 +207,63 @@ out:
     return ret;
 }
 
+static bool
+do_set_mtu_service(const struct tuntap *tt, const short family, const int mtu)
+{
+	DWORD len;
+	bool ret = false;
+	ack_message_t ack;
+	struct gc_arena gc = gc_new();
+	HANDLE pipe = tt->options.msg_channel;
+
+	set_mtu_message_t mtu_msg = {
+		.header = {
+			msg_set_mtu,
+			sizeof(set_mtu_message_t),
+			0
+		},
+		.iface = {.index = tt->adapter_index,.name = tt->actual_name },
+		.mtu = mtu,
+		.family = family
+	};
+
+	if (!send_msg_iservice(pipe, &mtu_msg, sizeof(mtu_msg), &ack, "Set_mtu"))
+	{
+		goto out;
+	}
+
+	if (family == AF_INET)
+	{
+		if (ack.error_number != NO_ERROR)
+		{
+			msg(M_NONFATAL, "TUN: setting IPv4 mtu using service failed: %s [status=%u if_index=%d]",
+				strerror_win32(ack.error_number, &gc), ack.error_number, mtu_msg.iface.index);
+		}
+		else
+		{
+			msg(M_INFO, "IPv4 MTU set to %d on interface %d using service", mtu, mtu_msg.iface.index);
+			ret = true;
+		}
+	}
+	else if (family == AF_INET6)
+	{
+		if (ack.error_number != NO_ERROR)
+		{
+			msg(M_NONFATAL, "TUN: setting IPv6 mtu using service failed: %s [status=%u if_index=%d]",
+				strerror_win32(ack.error_number, &gc), ack.error_number, mtu_msg.iface.index);
+		}
+		else
+		{
+			msg(M_INFO, "IPv6 MTU set to %d on interface %d using service", mtu, mtu_msg.iface.index);
+			ret = true;
+		}
+	}
+
+out:
+	gc_free(&gc);
+	return ret;
+}
+
 #endif /* ifdef _WIN32 */
 
 #ifdef TARGET_SOLARIS
@@ -990,6 +1047,7 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
     {
         do_address_service(true, AF_INET6, tt);
         do_dns6_service(true, tt);
+		do_set_mtu_service(tt, AF_INET6, tun_mtu);
     }
     else
     {
@@ -1400,7 +1458,14 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
                                tt->adapter_netmask, NI_IP_NETMASK|NI_OPTIONS);
                 break;
         }
-		netsh_set_mtu_ipv4(ifname, tun_mtu);
+		if (tt->options.msg_channel)
+		{
+			do_set_mtu_service(tt, AF_INET, tun_mtu);
+		}
+		else
+		{
+			netsh_set_mtu_ipv4(ifname, tun_mtu);
+		}
     }
 
 #else  /* if defined(TARGET_LINUX) */
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 623c3ff7..31e4afa0 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1198,6 +1198,49 @@ HandleEnableDHCPMessage(const enable_dhcp_message_t *dhcp)
     return err;
 }
 
+static DWORD
+HandleMTUMessage(const set_mtu_message_t *mtu)
+{
+	DWORD err = 0;
+	DWORD timeout = 5000; /* in milli seconds */
+	wchar_t argv0[MAX_PATH];
+
+	/* Path of netsh */
+	swprintf(argv0, _countof(argv0), L"%s\\%s", get_win_sys_path(), L"netsh.exe");
+	argv0[_countof(argv0) - 1] = L'\0';
+
+	/* cmd template:
+	 * netsh interface $family set subinterface "$if_name" mtu=$mtu
+	 */
+	const wchar_t *fmt;
+	if (mtu->family == AF_INET)
+	{
+		fmt = L"netsh interface ipv4 set subinterface \"%d\" mtu= %d";
+	}
+	else if (mtu->family == AF_INET6)
+	{
+		fmt = L"netsh interface ipv6 set subinterface \"%d\" mtu= %d";
+	}
+
+	/* max cmdline length in wchars -- include room for if index:
+	 * 20 chars for two 32 bit int in decimal and +1 for NUL
+	 */
+	size_t ncmdline = wcslen(fmt) + 20 + 1;
+	wchar_t *cmdline = malloc(ncmdline * sizeof(wchar_t));
+	if (!cmdline)
+	{
+		err = ERROR_OUTOFMEMORY;
+		return err;
+	}
+
+	openvpn_sntprintf(cmdline, ncmdline, fmt, mtu->iface.index, mtu->mtu);
+
+	err = ExecCommand(argv0, cmdline, timeout);
+
+	free(cmdline);
+	return err;
+}
+
 static VOID
 HandleMessage(HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events, undo_lists_t *lists)
 {
@@ -1210,6 +1253,7 @@ HandleMessage(HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events, undo_lists
         block_dns_message_t block_dns;
         dns_cfg_message_t dns;
         enable_dhcp_message_t dhcp;
+		set_mtu_message_t mtu;
     } msg;
     ack_message_t ack = {
         .header = {
@@ -1276,6 +1320,12 @@ HandleMessage(HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events, undo_lists
                 ack.error_number = HandleEnableDHCPMessage(&msg.dhcp);
             }
             break;
+		case msg_set_mtu:
+			if (msg.header.size == sizeof(msg.mtu))
+			{
+				ack.error_number = HandleMTUMessage(&msg.mtu);
+			}
+			break;
 
         default:
             ack.error_number = ERROR_MESSAGE_TYPE;
-- 
2.21.0.windows.1


