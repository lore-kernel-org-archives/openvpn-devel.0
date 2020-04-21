From: Christopher Schenk <cschenk@...2502...>
Date: Tue, 21 Apr 2020 17:46:12 +0200
Message-Id: <20200421154612.14140-1-cschenk@...2502...>
In-Reply-To: <20200415182738.GL1431@...1296...>
References: <20200415182738.GL1431@...1296...>
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
 include/openvpn-msg.h         | 10 +++-
 src/openvpn/tun.c             | 89 +++++++++++++++++++++++++++++++++++
 src/openvpnserv/interactive.c | 31 ++++++++++++
 3 files changed, 129 insertions(+), 1 deletion(-)

diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index 3ed62069..a4789e34 100644
--- a/include/openvpn-msg.h
+++ b/include/openvpn-msg.h
@@ -39,7 +39,8 @@ typedef enum {
     msg_del_block_dns,
     msg_register_dns,
     msg_enable_dhcp,
-    msg_register_ring_buffers
+    msg_register_ring_buffers,
+    msg_set_mtu
 } message_type_t;
 
 typedef struct {
@@ -127,4 +128,11 @@ typedef struct {
     HANDLE receive_tail_moved;
 } register_ring_buffers_message_t;
 
+typedef struct {
+    message_header_t header;
+    interface_t iface;
+    short family;
+    int mtu;
+} set_mtu_message_t;
+
 #endif /* ifndef OPENVPN_MSG_H_ */
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 8e692977..0e6dfe72 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -73,6 +73,10 @@ static void netsh_ifconfig(const struct tuntap_options *to,
                            const in_addr_t netmask,
                            const unsigned int flags);
 
+static void windows_set_mtu(const int iface_index,
+                            const short family,
+                            const int mtu);
+
 static void netsh_set_dns6_servers(const struct in6_addr *addr_list,
                                    const int addr_len,
                                    const char *flex_name);
@@ -214,6 +218,47 @@ out:
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
@@ -1018,6 +1063,7 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
         do_address_service(true, AF_INET6, tt);
         add_route_connected_v6_net(tt, es);
         do_dns_service(true, AF_INET6, tt);
+        do_set_mtu_service(tt, AF_INET6, tun_mtu);
     }
     else
     {
@@ -1035,6 +1081,7 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
         add_route_connected_v6_net(tt, es);
         /* set ipv6 dns servers if any are specified */
         netsh_set_dns6_servers(tt->options.dns6, tt->options.dns6_len, ifname);
+        windows_set_mtu(tt->adapter_index, AF_INET6, tun_mtu);
     }
 #else /* platforms we have no IPv6 code for */
     msg(M_FATAL, "Sorry, but I don't know how to do IPv6 'ifconfig' commands on this operating system.  You should ifconfig your TUN/TAP device manually or use an --up script.");
@@ -1404,6 +1451,14 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
         netsh_ifconfig(&tt->options, ifname, tt->local,
                        tt->adapter_netmask, NI_IP_NETMASK|NI_OPTIONS);
     }
+    if (tt->options.msg_channel)
+    {
+        do_set_mtu_service(tt, AF_INET, tun_mtu);
+    }
+    else
+    {
+        windows_set_mtu(tt->adapter_index, AF_INET, tun_mtu);
+    }
 #else  /* if defined(TARGET_LINUX) */
     msg(M_FATAL, "Sorry, but I don't know how to do 'ifconfig' commands on this operating system.  You should ifconfig your TUN/TAP device manually or use an --up script.");
 #endif /* if defined(TARGET_LINUX) */
@@ -5432,6 +5487,40 @@ out:
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
index 04d64b97..207cc4ae 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1286,6 +1286,29 @@ HandleRegisterRingBuffers(const register_ring_buffers_message_t *rrb, HANDLE ovp
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
 HandleMessage(HANDLE pipe, HANDLE ovpn_proc, ring_buffer_handles_t *ring_buffer_handles,
               DWORD bytes, DWORD count, LPHANDLE events, undo_lists_t *lists)
@@ -1300,6 +1323,7 @@ HandleMessage(HANDLE pipe, HANDLE ovpn_proc, ring_buffer_handles_t *ring_buffer_
         dns_cfg_message_t dns;
         enable_dhcp_message_t dhcp;
         register_ring_buffers_message_t rrb;
+        set_mtu_message_t mtu;
     } msg;
     ack_message_t ack = {
         .header = {
@@ -1374,6 +1398,13 @@ HandleMessage(HANDLE pipe, HANDLE ovpn_proc, ring_buffer_handles_t *ring_buffer_
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


