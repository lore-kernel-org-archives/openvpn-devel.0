From: selva.nair@...277...
Date: Thu, 11 May 2017 21:32:34 -0400
Message-Id: <1494552754-30060-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Pass correct buffer size to
	GetModuleFileNameW()
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

From: Selva Nair <selva.nair@...277...>

Fixes finding 5.6 of OSTIF/Quarkslab audit

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/win32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 0cbf5fd..9a03681 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1334,8 +1334,8 @@ win_wfp_block_dns(const NET_IFINDEX index, const HANDLE msg_channel)
         goto out;
     }
 
-    status = GetModuleFileNameW(NULL, openvpnpath, sizeof(openvpnpath));
-    if (status == 0 || status == sizeof(openvpnpath))
+    status = GetModuleFileNameW(NULL, openvpnpath, _countof(openvpnpath));
+    if (status == 0 || status == _countof(openvpnpath))
     {
         msg(M_WARN|M_ERRNO, "block_dns: cannot get executable path");
         goto out;
-- 
2.1.4


