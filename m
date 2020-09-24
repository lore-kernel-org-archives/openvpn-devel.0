From: Simon Rozman <simon@...2293...>
Date: Thu, 24 Sep 2020 08:55:19 +0200
Message-Id: <20200924065519.1839-1-simon@...2293...>
In-Reply-To: <A975CEB0-C46B-4A03-A862-C1B321A26D07@...2293...>
References: <A975CEB0-C46B-4A03-A862-C1B321A26D07@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] openvpnmsica: Simplify find_adapters() to
 void return
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

As the find_adapters() failure is not critical and FindSystemInfo()
should continue regardless, the find_adapters() has been simplified not
to return result code. It still logs any error thou.

Signed-off-by: Simon Rozman <simon@...2293...>
---
 src/openvpnmsica/openvpnmsica.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index f203f736..de1cf65c 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -248,7 +248,7 @@ cleanup_OpenSCManager:
 }
 
 
-static UINT
+static void
 find_adapters(
     _In_ MSIHANDLE hInstall,
     _In_z_ LPCTSTR szzHardwareIDs,
@@ -262,12 +262,12 @@ find_adapters(
     uiResult = tap_list_adapters(NULL, szzHardwareIDs, &pAdapterList);
     if (uiResult != ERROR_SUCCESS)
     {
-        return uiResult;
+        return;
     }
     else if (pAdapterList == NULL)
     {
         /* No adapters - no fun. */
-        return ERROR_SUCCESS;
+        return;
     }
 
     /* Get IPv4/v6 info for all network adapters. Actually, we're interested in link status only: up/down? */
@@ -394,7 +394,6 @@ cleanup_pAdapterAdresses:
     free(pAdapterAdresses);
 cleanup_pAdapterList:
     tap_free_adapter_list(pAdapterList);
-    return uiResult;
 }
 
 
-- 
2.28.0.windows.1


