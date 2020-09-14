From: selva.nair@...277...
Date: Mon, 14 Sep 2020 19:29:41 -0400
Message-Id: <1600126181-16364-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Allow --dhcp-option in config file when
 windows-driver is wintun
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

When wintun is in use we mutate ip_win32_type to NETSH
and then complain that ip-win32 option should be dynamic or adaptive
if any --dhcp-option directive is present in the config file. This
causes a fatal error.

How to reproduce: specify a --dhcp-option in the config and change the
--windows-driver to wintun.

Fix this behaviour. A typo in the message is also corrected.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/options.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 8bf82c5..4b22d3d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2181,10 +2181,11 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
     }
 
     if (options->tuntap_options.dhcp_options
+        && options->windows_driver != WINDOWS_DRIVER_WINTUN
         && options->tuntap_options.ip_win32_type != IPW32_SET_DHCP_MASQ
         && options->tuntap_options.ip_win32_type != IPW32_SET_ADAPTIVE)
     {
-        msg(M_USAGE, "--dhcp-options requires --ip-win32 dynamic or adaptive");
+        msg(M_USAGE, "--dhcp-option requires --ip-win32 dynamic or adaptive");
     }
 
     if (options->windows_driver == WINDOWS_DRIVER_WINTUN && dev != DEV_TYPE_TUN)
-- 
2.1.4


