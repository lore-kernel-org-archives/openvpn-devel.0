From: Lev Stipakov <lstipakov@...277...>
Date: Sat, 20 Aug 2022 11:47:19 +0300
Message-Id: <20220820084719.243-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] dco-win: use run-time dynamic linking for
 GetOverlappedResultEx
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

This function is available starting from Windows 8. Calling it
"as is" causes startup error on Windows 7.

dco-win driver available on Windows 10 20H1 and newer. On older
systems installer will not show nor install the driver and dco-win code
won't be reached. It is safe to load GetOverlappedResultEx in runtime
and exit in case of error.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/dco_win.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 28bcccd4..a2030866 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -107,6 +107,17 @@ dco_start_tun(struct tuntap *tt)
 static int
 dco_connect_wait(HANDLE handle, OVERLAPPED *ov, int timeout, volatile int *signal_received)
 {
+    /* GetOverlappedResultEx is available starting from Windows 8 */
+    typedef BOOL (*get_overlapped_result_ex_t) (HANDLE, LPOVERLAPPED, LPDWORD, DWORD, BOOL);
+    get_overlapped_result_ex_t get_overlapped_result_ex =
+        (get_overlapped_result_ex_t)GetProcAddress(GetModuleHandle("Kernel32.dll"),
+                                                   "GetOverlappedResultEx");
+
+    if (get_overlapped_result_ex == NULL)
+    {
+        msg(M_ERR, "Failed to load GetOverlappedResult()");
+    }
+
     DWORD timeout_msec = timeout * 1000;
     const int poll_interval_ms = 50;
 
@@ -115,7 +126,7 @@ dco_connect_wait(HANDLE handle, OVERLAPPED *ov, int timeout, volatile int *signa
         timeout_msec -= poll_interval_ms;
 
         DWORD transferred;
-        if (GetOverlappedResultEx(handle, ov, &transferred, poll_interval_ms, FALSE) != 0)
+        if (get_overlapped_result_ex(handle, ov, &transferred, poll_interval_ms, FALSE) != 0)
         {
             /* TCP connection established by dco */
             return 0;
-- 
2.23.0.windows.1


