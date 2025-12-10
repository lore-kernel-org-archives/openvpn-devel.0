From: Gert Doering <gert@...1296...>
Date: Wed, 10 Dec 2025 08:59:00 +0100
Message-ID: <20251210075906.27693-1-gert@...1296...>
In-Reply-To: <gerrit.1765353329000.I07311f397e6cd278b90c33f024e927c282cd03e4@...2715...>
References: <gerrit.1765353329000.I07311f397e6cd278b90c33f024e927c282cd03e4@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] tun.c: set IPv4 address temporary on
 Windows
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

Use store=active to set IPv4 address temporary so that
it will be removed on reboot. This makes the behavior
consistent with deletion and IPv6, where we already use
store=active.

https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/netsh-interface

GitHub: https://github.com/OpenVPN/openvpn/issues/915

Change-Id: I07311f397e6cd278b90c33f024e927c282cd03e4
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1430
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1430
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 0299285..849eddc 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5119,8 +5119,8 @@
         }
         else
         {
-            /* example: netsh interface ip set address 42 static 10.3.0.1 255.255.255.0 */
-            argv_printf(&argv, "%s%s interface ip set address %lu static %s %s", get_win_sys_path(),
+            /* example: netsh interface ip set address 42 static 10.3.0.1 255.255.255.0 store=active */
+            argv_printf(&argv, "%s%s interface ip set address %lu static %s %s store=active", get_win_sys_path(),
                         NETSH_PATH_SUFFIX, adapter_index, print_in_addr_t(ip, 0, &gc),
                         print_in_addr_t(netmask, 0, &gc));
 

