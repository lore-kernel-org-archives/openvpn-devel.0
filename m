From: Gert Doering <gert@...1296...>
Date: Sun,  9 Mar 2025 13:50:40 +0100
Message-ID: <20250309125040.5041-1-gert@...1296...>
In-Reply-To: <gerrit.1733328040000.Id2bed0908e84c19b8fb6fe806376316793e550b4@...2715...>
References: <gerrit.1733328040000.Id2bed0908e84c19b8fb6fe806376316793e550b4@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v12] dns: do not use netsh to set name
 server addresses
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

From: Heiko Hund <heiko@...2662...>

Instead of spawning a netsh process, set the name server addresses
directly in the registry hive of the VPN interface.

This is a first step to get rid of the use of command line tools in the
service and move to a more API driven style of modifying the VPN adapter
configuration.

Change-Id: Id2bed0908e84c19b8fb6fe806376316793e550b4
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Lev Stipakov <lstipakov@...277...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/825
This mail reflects revision 12 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@...277...>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index a76d908..13a6091 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1024,65 +1024,6 @@
 }
 
 /**
- * Run the command: netsh interface $proto $action dns $if_name $addr [validate=no]
- * @param  action      "delete" or "add"
- * @param  proto       "ipv6" or "ip"
- * @param  if_name     "name_of_interface"
- * @param  addr         IPv4 (for proto = ip) or IPv6 address as a string
- *
- * If addr is null and action = "delete" all addresses are deleted.
- */
-static DWORD
-netsh_dns_cmd(const wchar_t *action, const wchar_t *proto, const wchar_t *if_name, const wchar_t *addr)
-{
-    DWORD err = 0;
-    int timeout = 30000; /* in msec */
-    wchar_t argv0[MAX_PATH];
-    wchar_t *cmdline = NULL;
-
-    if (!addr)
-    {
-        if (wcscmp(action, L"delete") == 0)
-        {
-            addr = L"all";
-        }
-        else /* nothing to do -- return success*/
-        {
-            goto out;
-        }
-    }
-
-    /* Path of netsh */
-    swprintf(argv0, _countof(argv0), L"%ls\\%ls", get_win_sys_path(), L"netsh.exe");
-
-    /* cmd template:
-     * netsh interface $proto $action dns $if_name $addr [validate=no]
-     */
-    const wchar_t *fmt = L"netsh interface %ls %ls dns \"%ls\" %ls";
-
-    /* max cmdline length in wchars -- include room for worst case and some */
-    size_t ncmdline = wcslen(fmt) + wcslen(if_name) + wcslen(addr) + 32 + 1;
-    cmdline = malloc(ncmdline*sizeof(wchar_t));
-    if (!cmdline)
-    {
-        err = ERROR_OUTOFMEMORY;
-        goto out;
-    }
-
-    swprintf(cmdline, ncmdline, fmt, proto, action, if_name, addr);
-
-    if (IsWindows7OrGreater())
-    {
-        wcscat_s(cmdline, ncmdline, L" validate=no");
-    }
-    err = ExecCommand(argv0, cmdline, timeout);
-
-out:
-    free(cmdline);
-    return err;
-}
-
-/**
  * Run the command: netsh interface ip $action wins $if_name [static] $addr
  * @param  action      "delete", "add" or "set"
  * @param  if_name     "name_of_interface"
@@ -1139,22 +1080,6 @@
     return err;
 }
 
-/* Delete all IPv4 or IPv6 dns servers for an interface */
-static DWORD
-DeleteDNS(short family, wchar_t *if_name)
-{
-    wchar_t *proto = (family == AF_INET6) ? L"ipv6" : L"ip";
-    return netsh_dns_cmd(L"delete", proto, if_name, NULL);
-}
-
-/* Add an IPv4 or IPv6 dns server to an interface */
-static DWORD
-AddDNS(short family, wchar_t *if_name, wchar_t *addr)
-{
-    wchar_t *proto = (family == AF_INET6) ? L"ipv6" : L"ip";
-    return netsh_dns_cmd(L"add", proto, if_name, addr);
-}
-
 static BOOL
 CmpWString(LPVOID item, LPVOID str)
 {
@@ -1818,11 +1743,115 @@
     return err;
 }
 
