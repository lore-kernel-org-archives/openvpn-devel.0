From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 28 Jul 2023 16:12:46 +0300
Message-Id: <20230728131246.694-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Set WINS servers via interactice service
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

At the moments WINS servers are set either:

 - via DHCP, which works only for tap-windows6 driver
 - via netsh when running without interactice service

This means that in 2.6 default setup (interactive service and dco)
WINS is silently ignored.

Add WINS support for non-DHCP drivers (like dco) by passing
WINS settings to interactive service and set them there with
netsh call, similar approach as we use for setting DNS.

Fixes https://github.com/OpenVPN/openvpn/issues/373

Change-Id: I47c22dcb728011dcedaae47cd03a57219e9c7607
Signed-off-by: Lev Stipakov <lev@...515...>
---
 include/openvpn-msg.h         |  11 ++-
 src/openvpn/tun.c             |  68 ++++++++++++++
 src/openvpnserv/interactive.c | 162 ++++++++++++++++++++++++++++++++++
 3 files changed, 240 insertions(+), 1 deletion(-)

diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index 8cd26319..a1464cd1 100644
--- a/include/openvpn-msg.h
+++ b/include/openvpn-msg.h
@@ -40,7 +40,9 @@ typedef enum {
     msg_register_dns,
     msg_enable_dhcp,
     msg_register_ring_buffers,
-    msg_set_mtu
+    msg_set_mtu,
+    msg_add_wins_cfg,
+    msg_del_wins_cfg
 } message_type_t;
 
 typedef struct {
@@ -86,6 +88,13 @@ typedef struct {
     inet_address_t addr[4]; /* support up to 4 dns addresses */
 } dns_cfg_message_t;
 
+typedef struct {
+    message_header_t header;
+    interface_t iface;
+    int addr_len;
+    inet_address_t addr[4]; /* support up to 4 dns addresses */
+} wins_cfg_message_t;
+
 typedef struct {
     message_header_t header;
     interface_t iface;
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index d1fd6def..00e01d40 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -279,6 +279,72 @@ out:
     return ret;
 }
 
+static bool
+do_wins_service(bool add, const struct tuntap *tt)
+{
+    bool ret = false;
+    ack_message_t ack;
+    struct gc_arena gc = gc_new();
+    HANDLE pipe = tt->options.msg_channel;
+    int len = tt->options.wins_len;
+    int addr_len = add ? len : 0;
+
+    if (addr_len == 0 && add) /* no addresses to add */
+    {
+        return true;
+    }
+
+    wins_cfg_message_t wins = {
+        .header = {
+            (add ? msg_add_wins_cfg : msg_del_wins_cfg),
+            sizeof(wins_cfg_message_t),
+            0
+        },
+        .iface = {.index = tt->adapter_index, .name = "" },
+        .addr_len = addr_len
+    };
+
+    /* interface name is required */
+    strncpy(wins.iface.name, tt->actual_name, sizeof(wins.iface.name));
+    wins.iface.name[sizeof(wins.iface.name) - 1] = '\0';
+
+    if (addr_len > _countof(wins.addr))
+    {
+        addr_len = _countof(wins.addr);
+        wins.addr_len = addr_len;
+        msg(M_WARN, "Number of WINS addresses sent to service truncated to %d",
+            addr_len);
+    }
+
+    for (int i = 0; i < addr_len; ++i)
+    {
+        wins.addr[i].ipv4.s_addr = htonl(tt->options.wins[i]);
+    }
+
+    msg(D_LOW, "%s WINS servers on '%s' (if_index = %d) using service",
+        (add ? "Setting" : "Deleting"), wins.iface.name, wins.iface.index);
+
+    if (!send_msg_iservice(pipe, &wins, sizeof(wins), &ack, "TUN"))
+    {
+        goto out;
+    }
+
+    if (ack.error_number != NO_ERROR)
+    {
+        msg(M_WARN, "TUN: %s WINS failed using service: %s [status=%u if_name=%s]",
+            (add ? "adding" : "deleting"), strerror_win32(ack.error_number, &gc),
+            ack.error_number, wins.iface.name);
+        goto out;
+    }
+
+    msg(M_INFO, "WINS servers %s using service", (add ? "set" : "deleted"));
+    ret = true;
+
+out:
+    gc_free(&gc);
+    return ret;
+}
+
 static bool
 do_set_mtu_service(const struct tuntap *tt, const short family, const int mtu)
 {
@@ -1555,6 +1621,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
         do_address_service(true, AF_INET, tt);
         do_dns_service(true, AF_INET, tt);
         do_dns_domain_service(true, tt);
+        do_wins_service(true, tt);
     }
     else
     {
@@ -6977,6 +7044,7 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
         }
         else if (tt->options.msg_channel)
         {
+            do_wins_service(false, tt);
             do_dns_domain_service(false, tt);
             do_dns_service(false, AF_INET, tt);
             do_address_service(false, AF_INET, tt);
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index d73cef04..6c54e62b 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -93,6 +93,7 @@ typedef enum {
     undo_dns6,
     undo_domain,
     undo_ring_buffer,
+    undo_wins,
     _undo_type_max
 } undo_type_t;
 typedef list_item_t *undo_lists_t[_undo_type_max];
@@ -1083,6 +1084,63 @@ out:
     return err;
 }
 
+/**
+ * Run the command: netsh interface ip $action wins $if_name [static] $addr
+ * @param  action      "delete" or "add"
+ * @param  if_name     "name_of_interface"
+ * @param  addr        IPv4 address as a string
+ *
+ * If addr is null and action = "delete" all addresses are deleted.
+ * if action = "set" then "static" is added before $addr
+ */
+static DWORD
+netsh_wins_cmd(const wchar_t *action, const wchar_t *if_name, const wchar_t *addr)
+{
+    DWORD err = 0;
+    int timeout = 30000; /* in msec */
+    wchar_t argv0[MAX_PATH];
+    wchar_t *cmdline = NULL;
+    bool add = wcscmp(action, L"set") == 0;
+    const wchar_t *addr_static = add ? L"static" : L"";
+
+    if (!addr)
+    {
+        if (!add)
+        {
+            addr = L"all";
+        }
+        else /* nothing to do -- return success*/
+        {
+            goto out;
+        }
+    }
+
+    /* Path of netsh */
+    openvpn_swprintf(argv0, _countof(argv0), L"%ls\\%ls", get_win_sys_path(), L"netsh.exe");
+
+    /* cmd template:
+     * netsh interface ip $action wins $if_name $static $addr
+     */
+    const wchar_t *fmt = L"netsh interface ip %ls wins \"%ls\" %ls %ls";
+
+    /* max cmdline length in wchars -- include room for worst case and some */
+    size_t ncmdline = wcslen(fmt) + wcslen(if_name) + wcslen(addr) + wcslen(addr_static) + 32 + 1;
+    cmdline = malloc(ncmdline * sizeof(wchar_t));
+    if (!cmdline)
+    {
+        err = ERROR_OUTOFMEMORY;
+        goto out;
+    }
+
+    openvpn_swprintf(cmdline, ncmdline, fmt, action, if_name, addr_static, addr);
+
+    err = ExecCommand(argv0, cmdline, timeout);
+
+out:
+    free(cmdline);
+    return err;
+}
+
 /**
  * Run command: wmic nicconfig (InterfaceIndex=$if_index) call $action ($data)
  * @param  if_index    "index of interface"
@@ -1129,6 +1187,20 @@ wmic_nicconfig_cmd(const wchar_t *action, const NET_IFINDEX if_index,
     return err;
 }
 
+/* Delete all WINS servers for an interface */
+static DWORD
+DeleteWINS(wchar_t *if_name)
+{
+    return netsh_wins_cmd(L"delete", if_name, NULL);
+}
+
+/* Add WINS server to an interface */
+static DWORD
+AddWINS(wchar_t *if_name, wchar_t *addr)
+{
+    return netsh_wins_cmd(L"set", if_name, addr);
+}
+
 /* Delete all IPv4 or IPv6 dns servers for an interface */
 static DWORD
 DeleteDNS(short family, wchar_t *if_name)
@@ -1298,6 +1370,86 @@ out:
     return err;
 }
 
