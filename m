From: Arne Schwabe <arne@...1227...>
Date: Tue,  5 Jan 2021 14:17:58 +0100
Message-Id: <20210105131758.20311-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Zero initialise msghdr prior to calling
 sendmesg
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

This ensure that all unused fields in msg are zero.

Spotted by Coverity:

Using uninitialized value "msg". Field "msg.msg_flags" is uninitialized
when calling "sendmsg".
---
 src/openvpn/manage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index a4f99c9a..103ccadc 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2092,7 +2092,7 @@ man_io_error(struct management *man, const char *prefix)
 static ssize_t
 man_send_with_fd(int fd, void *ptr, size_t nbytes, int flags, int sendfd)
 {
-    struct msghdr msg;
+    struct msghdr msg = {0};
     struct iovec iov[1];
 
     union {
@@ -2124,7 +2124,7 @@ man_send_with_fd(int fd, void *ptr, size_t nbytes, int flags, int sendfd)
 static ssize_t
 man_recv_with_fd(int fd, void *ptr, size_t nbytes, int flags, int *recvfd)
 {
-    struct msghdr msghdr;
+    struct msghdr msghdr = {0};
     struct iovec iov[1];
     ssize_t n;
 
-- 
2.26.2


