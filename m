From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
Date: Thu, 26 May 2011 16:23:02 +0300
Message-Id: <1306416185-4901-2-git-send-email-samuli@...515...>
In-Reply-To: <1306416185-4901-1-git-send-email-samuli@...515...>
References: <1306416185-4901-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/4] Fixed a number of fatal build errors on
	Visual Studio 2008
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

Partially fixes ticket #137

Signed-off-by: Gert Doering <gert@...1296...>
Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
Tested-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 helper.c        |   12 ++++++------
 socket.c        |    4 ++++
 win/config.h.in |    2 +-
 win32.h         |    2 ++
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/helper.c b/helper.c
index 266b246..c7333f6 100644
--- a/helper.c
+++ b/helper.c
@@ -143,6 +143,12 @@ helper_client_server (struct options *o)
 #if P2MP
 #if P2MP_SERVER
=20
+/*
+   * Get tun/tap/null device type
+   */
+  const int dev =3D dev_type_enum (o->dev, o->dev_type);
+  const int topology =3D o->topology;
+
   /*=20
    *
    * HELPER DIRECTIVE for IPv6
@@ -220,12 +226,6 @@ helper_client_server (struct options *o)
    *   push "route-gateway 10.8.0.1"
    */
=20
-  /*
-   * Get tun/tap/null device type
-   */
-  const int dev =3D dev_type_enum (o->dev, o->dev_type);
-  const int topology =3D o->topology;
-
   if (o->server_defined)
     {
       int netbits =3D -2;
diff --git a/socket.c b/socket.c
index 6b855c0..3d4801f 100644
--- a/socket.c
+++ b/socket.c
@@ -3156,6 +3156,8 @@ link_socket_write_udp_posix_sendmsg (struct link_sock=
et *sock,
  * inet_ntop() and inet_pton() wrap-implementations using
  * WSAAddressToString() and WSAStringToAddress() functions
  */
+
+/*
 const char *
 inet_ntop(int af, const void *src, char *dst, socklen_t size)
 {
@@ -3204,6 +3206,8 @@ inet_pton(int af, const char *src, void *dst)
   return 0;
 }
=20
+*/
+
 int
 socket_recv_queue (struct link_socket *sock, int maxsize)
 {
diff --git a/win/config.h.in b/win/config.h.in
index 82344a0..ec447a2 100644
--- a/win/config.h.in
+++ b/win/config.h.in
@@ -275,7 +275,7 @@ typedef unsigned long in_addr_t;
 #define inline __inline
=20
 /* type to use in place of socklen_t if not defined */
-#define socklen_t unsigned int
+/*#define socklen_t unsigned int*/
=20
 #ifndef __MINGW32__
 /* 32-bit unsigned type */
diff --git a/win32.h b/win32.h
index d0ecc85..3b26bb1 100644
--- a/win32.h
+++ b/win32.h
@@ -272,8 +272,10 @@ char *get_win_sys_path (void);
=20
 /* call self in a subprocess */
 void fork_to_self (const char *cmdline);
+#ifdef _MSV_VER
 const char *inet_ntop(int af, const void *src, char *dst, socklen_t size);
 int inet_pton(int af, const char *src, void *st);
+#endif
=20
 /* Find temporary directory */
 const char *win_get_tempdir();
--=20
1.6.3.3


