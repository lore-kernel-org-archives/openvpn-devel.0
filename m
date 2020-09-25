From: selva.nair@...277...
Date: Thu, 24 Sep 2020 20:49:29 -0400
Message-Id: <1600994969-7623-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Set DNS Domain using iservice
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

Signed-off-by: Selva Nair <selva.nair@...277...>
---
Note: this will set the domain twice if both v4 and v6 DNS
servers are defined. It cant hurt, but could be avoided by
making the domain setting a separate call from the DNS
server setting.

 src/openvpn/tun.c             |  21 +++++--
 src/openvpnserv/interactive.c | 133 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 147 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 80ae695..b681905 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -159,7 +159,7 @@ do_dns_service(bool add, const short family, const struct tuntap *tt)
     int addr_len = add ? len : 0;
     const char *ip_proto_name = family == AF_INET6 ? "IPv6" : "IPv4";
 
-    if (addr_len == 0 && add) /* no addresses to add */
+    if (addr_len == 0 && !tt->options.domain && add) /* no addresses or domain to add */
     {
         return true;
     }
@@ -199,9 +199,21 @@ do_dns_service(bool add, const short family, const struct tuntap *tt)
             dns.addr[i].ipv4.s_addr = htonl(tt->options.dns[i]);
         }
     }
+    if (tt->options.domain)
+    {
+        strncpy(dns.domains, tt->options.domain, _countof(dns.domains));
+	/* truncation of domain name is not checked as it cant happen
+	 * with 512 bytes room in dns.domains.
+	 */
+        msg(D_LOW, "%s dns domain on '%s' (if_index = %d) using service",
+            (add ? "Setting" : "Deleting"), dns.iface.name, dns.iface.index);
+    }
 
-    msg(D_LOW, "%s %s dns servers on '%s' (if_index = %d) using service",
-        (add ? "Setting" : "Deleting"), ip_proto_name, dns.iface.name, dns.iface.index);
+    if (addr_len > 0 || !add)
+    {
+        msg(D_LOW, "%s %s dns servers on '%s' (if_index = %d) using service",
+            (add ? "Setting" : "Deleting"), ip_proto_name, dns.iface.name, dns.iface.index);
+    }
 
     if (!send_msg_iservice(pipe, &dns, sizeof(dns), &ack, "TUN"))
     {
@@ -216,7 +228,8 @@ do_dns_service(bool add, const short family, const struct tuntap *tt)
         goto out;
     }
 
-    msg(M_INFO, "%s dns servers %s using service", ip_proto_name, (add ? "set" : "deleted"));
+    msg(M_INFO, "%s dns servers %s%s using service", ip_proto_name,
+		    (tt->options.domain? "and domain " : ""), (add ? "set" : "deleted"));
     ret = true;
 
 out:
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 207cc4a..b7f144d 100644
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
@@ -1117,9 +1231,14 @@ HandleDNSConfigMessage(const dns_cfg_message_t *msg, undo_lists_t *lists)
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
@@ -1142,6 +1261,8 @@ HandleDNSConfigMessage(const dns_cfg_message_t *msg, undo_lists_t *lists)
          */
     }
 
+    err = 0;
+
     if (msg->addr_len > 0)
     {
         wchar_t *tmp_name = wcsdup(wide_name);
@@ -1154,7 +1275,9 @@ HandleDNSConfigMessage(const dns_cfg_message_t *msg, undo_lists_t *lists)
         }
     }
 
-    err = 0;
+    if (msg->domains[0]) {
+        err = SetDNSDomain(wide_name, msg->domains, lists);
+    }
 
 out:
     free(wide_name);
@@ -1445,6 +1568,10 @@ Undo(undo_lists_t *lists)
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


