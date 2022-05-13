From: Gert Doering <gert@...1296...>
Date: Fri, 13 May 2022 12:15:26 +0200
Message-Id: <20220513101526.11486-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Pass proper sockaddr_* structure for IPv6
 socket errors.
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

commit 043c67f363429 enhances format_extended_socket_error() by
recognizing IPv6 extended socket errors, but neglected to change
the "sockaddr_in" buffer passed to recvmsg() to "sockaddr_storage".

According to documentation, recvmsg() should not have overrun
that structure (we pass the size of the struct), but according to
ASAN it does... so, pass the correct structure.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/mtu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 93feaff1..84310349 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -312,7 +312,7 @@ format_extended_socket_error(int fd, int *mtu, struct gc_arena *gc)
     struct msghdr msg;
     struct cmsghdr *cmsg;
     struct sock_extended_err *e;
-    struct sockaddr_in addr;
+    struct sockaddr_storage addr;
     struct buffer out = alloc_buf_gc(256, gc);
     char *cbuf = (char *) gc_malloc(256, false, gc);
 
-- 
2.35.1


