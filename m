From: Gert Doering <gert@...1296...>
Date: Thu, 18 Sep 2025 19:34:40 +0200
Message-ID: <20250918173447.32466-1-gert@...1296...>
In-Reply-To: <gerrit.1758189345000.I7a57d7b4e84aa2b9c9e71e30520ed468b0e3c278@...2715...>
References: <gerrit.1758189345000.I7a57d7b4e84aa2b9c9e71e30520ed468b0e3c278@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Validate DNS domain name before
 powershell invocation
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

Starting from commit

  d383d6e ("win: replace wmic invocation with powershell")

we pass --dhcp-option DOMAIN value to a powershell command
to set DNS domain. Without validation this opens the door
to a command injection atack.

This only allows domain names with chartacters:

  [A-Za-z0-9.-_\x80-\0xff]

Change-Id: I7a57d7b4e84aa2b9c9e71e30520ed468b0e3c278
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1198
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1198
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/domain_helper.h b/src/openvpn/domain_helper.h
new file mode 100644
index 0000000..f1ecf86
--- /dev/null
+++ b/src/openvpn/domain_helper.h
@@ -0,0 +1,45 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2025 Lev Stipakov <lev@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+static inline bool
+is_allowed_domain_ascii(unsigned char c)
+{
+    return (c >= 'A' && c <= 'Z')
+           || (c >= 'a' && c <= 'z')
+           || (c >= '0' && c <= '9')
+           || c == '.' || c == '-' || c == '_' || c >= 0x80;
+}
+
+static inline bool
+validate_domain(const char *domain)
+{
+    for (const char *ch = domain; *ch; ++ch)
+    {
+        if (!is_allowed_domain_ascii((unsigned char)*ch))
+        {
+            return false;
+        }
+    }
+
+    return true;
+}
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 99dc490..2784941 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -46,6 +46,7 @@
 #include "win32.h"
 #include "block_dns.h"
 #include "networking.h"
+#include "domain_helper.h"
 
 #include "memdbg.h"
 
@@ -390,6 +391,12 @@
         return;
     }
 
+    if (add && !validate_domain(tt->options.domain))
+    {
+        msg(M_WARN, "Failed to set DNS domain '%s' because it contains invalid characters", tt->options.domain);
+        return;
+    }
+
     struct argv argv = argv_new();
     argv_printf(&argv,
                 "%s%s -NoProfile -NonInteractive -Command Set-DnsClient -InterfaceIndex %lu -ConnectionSpecificSuffix '%s'",
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index ca58596..c12d34f 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -40,6 +40,7 @@
 #include "validate.h"
 #include "block_dns.h"
 #include "ring_buffer.h"
+#include "domain_helper.h"
 
 #define IO_TIMEOUT  2000 /*ms*/
 
@@ -1216,6 +1217,12 @@
 {
     NET_IFINDEX if_index;
 
+    if (!validate_domain(domain))
+    {
+        MsgToEventLog(MSG_FLAGS_ERROR, TEXT("Failed to set DNS domain '%hs' because it contains invalid characters"), domain);
+        return ERROR_INVALID_DATA;
+    }
+
     DWORD err  = ConvertInterfaceNameToIndex(if_name, &if_index);
     if (err != ERROR_SUCCESS)
     {

