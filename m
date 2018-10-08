From: Lev Stipakov <lstipakov@...277...>
Date: Mon,  8 Oct 2018 19:35:54 +0300
Message-Id: <1539016554-23503-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] interactive.c: fix usage of potentially
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
call free() on uninitialized pointer. Move pointer initialization above
jump and add NULL check before free() call.

To fix a few warnings which are treated as errors with SDL enabled,
initialize few pointers with a NULL.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpnserv/interactive.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 8f92c24..369980b 100644
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
@@ -1055,7 +1056,10 @@ netsh_dns_cmd(const wchar_t *action, const wchar_t *proto, const wchar_t *if_nam
     err = ExecCommand(argv0, cmdline, timeout);
 
 out:
-    free(cmdline);
+    if (cmdline)
+    {
+        free(cmdline);
+    }
     return err;
 }
 
@@ -1350,7 +1354,7 @@ RunOpenvpn(LPVOID p)
 {
     HANDLE pipe = p;
     HANDLE ovpn_pipe, svc_pipe;
-    PTOKEN_USER svc_user, ovpn_user;
+    PTOKEN_USER svc_user = NULL, ovpn_user = NULL;
     HANDLE svc_token = NULL, imp_token = NULL, pri_token = NULL;
     HANDLE stdin_read = NULL, stdin_write = NULL;
     HANDLE stdout_write = NULL;
-- 
2.7.4


