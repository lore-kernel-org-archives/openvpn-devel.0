From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
Date: Thu, 26 May 2011 17:35:29 +0300
Message-Id: <1306420529-5959-1-git-send-email-samuli@...515...>
In-Reply-To: <20110526135308.GU8496@...1296...>
References: <20110526135308.GU8496@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix problems with fixes to socket.c and
	win32.h
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Signed-off-by: Gert Doering <gert@...1296...>
Tested-by: Samuli Sepp=C3=A4nen <samuli@...515...>
Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 socket.c |    5 ++---
 win32.h  |    2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/socket.c b/socket.c
index 3d4801f..b1160d7 100644
--- a/socket.c
+++ b/socket.c
@@ -3157,7 +3157,7 @@ link_socket_write_udp_posix_sendmsg (struct link_sock=
et *sock,
  * WSAAddressToString() and WSAStringToAddress() functions
  */
=20
-/*
+#ifndef _MSC_VER
 const char *
 inet_ntop(int af, const void *src, char *dst, socklen_t size)
 {
@@ -3205,8 +3205,7 @@ inet_pton(int af, const char *src, void *dst)
   }
   return 0;
 }
-
-*/
+#endif
=20
 int
 socket_recv_queue (struct link_socket *sock, int maxsize)
diff --git a/win32.h b/win32.h
index 3b26bb1..528af6c 100644
--- a/win32.h
+++ b/win32.h
@@ -272,7 +272,7 @@ char *get_win_sys_path (void);
=20
 /* call self in a subprocess */
 void fork_to_self (const char *cmdline);
-#ifdef _MSV_VER
+#ifndef _MSC_VER
 const char *inet_ntop(int af, const void *src, char *dst, socklen_t size);
 int inet_pton(int af, const char *src, void *st);
 #endif
--=20
1.6.3.3


