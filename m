From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 10 Jul 2023 14:21:22 +0300
Message-Id: <20230710112122.576-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] tun.c: enclose DNS domain in single quotes
 in WMIC call
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

This is needed to support domains with hyphens.

Not using double quotes here, since our code replaces
them with underbars (see
https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/win32.c#L980).

Fixes https://github.com/OpenVPN/openvpn/issues/363

Change-Id: Iab536922d0731635cef529b5caf542f637b8d491
Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/tun.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index d1fd6def..60974208 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -333,7 +333,7 @@ do_dns_domain_wmic(bool add, const struct tuntap *tt)
     }
 
     struct argv argv = argv_new();
-    argv_printf(&argv, "%s%s nicconfig where (InterfaceIndex=%ld) call SetDNSDomain %s",
+    argv_printf(&argv, "%s%s nicconfig where (InterfaceIndex=%ld) call SetDNSDomain '%s'",
                 get_win_sys_path(), WMIC_PATH_SUFFIX, tt->adapter_index, add ? tt->options.domain : "");
     exec_command("WMIC", &argv, 1, M_WARN);
 
-- 
2.38.1.windows.1


