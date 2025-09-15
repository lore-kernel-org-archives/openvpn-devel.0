From: Gert Doering <gert@...1296...>
Date: Mon, 15 Sep 2025 08:20:06 +0200
Message-ID: <20250915062013.2555-1-gert@...1296...>
In-Reply-To: <gerrit.1757684109000.Iff2f4ea677fe2d88659d7814dab0f792f5004fb3@...2715...>
References: <gerrit.1757684109000.Iff2f4ea677fe2d88659d7814dab0f792f5004fb3@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] win: replace wmic invocation with
 powershell
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

From: Lev Stipakov <lev@...515...>

Since wmic has been recently deprecated and is absent on new
systems, replace setting DNS domain "old-style" with powershell.

Some changes to the service implementation:

 - remove action parameter and hardcode Set-DnsClient since this is
 the only used action

 - remove support of multiple domains, since we only pass a single domain
 (tuntap_options.domain)

GitHub: https://github.com/OpenVPN/openvpn/issues/642

Change-Id: Iff2f4ea677fe2d88659d7814dab0f792f5004fb3
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1183
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 92e71a3..7c8a351 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -383,7 +383,7 @@
 }
 
 static void
-do_dns_domain_wmic(bool add, const struct tuntap *tt)
+do_dns_domain_pwsh(bool add, const struct tuntap *tt)
 {
     if (!tt->options.domain)
     {
@@ -391,9 +391,14 @@
     }
 
     struct argv argv = argv_new();
-    argv_printf(&argv, "%s%s nicconfig where (InterfaceIndex=%ld) call SetDNSDomain '%s'",
-                get_win_sys_path(), WMIC_PATH_SUFFIX, tt->adapter_index, add ? tt->options.domain : "");
-    exec_command("WMIC", &argv, 1, M_WARN);
+    argv_printf(&argv,
+                "%s%s -NoProfile -NonInteractive -Command Set-DnsClient -InterfaceIndex %lu -ConnectionSpecificSuffix '%s'",
+                get_win_sys_path(),
+                POWERSHELL_PATH_SUFFIX,
+                tt->adapter_index,
+                add ? tt->options.domain : ""
+                );
+    exec_command("PowerShell", &argv, 1, M_WARN);
 
     argv_free(&argv);
 }
@@ -1269,7 +1274,7 @@
 
         if (!tt->did_ifconfig_setup)
         {
-            do_dns_domain_wmic(true, tt);
+            do_dns_domain_pwsh(true, tt);
         }
     }
 #else /* platforms we have no IPv6 code for */
@@ -1625,7 +1630,7 @@
                            tt->adapter_netmask, NI_IP_NETMASK | NI_OPTIONS);
         }
 
-        do_dns_domain_wmic(true, tt);
+        do_dns_domain_pwsh(true, tt);
     }
 
 
@@ -7024,7 +7029,7 @@
         {
             if (!tt->did_ifconfig_setup)
             {
-                do_dns_domain_wmic(false, tt);
+                do_dns_domain_pwsh(false, tt);
             }
 
             netsh_delete_address_dns(tt, true, &gc);
@@ -7050,7 +7055,7 @@
         }
         else
         {
-            do_dns_domain_wmic(false, tt);
+            do_dns_domain_pwsh(false, tt);
 
             if (tt->options.ip_win32_type == IPW32_SET_NETSH)
             {
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index 1b87fa3..67e6169 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -38,7 +38,7 @@
 #define WIN_ROUTE_PATH_SUFFIX "\\system32\\route.exe"
 #define WIN_IPCONFIG_PATH_SUFFIX "\\system32\\ipconfig.exe"
 #define WIN_NET_PATH_SUFFIX "\\system32\\net.exe"
-#define WMIC_PATH_SUFFIX "\\system32\\wbem\\wmic.exe"
+#define POWERSHELL_PATH_SUFFIX "\\system32\\WindowsPowerShell\\v1.0\\powershell.exe"
 
 /*
  * Win32-specific OpenVPN code, targeted at the mingw
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index a25d26f..ca58596 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1150,45 +1150,31 @@
 }
 
 /**
- * Run command: wmic nicconfig (InterfaceIndex=$if_index) call $action ($data)
+ * Run command: powershell -NoProfile -NonInteractive -Command Set-DnsClient -InterfaceIndex %ld -ConnectionSpecificSuffix '%s'
  * @param  if_index    "index of interface"
- * @param  action      e.g., "SetDNSDomain"
  * @param  data        data if required for action
  *                     - a single word for SetDNSDomain, empty or NULL to delete
- *                     - comma separated values for a list
  */
 static DWORD
-wmic_nicconfig_cmd(const wchar_t *action, const NET_IFINDEX if_index,
-                   const wchar_t *data)
+pwsh_setdns_cmd(const NET_IFINDEX if_index, const wchar_t *data)
 {
     DWORD err = 0;
     wchar_t argv0[MAX_PATH];
     wchar_t *cmdline = NULL;
     int timeout = 10000; /* in msec */
 
-    openvpn_swprintf(argv0, _countof(argv0), L"%ls\\%ls", get_win_sys_path(), L"wbem\\wmic.exe");
+    openvpn_swprintf(argv0, _countof(argv0), L"%ls\\%ls", get_win_sys_path(), L"WindowsPowerShell\\v1.0\\powershell.exe");
 
-    const wchar_t *fmt;
-    /* comma separated list must be enclosed in parenthesis */
-    if (data && wcschr(data, L','))
-    {
-        fmt = L"wmic nicconfig where (InterfaceIndex=%ld) call %ls (%ls)";
-    }
-    else
-    {
-        fmt = L"wmic nicconfig where (InterfaceIndex=%ld) call %ls \"%ls\"";
-    }
+    const wchar_t *fmt = L"-NoProfile -NonInteractive -Command Set-DnsClient -InterfaceIndex %lu -ConnectionSpecificSuffix '%s'";
 
-    size_t ncmdline = wcslen(fmt) + 20 + wcslen(action) /* max 20 for ifindex */
-                      + (data ? wcslen(data) + 1 : 1);
+    size_t ncmdline = wcslen(fmt) + 20 + /* max 20 for ifindex */ (data ? wcslen(data) + 1 : 1);
     cmdline = malloc(ncmdline*sizeof(wchar_t));
     if (!cmdline)
     {
         return ERROR_OUTOFMEMORY;
     }
 
-    openvpn_swprintf(cmdline, ncmdline, fmt, if_index, action,
-                     data ? data : L"");
+    openvpn_swprintf(cmdline, ncmdline, fmt, if_index, data ? data : L"");
     err = ExecCommand(argv0, cmdline, timeout);
 
     free(cmdline);
@@ -1248,7 +1234,7 @@
         free(RemoveListItem(&(*lists)[undo_domain], CmpWString, (void *)if_name));
     }
 
-    err = wmic_nicconfig_cmd(L"SetDNSDomain", if_index, wdomain);
+    err = pwsh_setdns_cmd(if_index, wdomain);
 
     /* Add to undo list if domain is non-empty */
     if (err == 0 && wdomain[0] && lists)