+static DWORD
+HandleWINSConfigMessage(const wins_cfg_message_t *msg, undo_lists_t *lists)
+{
+    DWORD err = 0;
+    wchar_t addr[16]; /* large enough to hold string representation of an ipv4 */
+    int addr_len = msg->addr_len;
+
+    /* sanity check */
+    if (addr_len > _countof(msg->addr))
+    {
+        addr_len = _countof(msg->addr);
+    }
+
+    if (!msg->iface.name[0]) /* interface name is required */
+    {
+        return ERROR_MESSAGE_DATA;
+    }
+
+    /* use a non-const reference with limited scope to enforce null-termination of strings from client */
+    {
+        wins_cfg_message_t *msgptr = (wins_cfg_message_t *)msg;
+        msgptr->iface.name[_countof(msg->iface.name) - 1] = '\0';
+    }
+
+    wchar_t *wide_name = utf8to16(msg->iface.name); /* utf8 to wide-char */
+    if (!wide_name)
+    {
+        return ERROR_OUTOFMEMORY;
+    }
+
+    /* We delete all current addresses before adding any
+     * OR if the message type is del_wins_cfg
+     */
+    if (addr_len > 0 || msg->header.type == msg_del_wins_cfg)
+    {
+        err = DeleteWINS(wide_name);
+        if (err)
+        {
+            goto out;
+        }
+        free(RemoveListItem(&(*lists)[undo_wins], CmpWString, wide_name));
+    }
+
+    if (msg->header.type == msg_del_wins_cfg)
+    {
+        goto out;  /* job done */
+    }
+
+    for (int i = 0; i < addr_len; ++i)
+    {
+        RtlIpv4AddressToStringW(&msg->addr[i].ipv4, addr);
+        err = AddWINS(wide_name, addr);
+        if (i == 0 && err)
+        {
+            goto out;
+        }
+        /* We do not check for duplicate addresses, so any error in adding
+         * additional addresses is ignored.
+         */
+    }
+
+    err = 0;
+
+    if (msg->addr_len > 0)
+    {
+        wchar_t *tmp_name = _wcsdup(wide_name);
+        if (!tmp_name || AddListItem(&(*lists)[undo_wins], tmp_name))
+        {
+            free(tmp_name);
+            DeleteWINS(wide_name);
+            err = ERROR_OUTOFMEMORY;
+            goto out;
+        }
+    }
+
+out:
+    free(wide_name);
+    return err;
+}
+
 static DWORD
 HandleEnableDHCPMessage(const enable_dhcp_message_t *dhcp)
 {
@@ -1487,6 +1639,7 @@ HandleMessage(HANDLE pipe, HANDLE ovpn_proc,
         enable_dhcp_message_t dhcp;
         register_ring_buffers_message_t rrb;
         set_mtu_message_t mtu;
+        wins_cfg_message_t wins;
     } msg;
     ack_message_t ack = {
         .header = {
@@ -1547,6 +1700,11 @@ HandleMessage(HANDLE pipe, HANDLE ovpn_proc,
             ack.error_number = HandleDNSConfigMessage(&msg.dns, lists);
             break;
 
+        case msg_add_wins_cfg:
+        case msg_del_wins_cfg:
+            ack.error_number = HandleWINSConfigMessage(&msg.wins, lists);
+            break;
+
         case msg_enable_dhcp:
             if (msg.header.size == sizeof(msg.dhcp))
             {
@@ -1608,6 +1766,10 @@ Undo(undo_lists_t *lists)
                     DeleteDNS(AF_INET6, item->data);
                     break;
 
+                case undo_wins:
+                    DeleteWINS(item->data);
+                    break;
+
                 case undo_domain:
                     SetDNSDomain(item->data, "", NULL);
                     break;
-- 
2.23.0.windows.1


