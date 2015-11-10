From: Selva Nair <selva.nair@...277...>
Date: Tue, 10 Nov 2015 11:18:55 -0500
Message-Id: <1447172335-27411-1-git-send-email-selva.nair@...277...>
In-Reply-To: <20151109205639.GL24952@...1296...>
References: <20151109205639.GL24952@...1296...>
In-Reply-To: <20151109205639.GL24952@...1296...>
Subject: [Openvpn-devel] [PATCH for gui v2] Do not disconnect on suspend
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net, =?UTF-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>

On Mon, Nov 9, 2015 at 3:56 PM, Gert Doering <gert@...1296...> wrote:
> On Mon, Nov 09, 2015 at 03:35:23PM -0500, Selva Nair wrote:
>> Requires the installer to update the registry during an upgrade of exisitng
>> installations, or notify the end user of the change in the default value of
>> disconnect_on_suspend (0).
>
> What does this patch *do*?  Is this the "set up registry key on first
> start" part (so we set the default differently now)?
>
> But that implies that an upgrade will not change the default, right?

On further thought, its better to go more bold on this. 
Here is version 2 which culls the suspend processing.

--8<--

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 main.c     | 14 +-------------
 registry.c |  3 ---
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/main.c b/main.c
index 08c5663..bc3c41c 100644
--- a/main.c
+++ b/main.c
@@ -399,19 +399,7 @@ LRESULT CALLBACK WindowProcedure (HWND hwnd, UINT message, WPARAM wParam, LPARAM
     case WM_POWERBROADCAST:
       switch (wParam) {
         case PBT_APMSUSPEND:
-          if (o.disconnect_on_suspend[0] == '1')
-            {
-              /* Suspend running connections */
-              for (i=0; i<o.num_configs; i++)
-                {
-                  if (o.conn[i].state == connected)
-                SuspendOpenVPN(i);
-                }
-
-              /* Wait for all connections to suspend */
-              for (i=0; i<10; i++, Sleep(500))
-                if (CountConnState(suspending) == 0) break;
-            }
+           /* do nothing */
           return FALSE;
 
         case PBT_APMRESUMESUSPEND:
diff --git a/registry.c b/registry.c
index f96827a..2a75738 100644
--- a/registry.c
+++ b/registry.c
@@ -111,9 +111,6 @@ GetRegistryKeys()
 
   if (!GetRegKey(_T("show_script_window"), o.show_script_window, _T("1"), _countof(o.show_script_window))) return(false);
 
-  if (!GetRegKey(_T("disconnect_on_suspend"), o.disconnect_on_suspend, _T("1"), 
-      _countof(o.disconnect_on_suspend))) return(false);
-
   if (!GetRegKey(_T("passphrase_attempts"), o.psw_attempts_string, _T("3"), 
       _countof(o.psw_attempts_string))) return(false);
   o.psw_attempts = _ttoi(o.psw_attempts_string);
-- 
2.6.2


