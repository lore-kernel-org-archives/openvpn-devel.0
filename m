From: selva.nair@...277...
Date: Fri, 25 Sep 2020 22:04:46 -0400
Message-Id: <1601085886-10351-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1600994969-7623-1-git-send-email-selva.nair@...277...>
References: <1600994969-7623-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH v2] Set DNS Domain using iservice
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

From: Selva Nair <selva.nair@...277...>

Use wmic instead of directly editing the registry
as the former does not take full effect unless the dns
client service is restarted.

Editing the registry appears to work erratically depending
on whether its followed with a dchp renew or ipconfig /registerdns
etc.

DOMAIN-SEARCH is not handled here as wmic only supports
setting the global search list which will over-ride all
interface specific values.  Editing the registry directly
combined with a wmic command to reset the global SearchList
is an option that could be considered in a separate patch.

Trac # 1209, 1331

v2 changes
- Separate DNS domain setting from DNS server setting and call
  only once either during IPv4 processing or IPv6 processing
  if the former is not active. (file changed: tun.c)
- Null terminate domain and interface_name received from the
  client. (file changed: interactive.c)
  Its done using a const cast-away of msg in a limited scope.
  Not pretty, but alternatives are no better.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
Note that the design of interactive service is such that the
msg-channel client is always a designated (i.e. trusted) executable.
So strigs received from it can be trusted. The null-termination above
is out of an abundance of caution. This is unlike those received
on the service pipe which cannot be trusted.

 src/openvpn/tun.c             |  68 ++++++++++++++++++++
 src/openvpnserv/interactive.c | 140 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 205 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 80ae695..9eeaed0 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -149,6 +149,61 @@ out:
 }
 
 static bool
+do_dns_domain_service(bool add, const struct tuntap *tt)
+{
+    bool ret = false;
+    ack_message_t ack;
+    struct gc_arena gc = gc_new();
+    HANDLE pipe = tt->options.msg_channel;
+
+    if (!tt->options.domain) /* no  domain to add or delete */
+    {
+        return true;
+    }
+
+    /* Use dns_cfg_msg with addr_len = 0 for setting only the DOMAIN */
+    dns_cfg_message_t dns = {
+        .header = {
+            (add ? msg_add_dns_cfg : msg_del_dns_cfg),
+            sizeof(dns_cfg_message_t),
+            0
+        },
+        .iface = { .index = tt->adapter_index, .name = "" },
+        .domains = "",      /* set below */
+        .family = AF_INET,  /* unused */
+        .addr_len = 0       /* add/delete only the domain, not DNS servers */
+    };
+
+    strncpynt(dns.iface.name, tt->actual_name, sizeof(dns.iface.name));
+    strncpynt(dns.domains, tt->options.domain, sizeof(dns.domains));
+    /* truncation of domain name is not checked as it can't happen
+     * with 512 bytes room in dns.domains.
+     */
+
+    msg(D_LOW, "%s dns domain on '%s' (if_index = %d) using service",
+            (add ? "Setting" : "Deleting"), dns.iface.name, dns.iface.index);
+    if (!send_msg_iservice(pipe, &dns, sizeof(dns), &ack, "TUN"))
+    {
+        goto out;
+    }
+
+    if (ack.error_number != NO_ERROR)
+    {
+        msg(M_WARN, "TUN: %s dns domain failed using service: %s [status=%u if_name=%s]",
+            (add ? "adding" : "deleting"), strerror_win32(ack.error_number, &gc),
+            ack.error_number, dns.iface.name);
+        goto out;
+    }
+
+    msg(M_INFO, "DNS domain %s using service", (add ? "set" : "deleted"));
+    ret = true;
+
+out:
+    gc_free(&gc);
+    return ret;
+}
+
+static bool
 do_dns_service(bool add, const short family, const struct tuntap *tt)
 {
     bool ret = false;
@@ -164,6 +219,7 @@ do_dns_service(bool add, const short family, const struct tuntap *tt)
         return true;
     }
 
