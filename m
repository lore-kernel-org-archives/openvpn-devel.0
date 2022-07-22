From: selva.nair@...277...
Date: Fri, 22 Jul 2022 16:40:07 -0400
Message-Id: <20220722204007.7537-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] In x_check_status() read errno early
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

The correct errno can get overwritten by the call to
format_extended_socket_error() which may set errno to EAGAIN
losing the original error and cause to bypass the error reporting
below. Fix by reading the errno of interest at the top of the
function.

Reported by: Gert Doering <gert@...1296...>
Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/error.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 49ed1dbc..7cd35b17 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -658,6 +658,9 @@ x_check_status(int status,
 {
     const char *extended_msg = NULL;
 
+    bool crt_error = false;
+    int my_errno = openvpn_errno_maybe_crt(&crt_error);
+
     msg(x_cs_verbose_level, "%s %s returned %d",
         sock ? proto2ascii(sock->info.proto, sock->info.af, true) : "",
         description,
@@ -688,9 +691,6 @@ x_check_status(int status,
         }
 #endif
 
-        bool crt_error = false;
-        int my_errno = openvpn_errno_maybe_crt(&crt_error);
-
         if (!ignore_sys_error(my_errno, crt_error))
         {
             if (extended_msg)
-- 
2.30.2


