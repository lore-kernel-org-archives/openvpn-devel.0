From: Arne Schwabe <arne@...1227...>
Date: Wed, 24 Mar 2021 23:23:29 +0100
Message-Id: <20210324222330.455-3-arne@...1227...>
In-Reply-To: <20210324222330.455-1-arne@...1227...>
References: <20210324222330.455-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 3/4] Fix socket related functions using int
 instead of socket_descriptor_t
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

On windows the SOCKET type is a UINT_PTR, which is a 64 bit pointer,
so using an int worked so far but is actually quite wrong.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/fdmisc.c |  8 ++++----
 src/openvpn/fdmisc.h | 10 +++++-----
 src/openvpn/mtu.c    |  2 +-
 src/openvpn/mtu.h    |  2 +-
 src/openvpn/socket.c | 16 ++++++++--------
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/src/openvpn/fdmisc.c b/src/openvpn/fdmisc.c
index 1cea505c..e0d198e5 100644
--- a/src/openvpn/fdmisc.c
+++ b/src/openvpn/fdmisc.c
@@ -36,7 +36,7 @@
 
 /* Set a file descriptor to non-blocking */
 bool
-set_nonblock_action(int fd)
+set_nonblock_action(socket_descriptor_t fd)
 {
 #ifdef _WIN32
     u_long arg = 1;
@@ -55,7 +55,7 @@ set_nonblock_action(int fd)
 
 /* Set a file descriptor to not be passed across execs */
 bool
-set_cloexec_action(int fd)
+set_cloexec_action(socket_descriptor_t fd)
 {
 #ifndef _WIN32
     if (fcntl(fd, F_SETFD, FD_CLOEXEC) < 0)
@@ -68,7 +68,7 @@ set_cloexec_action(int fd)
 
 /* Set a file descriptor to non-blocking */
 void
-set_nonblock(int fd)
+set_nonblock(socket_descriptor_t fd)
 {
     if (!set_nonblock_action(fd))
     {
@@ -78,7 +78,7 @@ set_nonblock(int fd)
 
 /* Set a file descriptor to not be passed across execs */
 void
-set_cloexec(int fd)
+set_cloexec(socket_descriptor_t fd)
 {
     if (!set_cloexec_action(fd))
     {
diff --git a/src/openvpn/fdmisc.h b/src/openvpn/fdmisc.h
index 0fb8b934..f4b67482 100644
--- a/src/openvpn/fdmisc.h
+++ b/src/openvpn/fdmisc.h
@@ -28,16 +28,16 @@
 #include "error.h"
 #include "syshead.h"
 
-bool set_nonblock_action(int fd);
+bool set_nonblock_action(socket_descriptor_t fd);
 
-bool set_cloexec_action(int fd);
+bool set_cloexec_action(socket_descriptor_t fd);
 
-void set_nonblock(int fd);
+void set_nonblock(socket_descriptor_t fd);
 
-void set_cloexec(int fd);
+void set_cloexec(socket_descriptor_t fd);
 
 static inline void
-openvpn_fd_set(int fd, fd_set *setp)
+openvpn_fd_set(socket_descriptor_t fd, fd_set *setp)
 {
 #ifndef _WIN32 /* The Windows FD_SET() implementation does not overflow */
     ASSERT(fd >= 0 && fd < FD_SETSIZE);
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 3ddeac76..3317c884 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -166,7 +166,7 @@ frame_print(const struct frame *frame,
 #define MTUDISC_NOT_SUPPORTED_MSG "--mtu-disc is not supported on this OS"
 
 void
-set_mtu_discover_type(int sd, int mtu_type, sa_family_t proto_af)
+set_mtu_discover_type(socket_descriptor_t sd, int mtu_type, sa_family_t proto_af)
 {
     if (mtu_type >= 0)
     {
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index 549c319b..0c8bdf8b 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -209,7 +209,7 @@ void frame_print(const struct frame *frame,
                  int level,
                  const char *prefix);
 
-void set_mtu_discover_type(int sd, int mtu_type, sa_family_t proto_af);
+void set_mtu_discover_type(socket_descriptor_t sd, int mtu_type, sa_family_t proto_af);
 
 int translate_mtu_discover_type_name(const char *name);
 
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index ebe8c85c..0d9b793c 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -846,7 +846,7 @@ mac_addr_safe(const char *mac_addr)
 }
 
 static int
-socket_get_sndbuf(int sd)
+socket_get_sndbuf(socket_descriptor_t sd)
 {
 #if defined(HAVE_GETSOCKOPT) && defined(SOL_SOCKET) && defined(SO_SNDBUF)
     int val;
@@ -863,7 +863,7 @@ socket_get_sndbuf(int sd)
 }
 
 static void
-socket_set_sndbuf(int sd, int size)
+socket_set_sndbuf(socket_descriptor_t sd, int size)
 {
 #if defined(HAVE_SETSOCKOPT) && defined(SOL_SOCKET) && defined(SO_SNDBUF)
     if (setsockopt(sd, SOL_SOCKET, SO_SNDBUF, (void *) &size, sizeof(size)) != 0)
@@ -874,7 +874,7 @@ socket_set_sndbuf(int sd, int size)
 }
 
 static int
-socket_get_rcvbuf(int sd)
+socket_get_rcvbuf(socket_descriptor_t sd)
 {
 #if defined(HAVE_GETSOCKOPT) && defined(SOL_SOCKET) && defined(SO_RCVBUF)
     int val;
@@ -891,7 +891,7 @@ socket_get_rcvbuf(int sd)
 }
 
 static bool
-socket_set_rcvbuf(int sd, int size)
+socket_set_rcvbuf(socket_descriptor_t sd, int size)
 {
 #if defined(HAVE_SETSOCKOPT) && defined(SOL_SOCKET) && defined(SO_RCVBUF)
     if (setsockopt(sd, SOL_SOCKET, SO_RCVBUF, (void *) &size, sizeof(size)) != 0)
@@ -904,7 +904,7 @@ socket_set_rcvbuf(int sd, int size)
 }
 
 static void
-socket_set_buffers(int fd, const struct socket_buffer_size *sbs)
+socket_set_buffers(socket_descriptor_t fd, const struct socket_buffer_size *sbs)
 {
     if (sbs)
     {
@@ -934,7 +934,7 @@ socket_set_buffers(int fd, const struct socket_buffer_size *sbs)
  */
 
 static bool
-socket_set_tcp_nodelay(int sd, int state)
+socket_set_tcp_nodelay(socket_descriptor_t sd, int state)
 {
 #if defined(_WIN32) || (defined(HAVE_SETSOCKOPT) && defined(IPPROTO_TCP) && defined(TCP_NODELAY))
     if (setsockopt(sd, IPPROTO_TCP, TCP_NODELAY, (void *) &state, sizeof(state)) != 0)
@@ -954,7 +954,7 @@ socket_set_tcp_nodelay(int sd, int state)
 }
 
 static inline void
-socket_set_mark(int sd, int mark)
+socket_set_mark(socket_descriptor_t sd, int mark)
 {
 #if defined(TARGET_LINUX) && HAVE_DECL_SO_MARK
     if (mark && setsockopt(sd, SOL_SOCKET, SO_MARK, (void *) &mark, sizeof(mark)) != 0)
@@ -965,7 +965,7 @@ socket_set_mark(int sd, int mark)
 }
 
 static bool
-socket_set_flags(int sd, unsigned int sockflags)
+socket_set_flags(socket_descriptor_t sd, unsigned int sockflags)
 {
     if (sockflags & SF_TCP_NODELAY)
     {
-- 
2.30.1