+/**
+ * Return the interfaces registry key for the specified address family
+ *
+ * @param family    the internet address family to open the key for
+ * @param key       PHKEY to return the key in
+ * @return BOOL to indicate success or failure
+ */
+static BOOL
+GetInterfacesKey(short family, PHKEY key)
+{
+    PCSTR itfs_key = family == AF_INET6
+        ? "SYSTEM\\CurrentControlSet\\Services\\Tcpip6\\Parameters\\Interfaces"
+        : "SYSTEM\\CurrentControlSet\\Services\\Tcpip\\Parameters\\Interfaces";
+
+    LSTATUS err = RegOpenKeyExA(HKEY_LOCAL_MACHINE, itfs_key, 0, KEY_ALL_ACCESS, key);
+    if (err)
+    {
+        *key = INVALID_HANDLE_VALUE;
+        MsgToEventLog(M_SYSERR, TEXT("GetInterfacesKey: "
+                                     "could not open interfaces registry key for family %d (%lu)"),
+                      family, err);
+    }
+
+    return err ? FALSE : TRUE;
+}
+
+/**
+ * Set the DNS name servers in a registry interface configuration
+ *
+ * @param itf_id    the interface id to set the servers for
+ * @param family    internet address family to set the servers for
+ * @param value     the value to set the name servers to
+ *
+ * @return DWORD NO_ERROR on success, a Windows error code otherwise
+ */
+static DWORD
+SetNameServersValue(PCWSTR itf_id, short family, PCSTR value)
+{
+    DWORD err;
+
+    HKEY itfs;
+    if (!GetInterfacesKey(family, &itfs))
+    {
+        return ERROR_FILE_NOT_FOUND;
+    }
+
+    HKEY itf = INVALID_HANDLE_VALUE;
+    err = RegOpenKeyExW(itfs, itf_id, 0, KEY_ALL_ACCESS, &itf);
+    if (err)
+    {
+        MsgToEventLog(M_SYSERR, TEXT("SetNameServersValue: "
+                                     "could not open interface key for %s family %d (%lu)"),
+                      itf_id, family, err);
+        goto out;
+    }
+
+    err = RegSetValueExA(itf, "NameServer", 0, REG_SZ, (PBYTE)value, strlen(value) + 1);
+    if (err)
+    {
+        MsgToEventLog(M_SYSERR, TEXT("SetNameServersValue: "
+                                     "could not set name servers '%S' for %s family %d (%lu)"),
+                      value, itf_id, family, err);
+    }
+
+out:
+    if (itf != INVALID_HANDLE_VALUE)
+    {
+        RegCloseKey(itf);
+    }
+    if (itfs != INVALID_HANDLE_VALUE)
+    {
+        RegCloseKey(itfs);
+    }
+    return err;
+}
+
+/**
+ * Set the DNS name servers in a registry interface configuration
+ *
+ * @param itf_id    the interface id to set the servers for
+ * @param family    internet address family to set the servers for
+ * @param addrs     comma separated list of name server addresses
+ *
+ * @return DWORD NO_ERROR on success, a Windows error code otherwise
+ */
+static DWORD
+SetNameServers(PCWSTR itf_id, short family, PCSTR addrs)
+{
+    return SetNameServersValue(itf_id, family, addrs);
+}
+
+/**
+ * Delete all DNS name servers from a registry interface configuration
+ *
+ * @param itf_id    the interface id to clear the servers for
+ * @param family    internet address family to clear the servers for
+ *
+ * @return DWORD NO_ERROR on success, a Windows error code otherwise
+ */
+static DWORD
+ResetNameServers(PCWSTR itf_id, short family)
+{
+    return SetNameServersValue(itf_id, family, "");
+}
+
 static DWORD
 HandleDNSConfigMessage(const dns_cfg_message_t *msg, undo_lists_t *lists)
 {
     DWORD err = 0;
-    wchar_t addr[46]; /* large enough to hold string representation of an ipv4 / ipv6 address */
     undo_type_t undo_type = (msg->family == AF_INET6) ? undo_dns4 : undo_dns6;
     int addr_len = msg->addr_len;
 
@@ -1844,10 +1873,11 @@
         msgptr->domains[_countof(msg->domains)-1] = '\0';
     }
 