+    /* Use dns_cfg_msg with domain = "" for setting only the DNS servers */
     dns_cfg_message_t dns = {
         .header = {
             (add ? msg_add_dns_cfg : msg_del_dns_cfg),
@@ -1100,6 +1156,11 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
         }
         do_dns_service(true, AF_INET6, tt);
         do_set_mtu_service(tt, AF_INET6, tun_mtu);
+        /* If IPv4 is not enabled, set DNS domain here */
+        if (!tt->did_ifconfig_setup)
+        {
+           do_dns_domain_service(true, tt);
+        }
     }
     else
     {
@@ -1485,6 +1546,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
     {
         do_address_service(true, AF_INET, tt);
         do_dns_service(true, AF_INET, tt);
+        do_dns_domain_service(true, tt);
     }
     else if (tt->options.ip_win32_type == IPW32_SET_NETSH)
     {
@@ -6761,6 +6823,11 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
         }
         else if (tt->options.msg_channel)
         {
+            /* If IPv4 is not enabled, delete DNS domain here */
+            if (!tt->did_ifconfig_setup)
+            {
+                do_dns_domain_service(false, tt);
+            }
             if (tt->options.dns6_len > 0)
             {
                 do_dns_service(false, AF_INET6, tt);
@@ -6786,6 +6853,7 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
         }
         else if (tt->options.msg_channel)
         {
+            do_dns_domain_service(false, tt);
             do_dns_service(false, AF_INET, tt);
             do_address_service(false, AF_INET, tt);
         }
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 207cc4a..1793caf 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -91,6 +91,7 @@ typedef enum {
     block_dns,
     undo_dns4,
     undo_dns6,
+    undo_domain,
     _undo_type_max
 } undo_type_t;
 typedef list_item_t *undo_lists_t[_undo_type_max];
@@ -564,6 +565,24 @@ InterfaceLuid(const char *iface_name, PNET_LUID luid)
     return status;
 }
 
+static DWORD
+ConvertInterfaceNameToIndex(const wchar_t *ifname, NET_IFINDEX *index)
+{
+   NET_LUID luid;
+   DWORD err;
+
+   err = ConvertInterfaceAliasToLuid(ifname, &luid);
+   if (err == ERROR_SUCCESS)
+   {
+       err = ConvertInterfaceLuidToIndex(&luid, index);
+   }
+   if (err != ERROR_SUCCESS)
+   {
+       MsgToEventLog(M_ERR, L"Failed to find interface index for <%s>", ifname);
+   }
+   return err;
+}
+
 static BOOL
 CmpAddress(LPVOID item, LPVOID address)
 {
@@ -1057,6 +1076,53 @@ out:
     return err;
 }
 
+/**
+ * Run command: wmic nicconfig (InterfaceIndex=$if_index) call $action ($data)
+ * @param  if_index    "index of interface"
+ * @param  action      e.g., "SetDNSDomain"
+ * @param  data        data if required for action
+ *                     - a single word for SetDNSDomain, empty or NULL to delete
+ *                     - comma separated values for a list
+ */
+static DWORD
+wmic_nicconfig_cmd(const wchar_t *action, const NET_IFINDEX if_index,
+                   const wchar_t *data)
+{
+    DWORD err = 0;
+    wchar_t argv0[MAX_PATH];
+    wchar_t *cmdline = NULL;
+    int timeout = 10000; /* in msec */
+
+    swprintf(argv0, _countof(argv0), L"%s\\%s", get_win_sys_path(), L"wbem\\wmic.exe");
+    argv0[_countof(argv0) - 1] = L'\0';
+
+    const wchar_t *fmt;
+    /* comma separated list must be enclosed in parenthesis */
+    if (data && wcschr(data, L','))
+    {
+       fmt = L"wmic nicconfig where (InterfaceIndex=%ld) call %s (%s)";
+    }
+    else
+    {
+       fmt = L"wmic nicconfig where (InterfaceIndex=%ld) call %s %s";
+    }
+
+    size_t ncmdline = wcslen(fmt) + 20 + wcslen(action) /* max 20 for ifindex */
+                    + (data ? wcslen(data) + 1 : 1);
+    cmdline = malloc(ncmdline*sizeof(wchar_t));
+    if (!cmdline)
+    {
+        return ERROR_OUTOFMEMORY;
+    }
+
+    openvpn_sntprintf(cmdline, ncmdline, fmt, if_index, action,
+                      data? data : L"");
+    err = ExecCommand(argv0, cmdline, timeout);
+
+    free(cmdline);
+    return err;
+}
+
 /* Delete all IPv4 or IPv6 dns servers for an interface */
 static DWORD
 DeleteDNS(short family, wchar_t *if_name)
@@ -1079,6 +1145,54 @@ CmpWString(LPVOID item, LPVOID str)
     return (wcscmp(item, str) == 0) ? TRUE : FALSE;
 }
 
