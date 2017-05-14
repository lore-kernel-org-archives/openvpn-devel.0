From: selva.nair@...277...
Date: Sun, 14 May 2017 18:16:36 -0400
Message-Id: <1494800196-8144-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH for 2.3] Check for errors in the return
	value of GetModuleFileNameW()
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

Also replace MAX_PATH by _countof(openvpnpath) as the latter
is arguably more robust.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/win32.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index b271597..56c3a1d 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1271,7 +1271,12 @@ win_wfp_block_dns (const NET_IFINDEX index)
     dmsg (D_LOW, "Tap Luid: %I64d", tapluid.Value);
 
     /* Get OpenVPN path. */
-    GetModuleFileNameW(NULL, openvpnpath, MAX_PATH);
+    status = GetModuleFileNameW(NULL, openvpnpath, _countof(openvpnpath));
+    if (status == 0 || status == _countof(openvpnpath))
+    {
+        msg(M_WARN|M_ERRNO, "block_dns: failed to get executable path");
+        goto err;
+    }
 
     if (FwpmGetAppIdFromFileName0(openvpnpath, &openvpnblob) != ERROR_SUCCESS)
         goto err;
-- 
2.1.4


