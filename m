From: Gert Doering <gert@...1296...>
Date: Mon,  3 Nov 2025 10:15:17 +0100
Message-ID: <20251103091525.22108-1-gert@...1296...>
In-Reply-To: <gerrit.1761942169000.I5cf45cfe0567da8fb5d47118a432a35b358f3809@...2715...>
References: <gerrit.1761942169000.I5cf45cfe0567da8fb5d47118a432a35b358f3809@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] iservice: use interface index with netsh
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

We use the interface index with netsh everywhere else, so convert the
remaining invocations of netsh to index use as well.

Change-Id: I5cf45cfe0567da8fb5d47118a432a35b358f3809
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1337
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1337
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@...277...>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index c12d34f..b35005c 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1035,16 +1035,16 @@
 }
 
 /**
- * Run the command: netsh interface $proto $action dns $if_name $addr [validate=no]
+ * Run the command: netsh interface $proto $action dns $if_index $addr [validate=no]
  * @param  action      "delete" or "add"
  * @param  proto       "ipv6" or "ip"
- * @param  if_name     "name_of_interface"
+ * @param  if_index     index of the interface to modify DNS for
  * @param  addr         IPv4 (for proto = ip) or IPv6 address as a string
  *
  * If addr is null and action = "delete" all addresses are deleted.
  */
 static DWORD
