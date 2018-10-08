From: Lev Stipakov <lstipakov@...277...>
Date: Mon,  8 Oct 2018 21:12:58 +0300
Message-Id: <1539022378-24485-1-git-send-email-lstipakov@...277...>
In-Reply-To: <20181008175242.GS962@...1296...>
References: <20181008175242.GS962@...1296...>
Subject: [Openvpn-devel] [PATCH v2] interactive.c: fix usage of potentially
 uninitialized variable
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

From: Lev Stipakov <lev@...515...>

In function netsh_dns_cmd() it is possible to jump on a label and
call free() on uninitialized pointer. Move pointer initialization
above jump.

To fix a few warnings which are treated as errors with SDL enabled,
initialize pointers with NULL.

Signed-off-by: Lev Stipakov <lev@...515...>
---
v2:
 - remove NULL check before free() call
 - remove unneeded NULL initializations in function body

 src/openvpnserv/interactive.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 8f92c24..4a571f5 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1015,6 +1015,7 @@ netsh_dns_cmd(const wchar_t *action, const wchar_t *proto, const wchar_t *if_nam
     DWORD err = 0;
     int timeout = 30000; /* in msec */
     wchar_t argv0[MAX_PATH];
+    wchar_t *cmdline = NULL;
 
     if (!addr)
     {
@@ -1039,7 +1040,7 @@ netsh_dns_cmd(const wchar_t *action, const wchar_t *proto, const wchar_t *if_nam
 
     /* max cmdline length in wchars -- include room for worst case and some */
     size_t ncmdline = wcslen(fmt) + wcslen(if_name) + wcslen(addr) + 32 + 1;
-    wchar_t *cmdline = malloc(ncmdline*sizeof(wchar_t));
+    cmdline = malloc(ncmdline*sizeof(wchar_t));
     if (!cmdline)
     {
         err = ERROR_OUTOFMEMORY;
@@ -1350,7 +1351,7 @@ RunOpenvpn(LPVOID p)
 {
     HANDLE pipe = p;
     HANDLE ovpn_pipe, svc_pipe;
-    PTOKEN_USER svc_user, ovpn_user;
+    PTOKEN_USER svc_user = NULL, ovpn_user = NULL;
     HANDLE svc_token = NULL, imp_token = NULL, pri_token = NULL;
     HANDLE stdin_read = NULL, stdin_write = NULL;
     HANDLE stdout_write = NULL;
@@ -1403,7 +1404,6 @@ RunOpenvpn(LPVOID p)
         goto out;
     }
     len = 0;
-    svc_user = NULL;
     while (!GetTokenInformation(svc_token, TokenUser, svc_user, len, &len))
     {
         if (GetLastError() != ERROR_INSUFFICIENT_BUFFER)
@@ -1436,7 +1436,6 @@ RunOpenvpn(LPVOID p)
         goto out;
     }
     len = 0;
-    ovpn_user = NULL;
     while (!GetTokenInformation(imp_token, TokenUser, ovpn_user, len, &len))
     {
         if (GetLastError() != ERROR_INSUFFICIENT_BUFFER)
-- 
2.7.4


