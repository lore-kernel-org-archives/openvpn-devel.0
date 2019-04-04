From: Christopher Schenk <cschenk@...2502...>
Date: Thu,  4 Apr 2019 13:16:56 +0200
Message-Id: <20190404111656.14916-1-cschenk@...2502...>
In-Reply-To: <20190401204032.GH31008@...1296...>
References: <20190401204032.GH31008@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Set the correct mtu on windows based systems
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

Signed-off-by: Christopher Schenk <cschenk@...2502...>
---
 include/openvpn-msg.h         |  8 ++++
 src/openvpn/tun.c             | 89 +++++++++++++++++++++++++++++++++++
 src/openvpnserv/interactive.c | 31 ++++++++++++
 3 files changed, 128 insertions(+)

diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index 66177a21..10cd68ac 100644
--- a/include/openvpn-msg.h
+++ b/include/openvpn-msg.h
@@ -39,6 +39,7 @@ typedef enum {
     msg_del_block_dns,
     msg_register_dns,
     msg_enable_dhcp,
+    msg_set_mtu,
 } message_type_t;
 
 typedef struct {
@@ -117,4 +118,11 @@ typedef struct {
     interface_t iface;
 } enable_dhcp_message_t;
 
+typedef struct {
+    message_header_t header;
+    interface_t iface;
+    short family;
+    int mtu;
+} set_mtu_message_t;
+
 #endif /* ifndef OPENVPN_MSG_H_ */
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 48a8fdf7..3895e421 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -69,6 +69,10 @@ static void netsh_ifconfig(const struct tuntap_options *to,
                            const in_addr_t netmask,
                            const unsigned int flags);
 
+static void windows_set_mtu(const int iface_index,
+                            const short family,
+                            const int mtu);
+
 static void netsh_set_dns6_servers(const struct in6_addr *addr_list,
                                    const int addr_len,
                                    const char *flex_name);
@@ -201,6 +205,47 @@ out:
     return ret;
 }
 
+static bool
+do_set_mtu_service(const struct tuntap *tt, const short family, const int mtu)
+{
+    DWORD len;
+    bool ret = false;
+    ack_message_t ack;
+    struct gc_arena gc = gc_new();
+    HANDLE pipe = tt->options.msg_channel;
+    const char *family_name = (family == AF_INET6) ? "IPv6" : "IPv4";
+    set_mtu_message_t mtu_msg = {
+        .header = {
+            msg_set_mtu,
+            sizeof(set_mtu_message_t),
+            0
+        },
+        .iface = {.index = tt->adapter_index,.name = tt->actual_name },
+        .mtu = mtu,
+        .family = family
+    };
+
+    if (!send_msg_iservice(pipe, &mtu_msg, sizeof(mtu_msg), &ack, "Set_mtu"))
+    {
+        goto out;
+    }
+
+    if (ack.error_number != NO_ERROR)
+    {
+        msg(M_NONFATAL, "TUN: setting %s mtu using service failed: %s [status=%u if_index=%d]",
+            family_name, strerror_win32(ack.error_number, &gc), ack.error_number, mtu_msg.iface.index);
+    }
+    else
+    {
+        msg(M_INFO, "%s MTU set to %d on interface %d using service", family_name, mtu, mtu_msg.iface.index);
+        ret = true;
+    }
+
+out:
+    gc_free(&gc);
+    return ret;
+}
+
 #endif /* ifdef _WIN32 */
 
 #ifdef TARGET_SOLARIS
@@ -984,6 +1029,7 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
     {
         do_address_service(true, AF_INET6, tt);
         do_dns6_service(true, tt);
+        do_set_mtu_service(tt, AF_INET6, tun_mtu);
     }
     else
     {
@@ -1000,6 +1046,7 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
         netsh_command(&argv, 4, M_FATAL);
         /* set ipv6 dns servers if any are specified */
         netsh_set_dns6_servers(tt->options.dns6, tt->options.dns6_len, ifname);
+        windows_set_mtu(tt->adapter_index, AF_INET6, tun_mtu);
     }
 
     /* explicit route needed */
@@ -1394,6 +1441,14 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
 
                 break;
         }
+        if (tt->options.msg_channel)
+        {
+            do_set_mtu_service(tt, AF_INET, tun_mtu);
+        }
+        else
+        {
+            windows_set_mtu(tt->adapter_index, AF_INET, tun_mtu);
+        }
     }
 
 #else  /* if defined(TARGET_LINUX) */
@@ -5236,6 +5291,40 @@ out:
     return ret;
 }
 
+static void
+windows_set_mtu(const int iface_index, const short family,
+                const int mtu)
+{
+    DWORD err = 0;
+    struct gc_arena gc = gc_new();
+    MIB_IPINTERFACE_ROW ipiface;
+    InitializeIpInterfaceEntry(&ipiface);
+    const char *family_name = (family == AF_INET6) ? "IPv6" : "IPv4";
+    ipiface.Family = family;
+    ipiface.InterfaceIndex = iface_index;
+    err = GetIpInterfaceEntry(&ipiface);
+    if (err == NO_ERROR)
+    {
+        if (family == AF_INET)
+        {
+            ipiface.SitePrefixLength = 0;
+        }
+        ipiface.NlMtu = mtu;
+        err = SetIpInterfaceEntry(&ipiface);
+    }
+
+    if (err != NO_ERROR)
+    {
+        msg(M_WARN, "TUN: Setting %s mtu failed: %s [status=%u if_index=%d]",
+            family_name, strerror_win32(err, &gc), err, iface_index);
+    }
+    else
+    {
+        msg(M_INFO, "Successfully set %s mtu on interface %d", family_name, iface_index);
+    }
+}
+
+
 /*
  * Return a TAP name for netsh commands.
  */
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 623c3ff7..c24cb22b 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1198,6 +1198,29 @@ HandleEnableDHCPMessage(const enable_dhcp_message_t *dhcp)
     return err;
 }
 
+static DWORD
+HandleMTUMessage(const set_mtu_message_t *mtu)
+{
+    DWORD err = 0;
+    MIB_IPINTERFACE_ROW ipiface;
+    InitializeIpInterfaceEntry(&ipiface);
+    ipiface.Family = mtu->family;
+    ipiface.InterfaceIndex = mtu->iface.index;
+    err = GetIpInterfaceEntry(&ipiface);
+    if (err != NO_ERROR)
+    {
+        return err;
+    }
+    if (mtu->family == AF_INET)
+    {
+        ipiface.SitePrefixLength = 0;
+    }
+    ipiface.NlMtu = mtu->mtu;
+
+    err = SetIpInterfaceEntry(&ipiface);
+    return err;
+}
+
 static VOID
 HandleMessage(HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events, undo_lists_t *lists)
 {
@@ -1210,6 +1233,7 @@ HandleMessage(HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events, undo_lists
         block_dns_message_t block_dns;
         dns_cfg_message_t dns;
         enable_dhcp_message_t dhcp;
+        set_mtu_message_t mtu;
     } msg;
     ack_message_t ack = {
         .header = {
@@ -1277,6 +1301,13 @@ HandleMessage(HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events, undo_lists
             }
             break;
 
+        case msg_set_mtu:
+            if (msg.header.size == sizeof(msg.mtu))
+            {
+                ack.error_number = HandleMTUMessage(&msg.mtu);
+            }
+            break;
+
         default:
             ack.error_number = ERROR_MESSAGE_TYPE;
             MsgToEventLog(MSG_FLAGS_ERROR, TEXT("Unknown message type %d"), msg.header.type);
-- 
2.21.0.windows.1