-netsh_dns_cmd(const wchar_t *action, const wchar_t *proto, const wchar_t *if_name, const wchar_t *addr)
+netsh_dns_cmd(const wchar_t *action, const wchar_t *proto, int if_index, const wchar_t *addr)
 {
     DWORD err = 0;
     int timeout = 30000; /* in msec */
@@ -1069,10 +1069,10 @@
     /* cmd template:
      * netsh interface $proto $action dns $if_name $addr [validate=no]
      */
-    const wchar_t *fmt = L"netsh interface %ls %ls dns \"%ls\" %ls";
+    const wchar_t *fmt = L"netsh interface %ls %ls dns %d %ls";
 
     /* max cmdline length in wchars -- include room for worst case and some */
-    size_t ncmdline = wcslen(fmt) + wcslen(if_name) + wcslen(addr) + 32 + 1;
+    size_t ncmdline = wcslen(fmt) + 11 /*if_index*/ + wcslen(addr) + 32 + 1;
     cmdline = malloc(ncmdline*sizeof(wchar_t));
     if (!cmdline)
     {
@@ -1080,7 +1080,7 @@
         goto out;
     }
 
-    openvpn_swprintf(cmdline, ncmdline, fmt, proto, action, if_name, addr);
+    openvpn_swprintf(cmdline, ncmdline, fmt, proto, action, if_index, addr);
 
     if (IsWindows7OrGreater())
     {
@@ -1094,16 +1094,16 @@
 }
 
 /**
- * Run the command: netsh interface ip $action wins $if_name [static] $addr
+ * Run the command: netsh interface ip $action wins $if_index [static] $addr
  * @param  action      "delete", "add" or "set"
- * @param  if_name     "name_of_interface"
+ * @param  if_index    index of the interface to modify WINS for
  * @param  addr        IPv4 address as a string
  *
  * If addr is null and action = "delete" all addresses are deleted.
  * if action = "set" then "static" is added before $addr
  */
 static DWORD
-netsh_wins_cmd(const wchar_t *action, const wchar_t *if_name, const wchar_t *addr)
+netsh_wins_cmd(const wchar_t *action, int if_index, const wchar_t *addr)
 {
     DWORD err = 0;
     int timeout = 30000; /* in msec */
@@ -1129,11 +1129,11 @@
     /* cmd template:
      * netsh interface ip $action wins $if_name $static $addr
      */
-    const wchar_t *fmt = L"netsh interface ip %ls wins \"%ls\" %ls %ls";
+    const wchar_t *fmt = L"netsh interface ip %ls wins %d %ls %ls";
 
     /* max cmdline length in wchars -- include room for worst case and some */
-    size_t ncmdline = wcslen(fmt) + wcslen(if_name) + wcslen(action) + wcslen(addr)
-                      +wcslen(addr_static) + 32 + 1;
+    size_t ncmdline = wcslen(fmt) + 11 /*if_index*/ + wcslen(action) + wcslen(addr)
+                      + wcslen(addr_static) + 32 + 1;
     cmdline = malloc(ncmdline * sizeof(wchar_t));
     if (!cmdline)
     {
@@ -1141,7 +1141,7 @@
         goto out;
     }
 
-    openvpn_swprintf(cmdline, ncmdline, fmt, action, if_name, addr_static, addr);
+    openvpn_swprintf(cmdline, ncmdline, fmt, action, if_index, addr_static, addr);
 
     err = ExecCommand(argv0, cmdline, timeout);
 
@@ -1184,18 +1184,18 @@
 
 /* Delete all IPv4 or IPv6 dns servers for an interface */
 static DWORD
-DeleteDNS(short family, wchar_t *if_name)
+DeleteDNS(short family, int if_index)
 {
     wchar_t *proto = (family == AF_INET6) ? L"ipv6" : L"ip";
-    return netsh_dns_cmd(L"delete", proto, if_name, NULL);
+    return netsh_dns_cmd(L"delete", proto, if_index, NULL);
 }
 
 /* Add an IPv4 or IPv6 dns server to an interface */
 static DWORD
-AddDNS(short family, wchar_t *if_name, wchar_t *addr)
+AddDNS(short family, int if_index, wchar_t *addr)
 {
     wchar_t *proto = (family == AF_INET6) ? L"ipv6" : L"ip";
-    return netsh_dns_cmd(L"add", proto, if_name, addr);
+    return netsh_dns_cmd(L"add", proto, if_index, addr);
 }
 
 static BOOL
@@ -1295,12 +1295,12 @@
      */
     if (addr_len > 0 || msg->header.type == msg_del_dns_cfg)
     {
-        err = DeleteDNS(msg->family, wide_name);
+        err = DeleteDNS(msg->family, msg->iface.index);
         if (err)
         {
             goto out;
         }
-        free(RemoveListItem(&(*lists)[undo_type], CmpWString, wide_name));
+        free(RemoveListItem(&(*lists)[undo_type], CmpAny, NULL));
     }
 
     if (msg->header.type == msg_del_dns_cfg)
@@ -1323,7 +1323,7 @@
         {
             RtlIpv4AddressToStringW(&msg->addr[i].ipv4, addr);
         }
-        err = AddDNS(msg->family, wide_name, addr);
+        err = AddDNS(msg->family, msg->iface.index, addr);
         if (i == 0 && err)
         {
             goto out;
@@ -1337,11 +1337,15 @@
 
     if (msg->addr_len > 0)
     {
-        wchar_t *tmp_name = _wcsdup(wide_name);
-        if (!tmp_name || AddListItem(&(*lists)[undo_type], tmp_name))
+        int *tmp_index = malloc(sizeof(msg->iface.index));
+        if (tmp_index)
         {
-            free(tmp_name);
-            DeleteDNS(msg->family, wide_name);
+            *tmp_index = msg->iface.index;
+        }
+        if (!tmp_index || AddListItem(&(*lists)[undo_type], tmp_index))
+        {
+            free(tmp_index);
+            DeleteDNS(msg->family, msg->iface.index);
             err = ERROR_OUTOFMEMORY;
             goto out;
         }
@@ -1360,7 +1364,7 @@
 static DWORD
 HandleWINSConfigMessage(const wins_cfg_message_t *msg, undo_lists_t *lists)
 {
-    DWORD err = 0;
+    DWORD err = NO_ERROR;
     wchar_t addr[16]; /* large enough to hold string representation of an ipv4 */
     int addr_len = msg->addr_len;
 
@@ -1370,37 +1374,25 @@
         addr_len = _countof(msg->addr);
     }
 
-    if (!msg->iface.name[0]) /* interface name is required */
+    if (!msg->iface.index) /* interface index is required */
     {
         return ERROR_MESSAGE_DATA;
     }
 
-    /* use a non-const reference with limited scope to enforce null-termination of strings from client */
-    {
-        wins_cfg_message_t *msgptr = (wins_cfg_message_t *)msg;
-        msgptr->iface.name[_countof(msg->iface.name) - 1] = '\0';
-    }
-
-    wchar_t *wide_name = utf8to16(msg->iface.name); /* utf8 to wide-char */
-    if (!wide_name)
-    {
-        return ERROR_OUTOFMEMORY;
-    }
-
     /* We delete all current addresses before adding any
      * OR if the message type is del_wins_cfg
      */
     if (addr_len > 0 || msg->header.type == msg_del_wins_cfg)
     {
-        err = netsh_wins_cmd(L"delete", wide_name, NULL);
+        err = netsh_wins_cmd(L"delete", msg->iface.index, NULL);
         if (err)
         {
             goto out;
         }
-        free(RemoveListItem(&(*lists)[undo_wins], CmpWString, wide_name));
+        free(RemoveListItem(&(*lists)[undo_wins], CmpAny, NULL));
     }
 
-    if (msg->header.type == msg_del_wins_cfg)
+    if (addr_len == 0 || msg->header.type == msg_del_wins_cfg)
     {
         goto out;  /* job done */
     }
@@ -1408,7 +1400,7 @@
     for (int i = 0; i < addr_len; ++i)
     {
         RtlIpv4AddressToStringW(&msg->addr[i].ipv4, addr);
-        err = netsh_wins_cmd(i == 0 ? L"set" : L"add", wide_name, addr);
+        err = netsh_wins_cmd(i == 0 ? L"set" : L"add", msg->iface.index, addr);
         if (i == 0 && err)
         {
             goto out;
@@ -1418,22 +1410,23 @@
          */
     }
 
-    err = 0;
-
-    if (addr_len > 0)
+    int *if_index = malloc(sizeof(msg->iface.index));
+    if (if_index)
     {
-        wchar_t *tmp_name = _wcsdup(wide_name);
-        if (!tmp_name || AddListItem(&(*lists)[undo_wins], tmp_name))
-        {
-            free(tmp_name);
-            netsh_wins_cmd(L"delete", wide_name, NULL);
-            err = ERROR_OUTOFMEMORY;
-            goto out;
-        }
+        *if_index = msg->iface.index;
     }
 
+    if (!if_index || AddListItem(&(*lists)[undo_wins], if_index))
+    {
+        free(if_index);
+        netsh_wins_cmd(L"delete", msg->iface.index, NULL);
+        err = ERROR_OUTOFMEMORY;
+        goto out;
+    }
+
+    err = 0;
+
 out:
-    free(wide_name);
     return err;
 }
 
@@ -1734,15 +1727,15 @@
                     break;
 
                 case undo_dns4:
-                    DeleteDNS(AF_INET, item->data);
+                    DeleteDNS(AF_INET, *(int *)item->data);
                     break;
 
                 case undo_dns6:
-                    DeleteDNS(AF_INET6, item->data);
+                    DeleteDNS(AF_INET6, *(int *)item->data);
                     break;
 
                 case undo_wins:
-                    netsh_wins_cmd(L"delete", item->data, NULL);
+                    netsh_wins_cmd(L"delete", *(int *)item->data, NULL);
                     break;
 
                 case undo_domain:

