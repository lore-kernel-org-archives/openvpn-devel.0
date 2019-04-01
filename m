From: Christopher Schenk <cschenk@...2502...>
Date: Mon,  1 Apr 2019 13:21:40 +0200
Message-Id: <20190401112140.13212-4-cschenk@...2502...>
In-Reply-To: <20190401112140.13212-1-cschenk@...2502...>
References: <20190329193805.GQ31008@...1296...>
 <20190401112140.13212-1-cschenk@...2502...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/4] Simplified if statements for better
 readability
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
 src/openvpn/tun.c | 58 ++++++++++++-----------------------------------
 1 file changed, 14 insertions(+), 44 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 9fe8444f..20e661a7 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -69,7 +69,7 @@ static void netsh_ifconfig(const struct tuntap_options *to,
                            const in_addr_t netmask,
                            const unsigned int flags);
 
-static void windows_set_mtu(const int iface_indey,
+static void windows_set_mtu(const int iface_index,
 								short family,
                                const int mtu);
 
@@ -213,7 +213,7 @@ do_set_mtu_service(const struct tuntap *tt, const short family, const int mtu)
 	ack_message_t ack;
 	struct gc_arena gc = gc_new();
 	HANDLE pipe = tt->options.msg_channel;
-
+	char *family_name = (family == AF_INET6) ? "IPv6" : "IPv4";
 	set_mtu_message_t mtu_msg = {
 		.header = {
 			msg_set_mtu,
@@ -230,31 +230,15 @@ do_set_mtu_service(const struct tuntap *tt, const short family, const int mtu)
 		goto out;
 	}
 
-	if (family == AF_INET)
+	if (ack.error_number != NO_ERROR)
 	{
-		if (ack.error_number != NO_ERROR)
-		{
-			msg(M_NONFATAL, "TUN: setting IPv4 mtu using service failed: %s [status=%u if_index=%d]",
-				strerror_win32(ack.error_number, &gc), ack.error_number, mtu_msg.iface.index);
-		}
-		else
-		{
-			msg(M_INFO, "IPv4 MTU set to %d on interface %d using service", mtu, mtu_msg.iface.index);
-			ret = true;
-		}
+		msg(M_NONFATAL, "TUN: setting %s mtu using service failed: %s [status=%u if_index=%d]",
+			family_name, strerror_win32(ack.error_number, &gc), ack.error_number, mtu_msg.iface.index);
 	}
-	else if (family == AF_INET6)
+	else
 	{
-		if (ack.error_number != NO_ERROR)
-		{
-			msg(M_NONFATAL, "TUN: setting IPv6 mtu using service failed: %s [status=%u if_index=%d]",
-				strerror_win32(ack.error_number, &gc), ack.error_number, mtu_msg.iface.index);
-		}
-		else
-		{
-			msg(M_INFO, "IPv6 MTU set to %d on interface %d using service", mtu, mtu_msg.iface.index);
-			ret = true;
-		}
+		msg(M_INFO, "%s MTU set to %d on interface %d using service", family_name, mtu, mtu_msg.iface.index);
+		ret = true;
 	}
 
 out:
@@ -5313,35 +5297,21 @@ windows_set_mtu(const int iface_index, const short family,
 	DWORD err = 0;
 	struct gc_arena gc = gc_new();
 	MIB_IPINTERFACE_ROW row;
+	char *family_name = (family == AF_INET6) ? "IPv6" : "IPv4";
 	InitializeIpInterfaceEntry(&row);
 	row.Family = family;
 	row.InterfaceIndex = iface_index;
 	row.NlMtu = mtu;
 
 	err = SetIpInterfaceEntry(&row);
-	if (family == AF_INET)
+	if (err != NO_ERROR)
 	{
-		if (err != NO_ERROR)
-		{
-			msg(M_WARN, "TUN: Setting IPv4 mtu failed: %s [status=%u if_index=%d]",
-				strerror_win32(err, &gc), err, iface_index);
-		}
-		else
-		{
-			msg(M_INFO, "Successfully set IPv4 mtu on interface %d", iface_index);
-		}
+		msg(M_WARN, "TUN: Setting %s mtu failed: %s [status=%u if_index=%d]",
+			family_name, strerror_win32(err, &gc), err, iface_index);
 	}
-	else if (family == AF_INET6)
+	else
 	{
-		if (err != NO_ERROR)
-		{
-			msg(M_WARN, "TUN: Setting IPv6 mtu failed: %s [status=%u if_index=%d]",
-				strerror_win32(err, &gc), err, iface_index);
-		}
-		else
-		{
-			msg(M_INFO, "Successfully set IPv6 mtu on interface %d", iface_index);
-		}
+		msg(M_INFO, "Successfully set %s mtu on interface %d", family_name, iface_index);
 	}
 }
 
-- 
2.21.0.windows.1


