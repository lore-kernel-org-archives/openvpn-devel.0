From: Selva Nair <selva.nair@...277...>
Date: Wed, 23 Nov 2016 22:35:27 -0500
Message-Id: <1479958527-29491-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Set IPv6 DNS servers using interactive
	service
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

- Any existing addresses are deleted before adding
- On close_tun all addresses are deleted (only if any were
  added)

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 doc/openvpn.8                 |   2 +-
 include/openvpn-msg.h         |   7 +-
 src/openvpn/tun.c             |  72 +++++++++++++++++-
 src/openvpnserv/Makefile.am   |   2 +-
 src/openvpnserv/common.c      |  12 +++
 src/openvpnserv/interactive.c | 173 ++++++++++++++++++++++++++++++++++++++++++
 src/openvpnserv/service.h     |   3 +
 7 files changed, 264 insertions(+), 7 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index ffb0f7d..28df268 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -5686,7 +5686,7 @@ this option to set secondary DNS server addresses.
 Set primary domain name server IPv6 address.  Repeat
 this option to set secondary DNS server IPv6 addresses.
 
-Note: currently this is handled using netsh and requires admin rights (the
+Note: currently this is handled using netsh (the
 existing DHCP code can only do IPv4 DHCP, and that protocol only
 permits IPv4 addresses anywhere).  The option will be put into the
 environment, so an
diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
index 4c13acf..f7fbdd2 100644
--- a/include/openvpn-msg.h
+++ b/include/openvpn-msg.h
@@ -79,10 +79,9 @@ typedef struct {
   message_header_t header;
   interface_t iface;
   char domains[512];
-  struct in_addr primary_ipv4;
-  struct in_addr secondary_ipv4;
-  struct in_addr6 primary_ipv6;
-  struct in_addr6 secondary_ipv6;
+  short family;
+  int addr_len;
+  inet_address_t addr[4]; /* support up to 4 dns addresses */
 } dns_cfg_message_t;
 
 typedef struct {
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 3ebf2b2..0d62575 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -135,6 +135,74 @@ out:
   return ret;
 }
 
+static bool
+do_dns6_service (bool add, const struct tuntap *tt)
+{
+  DWORD len;
+  bool ret = false;
+  ack_message_t ack;
+  struct gc_arena gc = gc_new ();
+  HANDLE pipe = tt->options.msg_channel;
+  int addr_len = add ? tt->options.dns6_len : 0;
+
+  if (addr_len == 0 && add) /* no addresses to add */
+      return true;
+
+  dns_cfg_message_t dns = {
+    .header = {
+      (add ? msg_add_dns_cfg : msg_del_dns_cfg),
+      sizeof (dns_cfg_message_t),
+      0 },
+    .iface = { .index = tt->adapter_index, .name = "" },
+    .domains = "",
+    .family = AF_INET6,
+    .addr_len = addr_len
+  };
+
+  /* interface name is required */
+  strncpy (dns.iface.name, tt->actual_name, sizeof (dns.iface.name));
+  dns.iface.name[sizeof (dns.iface.name) - 1] = '\0';
+
+  if (addr_len > _countof(dns.addr))
+    {
+      addr_len = _countof(dns.addr);
+      dns.addr_len = addr_len;
+      msg(M_WARN, "Number of IPv6 DNS addresses sent to service truncated to %d",
+          addr_len);
+    }
+
+  for (int i = 0; i < addr_len; ++i)
+    {
+      dns.addr[i].ipv6 = tt->options.dns6[i];
+    }
+
+  msg (D_LOW, "%s IPv6 dns servers on '%s' (if_index = %d) using service",
+       (add ? "Setting" : "Deleting"), dns.iface.name, dns.iface.index);
+
+  if (!WriteFile (pipe, &dns, sizeof (dns), &len, NULL) ||
+      !ReadFile (pipe, &ack, sizeof (ack), &len, NULL))
+    {
+      msg (M_WARN, "TUN: could not talk to service: %s [%lu]",
+           strerror_win32 (GetLastError (), &gc), GetLastError ());
+      goto out;
+    }
+
+  if (ack.error_number != NO_ERROR)
+    {
+      msg (M_WARN, "TUN: %s IPv6 dns failed using service: %s [status=%u if_name=%s]",
+           (add ? "adding" : "deleting"), strerror_win32 (ack.error_number, &gc),
+           ack.error_number, dns.iface.name);
+      goto out;
+    }
+
+  msg (M_INFO, "IPv6 dns servers %s using service", (add ? "set" : "deleted"));
+  ret = true;
+
+out:
+  gc_free (&gc);
+  return ret;
+}
+
 #endif
 
 #ifdef TARGET_SOLARIS
@@ -1384,7 +1452,7 @@ do_ifconfig (struct tuntap *tt,
 	else if (tt->options.msg_channel)
 	  {
 	    do_address_service (true, AF_INET6, tt);
-	    /* TODO: do_dns6_service() */
+            do_dns6_service (true, tt);
 	  }
 	else
 	  {
@@ -5596,6 +5664,8 @@ close_tun (struct tuntap *tt)
           if (tt->options.msg_channel)
             {
               do_address_service (false, AF_INET6, tt);
+              if (tt->options.dns6_len > 0)
+                  do_dns6_service (false, tt);
             }
           else
             {
diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index 3521a34..58ecd91 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -26,7 +26,7 @@ openvpnserv_CFLAGS = \
 	-municode -D_UNICODE \
 	-UNTDDI_VERSION -U_WIN32_WINNT \
 	-D_WIN32_WINNT=_WIN32_WINNT_VISTA
-openvpnserv_LDADD = -ladvapi32 -luserenv -liphlpapi -lfwpuclnt -lrpcrt4 -lshlwapi -lnetapi32 -lws2_32
+openvpnserv_LDADD = -ladvapi32 -luserenv -liphlpapi -lfwpuclnt -lrpcrt4 -lshlwapi -lnetapi32 -lws2_32 -lntdll
 endif
 
 openvpnserv_SOURCES = \
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index dba4724..eafee20 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -216,3 +216,15 @@ MsgToEventLog (DWORD flags, LPCTSTR format, ...)
 
   return error;
 }
+
+/* Convert a utf8 string to utf16. Caller should free the result */
+wchar_t *
+utf8to16 (const char *utf8)
+{
+  int n = MultiByteToWideChar (CP_UTF8, 0, utf8, -1, NULL, 0);
+  wchar_t *utf16 = malloc (n * sizeof (wchar_t));
+  if (!utf16)
+    return NULL;
+  MultiByteToWideChar (CP_UTF8, 0, utf8, -1, utf16, n);
+  return utf16;
+}
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index ffaa171..fe5f7b5 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -35,6 +35,12 @@
 #include <sddl.h>
 #include <shellapi.h>
 
+#ifdef HAVE_VERSIONHELPERS_H
+#include <versionhelpers.h>
+#else
+#include "compat-versionhelpers.h"
+#endif
+
 #include "openvpn-msg.h"
 #include "validate.h"
 #include "block_dns.h"
@@ -82,6 +88,8 @@ typedef enum {
   address,
   route,
   block_dns,
+  undo_dns4,
+  undo_dns6,
   _undo_type_max
 } undo_type_t;
 typedef list_item_t* undo_lists_t[_undo_type_max];
@@ -962,6 +970,157 @@ HandleRegisterDNSMessage (void)
   return err;
 }
 
+/**
+ * Run the command: netsh interface $proto $action dns $if_name $addr [validate=no]
+ * @param  action      "delete" or "add"
+ * @param  proto       "ipv6" or "ip"
+ * @param  if_name     "name_of_interface"
+ * @param  addr         IPv4 (for proto = ip) or IPv6 address as a string
+ *
+ * If addr is null and action = "delete" all addresses are deleted.
+ */
+static DWORD
+netsh_dns_cmd (const wchar_t *action, const wchar_t *proto, const wchar_t *if_name, const wchar_t *addr)
+{
+  DWORD err = 0;
+  int timeout = 30000; /* in msec */
+  wchar_t argv0[MAX_PATH];
+
+  if (!addr)
+    {
+      if (wcscmp(action, L"delete") == 0)
+          addr = L"all";
+      else /* nothing to do -- return success*/
+          goto out;
+    }
+
+  /* Path of netsh */
+  int n = GetSystemDirectory (argv0, MAX_PATH);
+  if (n > 0 && n < MAX_PATH) /* got system directory */
+   {
+      wcsncat(argv0, L"\\netsh.exe", MAX_PATH - n - 1);
+   }
+  else
+   {
+      wcsncpy(argv0, L"C:\\Windows\\system32\\netsh.exe", MAX_PATH);
+   }
+
+  /* cmd template:
+   * netsh interface $proto $action dns $if_name $addr [validate=no]
+   */
+  const wchar_t *fmt = L"netsh interface %s %s dns \"%s\" %s";
+
+  /* max cmdline length in wchars -- include room for worst case and some */
+  int ncmdline = wcslen(fmt) + wcslen(if_name) + wcslen(addr) + 32 + 1;
+  wchar_t *cmdline = malloc(ncmdline*sizeof(wchar_t));
+  if (!cmdline)
+  {
+     err = ERROR_OUTOFMEMORY;
+     goto out;
+  }
+
+  openvpn_sntprintf (cmdline, ncmdline, fmt, proto, action, if_name, addr);
+
+  if (IsWindows7OrGreater())
+    {
+      wcsncat(cmdline, L" validate=no", ncmdline - wcslen(cmdline) - 1);
+    }
+  err = ExecCommand (argv0, cmdline, timeout);
+
+out:
+  err = 0;
+  free (cmdline);
+  return err;
+}
+
+/* Delete all IPv4 or IPv6 dns servers for an interface */
+static DWORD
+DeleteDNS(short family, wchar_t *if_name)
+{
+   wchar_t *proto = (family == AF_INET6) ? L"ipv6" : L"ip";
+   return netsh_dns_cmd (L"delete", proto, if_name, NULL);
+}
+
+/* Add an IPv4 or IPv6 dns server to an interface */
+static DWORD
+AddDNS(short family, wchar_t *if_name, wchar_t *addr)
+{
+   wchar_t *proto = (family == AF_INET6) ? L"ipv6" : L"ip";
+   return netsh_dns_cmd (L"add", proto, if_name, addr);
+}
+
+static BOOL
+CmpWString (LPVOID item, LPVOID str)
+{
+  return (wcscmp (item, str) == 0) ? TRUE : FALSE;
+}
+
+static DWORD
+HandleDNSConfigMessage (const dns_cfg_message_t *msg, undo_lists_t *lists)
+{
+  DWORD err = 0;
+  wchar_t addr[46]; /* large enough to hold string representation of an ipv4 / ipv6 address */
+  undo_type_t undo_type = (msg->family == AF_INET6) ? undo_dns4 : undo_dns6;
+  int addr_len = msg->addr_len;
+
+  /* sanity check */
+  if (addr_len > _countof(msg->addr))
+     addr_len = _countof(msg->addr);
+
+  if (!msg->iface.name[0])  /* interface name is required */
+      return ERROR_MESSAGE_DATA;
+
+  wchar_t *wide_name = utf8to16(msg->iface.name); /* utf8 to wide-char */
+  if (!wide_name)
+    return ERROR_OUTOFMEMORY;
+
+  /* We delete all current addresses before adding any
+   * OR if the message type is del_dns_cfg
+   */
+  if (addr_len > 0 || msg->header.type == msg_del_dns_cfg)
+    {
+      err = DeleteDNS(msg->family, wide_name);
+      if (err)
+        goto out;
+      free (RemoveListItem (&(*lists)[undo_type], CmpWString, wide_name));
+    }
+
+  if (msg->header.type == msg_del_dns_cfg)  /* job done */
+      goto out;
+
+  for (int i = 0; i < addr_len; ++i)
+    {
+      if (msg->family == AF_INET6)
+          RtlIpv6AddressToStringW (&msg->addr[i].ipv6, addr);
+      else
+           RtlIpv4AddressToStringW (&msg->addr[i].ipv4, addr);
+      err = AddDNS(msg->family, wide_name, addr);
+      if (i == 0 && err)
+          goto out;
+      /* We do not check for duplicate addresses, so any error in adding
+       * additional addresses is ignored.
+       */
+    }
+
+  if (msg->addr_len > 0)
+    {
+      wchar_t *tmp_name = wcsdup(wide_name);
+      if (!tmp_name || AddListItem(&(*lists)[undo_type], tmp_name))
+        {
+           free(tmp_name);
+           DeleteDNS(msg->family, wide_name);
+           err = ERROR_OUTOFMEMORY;
+           goto out;
+        }
+    }
+
+  err = 0;
+
+out:
+  free(wide_name);
+  return err;
+}
+
 static VOID
 HandleMessage (HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events, undo_lists_t *lists)
 {
@@ -972,6 +1131,7 @@ HandleMessage (HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events, undo_list
     route_message_t route;
     flush_neighbors_message_t flush_neighbors;
     block_dns_message_t block_dns;
+    dns_cfg_message_t dns;
   } msg;
   ack_message_t ack = {
     .header = {
@@ -1017,6 +1177,11 @@ HandleMessage (HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events, undo_list
         ack.error_number = HandleRegisterDNSMessage ();
         break;
 
+    case msg_add_dns_cfg:
+    case msg_del_dns_cfg:
+        ack.error_number = HandleDNSConfigMessage (&msg.dns, lists);
+        break;
+
     default:
       ack.error_number = ERROR_MESSAGE_TYPE;
       MsgToEventLog (MSG_FLAGS_ERROR, TEXT("Unknown message type %d"), msg.header.type);
@@ -1048,6 +1213,14 @@ Undo (undo_lists_t *lists)
               DeleteRoute (item->data);
               break;
 
+            case undo_dns4:
+              DeleteDNS(AF_INET, item->data);
+              break;
+
+            case undo_dns6:
+              DeleteDNS(AF_INET6, item->data);
+              break;
+
             case block_dns:
               delete_block_dns_filters (item->data);
               item->data = NULL;
diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
index 94bfb07..c5d745f 100644
--- a/src/openvpnserv/service.h
+++ b/src/openvpnserv/service.h
@@ -89,4 +89,7 @@ BOOL ReportStatusToSCMgr (SERVICE_STATUS_HANDLE service, SERVICE_STATUS *status)
 LPCTSTR GetLastErrorText ();
 DWORD MsgToEventLog (DWORD flags, LPCTSTR lpszMsg, ...);
 
+/* Convert a utf8 string to utf16. Caller should free the result */
+wchar_t *utf8to16 (const char *utf8);
+
 #endif
-- 
2.1.4


