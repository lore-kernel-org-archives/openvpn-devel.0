From: selva.nair@...277...
Date: Wed, 19 Feb 2020 20:56:43 -0500
Message-Id: <1582163803-3342-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix possible access of uninitialized pipe
 handles
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

Compile time warning for openvpnserv.exe
interactive.c: In function ‘RunOpenvpn’:
interactive.c:160:27: warning: ‘svc_pipe’ may be used uninitialized in
this function [-Wmaybe-uninitialized]

When RunOpenvpn exits early due to errors, uninitialized svc_pipe and
ovpn_pipe vars could get passed to CloseHandleEx(). Fix by initializing
to NULL.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpnserv/interactive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 710f9c7..8da49be 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1468,7 +1468,7 @@ static DWORD WINAPI
 RunOpenvpn(LPVOID p)
 {
     HANDLE pipe = p;
-    HANDLE ovpn_pipe, svc_pipe;
+    HANDLE ovpn_pipe = NULL, svc_pipe = NULL;
     PTOKEN_USER svc_user = NULL, ovpn_user = NULL;
     HANDLE svc_token = NULL, imp_token = NULL, pri_token = NULL;
     HANDLE stdin_read = NULL, stdin_write = NULL;
-- 
2.1.4