+/**
+ * Set interface specific DNS domain suffix
+ * @param  if_name    name of the the interface
+ * @param  domain     a single domain name
+ * @param  lists      pointer to the undo lists. If NULL
+ *                    undo lists are not altered.
+ * Will delete the currently set value if domain is empty.
+ */
+static DWORD
+SetDNSDomain(const wchar_t *if_name, const char *domain, undo_lists_t *lists)
+{
+   NET_IFINDEX if_index;
+
+   DWORD err  = ConvertInterfaceNameToIndex(if_name, &if_index);
+   if (err != ERROR_SUCCESS)
+   {
+       return err;
+   }
+
+   wchar_t *wdomain = utf8to16(domain); /* utf8 to wide-char */
+   if (!wdomain)
+   {
+       return ERROR_OUTOFMEMORY;
+   }
+
+   /* free undo list if previously set */
+   if (lists)
+   {
+       free(RemoveListItem(&(*lists)[undo_domain], CmpWString, (void *)if_name));
+   }
+
+   err = wmic_nicconfig_cmd(L"SetDNSDomain", if_index, wdomain);
+
+   /* Add to undo list if domain is non-empty */
+   if (err == 0 && wdomain[0] && lists)
+   {
+        wchar_t *tmp_name = wcsdup(if_name);
+        if (!tmp_name || AddListItem(&(*lists)[undo_domain], tmp_name))
+        {
+            free(tmp_name);
+            err = ERROR_OUTOFMEMORY;
+        }
+   }
+
+   free(wdomain);
+   return err;
+}
+
 static DWORD
 HandleDNSConfigMessage(const dns_cfg_message_t *msg, undo_lists_t *lists)
 {
@@ -1098,6 +1212,13 @@ HandleDNSConfigMessage(const dns_cfg_message_t *msg, undo_lists_t *lists)
         return ERROR_MESSAGE_DATA;
     }
 
+    /* use a non-const reference with limited scope to enforce null-termination of strings from client */
+    {
+        dns_cfg_message_t *msgptr = (dns_cfg_message_t *) msg;
+        msgptr->iface.name[_countof(msg->iface.name)-1] = '\0';
+        msgptr->domains[_countof(msg->domains)-1] = '\0';
+    }
+
     wchar_t *wide_name = utf8to16(msg->iface.name); /* utf8 to wide-char */
     if (!wide_name)
     {
@@ -1117,9 +1238,14 @@ HandleDNSConfigMessage(const dns_cfg_message_t *msg, undo_lists_t *lists)
         free(RemoveListItem(&(*lists)[undo_type], CmpWString, wide_name));
     }
 
-    if (msg->header.type == msg_del_dns_cfg) /* job done */
+    if (msg->header.type == msg_del_dns_cfg)
     {
-        goto out;
+        if (msg->domains[0])
+        {
+            /* setting an empty domain removes any previous value */
+            err = SetDNSDomain(wide_name, "", lists);
+        }
+        goto out;  /* job done */
     }
 
     for (int i = 0; i < addr_len; ++i)
@@ -1142,6 +1268,8 @@ HandleDNSConfigMessage(const dns_cfg_message_t *msg, undo_lists_t *lists)
          */
     }
 
+    err = 0;
+
     if (msg->addr_len > 0)
     {
         wchar_t *tmp_name = wcsdup(wide_name);
@@ -1154,7 +1282,9 @@ HandleDNSConfigMessage(const dns_cfg_message_t *msg, undo_lists_t *lists)
         }
     }
 
-    err = 0;
+    if (msg->domains[0]) {
+        err = SetDNSDomain(wide_name, msg->domains, lists);
+    }
 
 out:
     free(wide_name);
@@ -1445,6 +1575,10 @@ Undo(undo_lists_t *lists)
                     DeleteDNS(AF_INET6, item->data);
                     break;
 
+                case undo_domain:
+                    SetDNSDomain(item->data, "", NULL);
+                    break;
+
                 case block_dns:
                     interface_data = (block_dns_data_t *)(item->data);
                     delete_block_dns_filters(interface_data->engine);
-- 
2.1.4


