From: Heiko Hund <heiko.hund@...1489...>
Date: Fri, 13 Jul 2012 11:55:17 +0200
Message-ID: <1342173317-8542-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] make non-blocking connect work on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Instead of EINPROGRESS WinSock2 returns WSAEWOULDBLOCK if a non-blocking
connect(2) cannot be completed immediately.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 configure.ac         |    2 ++
 src/openvpn/socket.c |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index d3d974d..ba5dce1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -617,6 +617,7 @@ m4_define(
 	[setsockopt getsockopt getsockname poll]dnl
 )
 if test "${WIN32}" = "yes"; then
+	AC_DEFINE([CONNECT_IN_PROGRESS], [WSAEWOULDBLOCK], [errno for incomplete non-blocking connect(2)])
 	m4_foreach(
 		[F],
 		m4_split(SOCKET_FUNCS SOCKET_OPT_FUNCS),
@@ -624,6 +625,7 @@ if test "${WIN32}" = "yes"; then
 			AC_DEFINE([UF], [1], [Win32 builtin])
 	)
 else
+	AC_DEFINE([CONNECT_IN_PROGRESS], [EINPROGRESS], [errno for incomplete non-blocking connect(2)])
 	AC_CHECK_FUNCS(
 		SOCKET_FUNCS,
 		,
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 54ebce7..b2d6bba 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1165,7 +1165,7 @@ openvpn_connect (socket_descriptor_t sd,
   status = connect (sd, &remote->addr.sa, af_addr_size(remote->addr.sa.sa_family));
   if (status)
     status = openvpn_errno_socket ();
-  if (status == EINPROGRESS)
+  if (status == CONNECT_IN_PROGRESS)
     {
       while (true)
 	{
-- 
1.7.9.5


