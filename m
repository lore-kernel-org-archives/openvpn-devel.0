From: Selva Nair <selva.nair@...277...>
Date: Mon,  9 Nov 2015 15:35:23 -0500
Message-Id: <1447101323-1727-1-git-send-email-selva.nair@...277...>
In-Reply-To: <56404FD0.9060100@...515...>
References: <56404FD0.9060100@...515...>
Subject: [Openvpn-devel] [PATCH for gui] Do not disconnect on suspend by
	default
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
To: openvpn-devel@lists.sourceforge.net, samuli@...515...

With commit ea66a2b5c.. openvpn restarts instead of terminate on suspend.
This conflicts with the stop/restart logic in the gui during windows power
state change events. Here we change the default behaviour so that SIGTERM
is not triggered during windows suspend.

Requires the installer to update the registry during an upgrade of exisitng
installations, or notify the end user of the change in the default value of
disconnect_on_suspend (0).

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 registry.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/registry.c b/registry.c
index f96827a..16af368 100644
--- a/registry.c
+++ b/registry.c
@@ -111,7 +111,7 @@ GetRegistryKeys()
 
   if (!GetRegKey(_T("show_script_window"), o.show_script_window, _T("1"), _countof(o.show_script_window))) return(false);
 
-  if (!GetRegKey(_T("disconnect_on_suspend"), o.disconnect_on_suspend, _T("1"), 
+  if (!GetRegKey(_T("disconnect_on_suspend"), o.disconnect_on_suspend, _T("0"), 
       _countof(o.disconnect_on_suspend))) return(false);
 
   if (!GetRegKey(_T("passphrase_attempts"), o.psw_attempts_string, _T("3"), 
-- 
2.6.2


