From: Selva Nair <selva.nair@...277...>
Date: Sat,  4 Jun 2016 16:09:05 -0400
Message-Id: <1465070945-5426-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH master-only] Set WFP engine handle to NULL
	in win_wfp_uninit()
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

This was missed by commit 6a33a34dee8f3

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/win32.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index f4d3237..8a2f957 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1192,6 +1192,7 @@ win_wfp_uninit(const HANDLE msg_channel)
     else
       {
         delete_block_dns_filters (m_hEngineHandle);
+        m_hEngineHandle = NULL;
       }
 
     return true;
-- 
1.7.10.4


