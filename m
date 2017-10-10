From: simon@...2293...
Date: Wed, 11 Oct 2017 01:11:21 +0200
Message-Id: <20171010231130.6832-4-simon@...2293...>
In-Reply-To: <20171010231130.6832-1-simon@...2293...>
References: <20171010231130.6832-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH 04/13] Local functions are not supported in
 MSVC. Bummer.
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

From: Simon Rozman <simon@...2293...>

---
 src/openvpnserv/interactive.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 2019d38..7ff45b1 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1891,6 +1891,11 @@ FreeWaitHandles(LPHANDLE h)
     free(h);
 }
 
+static BOOL
+CmpHandle(LPVOID item, LPVOID hnd)
+{
+    return item == hnd;
+}
 
 VOID WINAPI
 ServiceStartInteractive(DWORD dwArgc, LPTSTR *lpszArgv)
@@ -1901,11 +1906,6 @@ ServiceStartInteractive(DWORD dwArgc, LPTSTR *lpszArgv)
     list_item_t *threads = NULL;
     PHANDLE handles = NULL;
     DWORD handle_count;
-    BOOL
-    CmpHandle(LPVOID item, LPVOID hnd)
-    {
-        return item == hnd;
-    }
 
     service = RegisterServiceCtrlHandlerEx(interactive_service.name, ServiceCtrlInteractive, &status);
     if (!service)
-- 
2.9.0.windows.1


