From: Arne Schwabe <arne@...1227...>
Date: Mon, 20 Feb 2023 14:14:24 +0100
Message-Id: <20230220131424.1749736-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Exit if a proper message instead of
 segfault on Android without management
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

The Android implementation is relying on the management interface to be
always available. Trying to run the Android binary without the mangament
interface outside the app leads to a segfault. Exit with a FATAL error
instead.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/manage.c | 4 ++++
 src/openvpn/socket.c | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 3ea1992b0..db88e3479 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2192,6 +2192,10 @@ man_recv_with_fd(int fd, void *ptr, size_t nbytes, int flags, int *recvfd)
 bool
 management_android_control(struct management *man, const char *command, const char *msg)
 {
+    if (!man)
+    {
+        msg(M_FATAL, "Required management interface not available.");
+    }
     struct user_pass up;
     CLEAR(up);
     strncpy(up.username, msg, sizeof(up.username)-1);
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 42d953390..eff21ca56 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1161,6 +1161,11 @@ create_socket(struct link_socket *sock, struct addrinfo *addr)
 static void
 protect_fd_nonlocal(int fd, const struct sockaddr *addr)
 {
+    if (!management)
+    {
+        msg(M_FATAL, "Required management interface not available.")
+    }
+
     /* pass socket FD to management interface to pass on to VPNService API
      * as "protected socket" (exempt from being routed into tunnel)
      */
-- 
2.37.1 (Apple Git-137.1)