-    wchar_t *wide_name = utf8to16(msg->iface.name); /* utf8 to wide-char */
-    if (!wide_name)
+    WCHAR iid[64];
+    err = InterfaceIdString(msg->iface.name, iid, _countof(iid));
+    if (err)
     {
-        return ERROR_OUTOFMEMORY;
+        return err;
     }
 
     /* We delete all current addresses before adding any
@@ -1855,12 +1885,12 @@
      */
     if (addr_len > 0 || msg->header.type == msg_del_dns_cfg)
     {
-        err = DeleteDNS(msg->family, wide_name);
+        err = ResetNameServers(iid, msg->family);
         if (err)
         {
-            goto out;
+            return err;
         }
-        free(RemoveListItem(&(*lists)[undo_type], CmpWString, wide_name));
+        free(RemoveListItem(&(*lists)[undo_type], CmpAny, iid));
     }
 
     if (msg->header.type == msg_del_dns_cfg)
@@ -1872,40 +1902,43 @@
             err = SetDnsSearchDomains(msg->iface.name, NULL, &gpol, lists);
         }
         ApplyDnsSettings(gpol);
-        goto out;  /* job done */
+        return err;  /* job done */
     }
 
-    for (int i = 0; i < addr_len; ++i)
-    {
-        if (msg->family == AF_INET6)
-        {
-            RtlIpv6AddressToStringW(&msg->addr[i].ipv6, addr);
-        }
-        else
-        {
-            RtlIpv4AddressToStringW(&msg->addr[i].ipv4, addr);
-        }
-        err = AddDNS(msg->family, wide_name, addr);
-        if (i == 0 && err)
-        {
-            goto out;
-        }
-        /* We do not check for duplicate addresses, so any error in adding
-         * additional addresses is ignored.
-         */
-    }
-
-    err = 0;
-
     if (msg->addr_len > 0)
     {
-        wchar_t *tmp_name = _wcsdup(wide_name);
-        if (!tmp_name || AddListItem(&(*lists)[undo_type], tmp_name))
+        /* prepare the comma separated address list */
+        CHAR addrs[256]; /* large enough to hold four IPv4 / IPv6 address strings */
+        size_t offset = 0;
+        for (int i = 0; i < addr_len; ++i)
         {
-            free(tmp_name);
-            DeleteDNS(msg->family, wide_name);
-            err = ERROR_OUTOFMEMORY;
-            goto out;
+            if (i != 0)
+            {
+                addrs[offset++] = ',';
+            }
+            if (msg->family == AF_INET6)
+            {
+                RtlIpv6AddressToStringA(&msg->addr[i].ipv6, addrs + offset);
+            }
+            else
+            {
+                RtlIpv4AddressToStringA(&msg->addr[i].ipv4, addrs + offset);
+            }
+            offset += strlen(addrs);
+        }
+
+        err = SetNameServers(iid, msg->family, addrs);
+        if (err)
+        {
+            return err;
+        }
+
+        wchar_t *tmp_iid = _wcsdup(iid);
+        if (!tmp_iid || AddListItem(&(*lists)[undo_type], tmp_iid))
+        {
+            free(tmp_iid);
+            ResetNameServers(iid, msg->family);
+            return ERROR_OUTOFMEMORY;
         }
     }
 
@@ -1916,8 +1949,6 @@
     }
     ApplyDnsSettings(gpol);
 
-out:
-    free(wide_name);
     return err;
 }
 
@@ -2298,11 +2329,11 @@
                     break;
 
                 case undo_dns4:
-                    DeleteDNS(AF_INET, item->data);
+                    ResetNameServers(item->data, AF_INET);
                     break;
 
                 case undo_dns6:
-                    DeleteDNS(AF_INET6, item->data);
+                    ResetNameServers(item->data, AF_INET6);
                     break;
 
                 case undo_domains:

