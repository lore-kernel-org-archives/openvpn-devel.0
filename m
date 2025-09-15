From: Gert Doering <gert@...1296...>
Date: Mon, 15 Sep 2025 15:03:38 +0200
Message-ID: <20250915130344.2906-1-gert@...1296...>
In-Reply-To: <gerrit.1757941198000.Ibb126e9ca4548aeb8b60df226e37c9b414698247@...2715...>
References: <gerrit.1757941198000.Ibb126e9ca4548aeb8b60df226e37c9b414698247@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] win: replace wmic invocation with
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

This is based on 2.6 patch which replaces wmic with powershell

    d383d6e "win: replace wmic invocation with powershell"

except that here we only touch openvpn process code. There is no
wmic calls in 2.7 service.

Github: fixes OpenVPN/openvpn#642

Change-Id: Ibb126e9ca4548aeb8b60df226e37c9b414698247
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1187
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 29f74a2..ee0733a 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -405,7 +405,7 @@
 }
 
 static void
-do_dns_domain_wmic(bool add, const struct tuntap *tt)
+do_dns_domain_pwsh(bool add, const struct tuntap *tt)
 {
     if (!tt->options.domain)
     {
@@ -413,10 +413,13 @@
     }
 
     struct argv argv = argv_new();
-    argv_printf(&argv, "%s%s nicconfig where (InterfaceIndex=%ld) call SetDNSDomain '%s'",
-                get_win_sys_path(), WMIC_PATH_SUFFIX, tt->adapter_index,
+    argv_printf(&argv,
+                "%s%s -NoProfile -NonInteractive -Command Set-DnsClient -InterfaceIndex %lu -ConnectionSpecificSuffix '%s'",
+                get_win_sys_path(),
+                POWERSHELL_PATH_SUFFIX,
+                tt->adapter_index,
                 add ? tt->options.domain : "");
-    exec_command("WMIC", &argv, 1, M_WARN);
+    exec_command("PowerShell", &argv, 1, M_WARN);
 
     argv_free(&argv);
 }
@@ -1208,7 +1211,7 @@
 
         if (!tt->did_ifconfig_setup)
         {
-            do_dns_domain_wmic(true, tt);
+            do_dns_domain_pwsh(true, tt);
         }
     }
 #else  /* platforms we have no IPv6 code for */
@@ -1527,7 +1530,7 @@
                            NI_IP_NETMASK | NI_OPTIONS);
         }
 
-        do_dns_domain_wmic(true, tt);
+        do_dns_domain_pwsh(true, tt);
     }
 
 
@@ -6547,7 +6550,7 @@
         {
             if (!tt->did_ifconfig_setup)
             {
-                do_dns_domain_wmic(false, tt);
+                do_dns_domain_pwsh(false, tt);
             }
 
             netsh_delete_address_dns(tt, true, &gc);
@@ -6574,7 +6577,7 @@
         }
         else
         {
-            do_dns_domain_wmic(false, tt);
+            do_dns_domain_pwsh(false, tt);
 
             if (tt->options.ip_win32_type == IPW32_SET_NETSH)
             {
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index dbfa5bc..ff3145a 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -40,7 +40,7 @@
 #define WIN_ROUTE_PATH_SUFFIX    "\\system32\\route.exe"
 #define WIN_IPCONFIG_PATH_SUFFIX "\\system32\\ipconfig.exe"
 #define WIN_NET_PATH_SUFFIX      "\\system32\\net.exe"
-#define WMIC_PATH_SUFFIX         "\\system32\\wbem\\wmic.exe"
+#define POWERSHELL_PATH_SUFFIX   "\\system32\\WindowsPowerShell\\v1.0\\powershell.exe"
 
 /*
  * Win32-specific OpenVPN code, targeted at the mingw

