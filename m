From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 31 Jan 2023 14:54:48 +0200
Message-Id: <20230131125448.1913-1-lstipakov@...277...>
In-Reply-To: <008d96b3-3062-85a0-b35b-52a45462faa9@...2669...>
References: <008d96b3-3062-85a0-b35b-52a45462faa9@...2669...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] dco-win: use proper calling convention
 on x86
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

WinAPI uses __stdcall calling convention on x86. Wrong
calling convention causes UB, which in this case breaks
dco-win functionality.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 v2:
  - use WINAPI instead of __stdcall
  - replace another existing occurence of __stdcall with WINAPI
  - uncrustify

 src/openvpn/dco_win.c | 2 +-
 src/openvpn/win32.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 7594024c..0931fb30 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -110,7 +110,7 @@ dco_connect_wait(HANDLE handle, OVERLAPPED *ov, int timeout, struct signal_info
 {
     volatile int *signal_received = &sig_info->signal_received;
     /* GetOverlappedResultEx is available starting from Windows 8 */
-    typedef BOOL (*get_overlapped_result_ex_t) (HANDLE, LPOVERLAPPED, LPDWORD, DWORD, BOOL);
+    typedef BOOL (WINAPI *get_overlapped_result_ex_t)(HANDLE, LPOVERLAPPED, LPDWORD, DWORD, BOOL);
     get_overlapped_result_ex_t get_overlapped_result_ex =
         (get_overlapped_result_ex_t)GetProcAddress(GetModuleHandle("Kernel32.dll"),
                                                    "GetOverlappedResultEx");
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 44176936..6d482ef8 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1352,7 +1352,7 @@ win32_get_arch(arch_t *process_arch, arch_t *host_arch)
     *process_arch = ARCH_UNKNOWN;
     *host_arch = ARCH_NATIVE;
 
-    typedef BOOL (__stdcall *is_wow64_process2_t)(HANDLE, USHORT *, USHORT *);
+    typedef BOOL (WINAPI *is_wow64_process2_t)(HANDLE, USHORT *, USHORT *);
     is_wow64_process2_t is_wow64_process2 = (is_wow64_process2_t)
                                             GetProcAddress(GetModuleHandle("Kernel32.dll"), "IsWow64Process2");
 
-- 
2.38.1.windows.1


