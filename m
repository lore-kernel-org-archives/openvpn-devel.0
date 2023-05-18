From: selva.nair@...277...
Date: Thu, 18 May 2023 13:33:45 -0400
Message-Id: <20230518173345.2722530-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Interactive service: do not force a target
 desktop for openvpn.exe
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

Setting the desktop as "winsta0\default" does not always work when run
from a non-interactive session which may not have access to the
the window station "Winsta0". Leave this as NULL to let the system
automatically assign a window station and desktop.

Test runs on Win10 confirm that "Winsta0\Default" still gets selected
when run interactively (e.g., using the GUI or from task scheduler as
an interactive job). This is the same behaviour as now.

The change allows "interactive service" to be used for launching
OpenVPN from non-interactive sessions. For example, when service client
is a non-interactive task from the task scheduler, the default desktop
in a custom window station gets assigned to openvpn.exe.

Note that we already run openvpn.exe in a non-interactive window
station when directly launched by "automatic service".

Github: Fixes OpenVPN/openvpn-gui#626

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpnserv/interactive.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index ec196274..d73cef04 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1868,7 +1868,6 @@ RunOpenvpn(LPVOID p)
     }
 
     startup_info.cb = sizeof(startup_info);
-    startup_info.lpDesktop = L"winsta0\\default";
     startup_info.dwFlags = STARTF_USESTDHANDLES;
     startup_info.hStdInput = stdin_read;
     startup_info.hStdOutput = stdout_write;
-- 
2.34.1


