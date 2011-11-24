Date: Thu, 24 Nov 2011 21:11:09 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20111124201109.GR8496@...1296...>
References: <4e6f25dc2a58c3.42657146@...1498...> <4E801FAE.5010700@...515...>
	<4E806C6A.9090907@...515...>
	<201109261437.45686.heiko.hund@...1489...>
	<4EBA6F45.2030006@...515...>
	<20111124195128.GE2555@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZewgRHh93g6NDxMQ"
Content-Disposition: inline
In-Reply-To: <20111124195128.GE2555@...1296...>
Subject: Re: [Openvpn-devel]
	Snapshot	openvpn-2.x-20110909-master-install.exe fails
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--ZewgRHh93g6NDxMQ
Content-Type: multipart/mixed; boundary="RgdcFU/bNVxoXiYo"
Content-Disposition: inline

--RgdcFU/bNVxoXiYo
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Nov 24, 2011 at 08:51:28PM +0100, Gert Doering wrote:
> So here's the patch - it compiles (MSVC on Win7), the resulting binary
> works on WinXP, and it's not too ugly - actually it removes more #ifdef's
> that it adds...
>=20
> Let me know your comments.

So David found it confusing, and I agree to some extend :-) - it's
easier to see what is happening if we declare our replacement functions
as openvpn_inet_ntop() and openvpn_inet_pton() right away, instead of
having the preprocessor #define rename them on the fly.

new patch.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--RgdcFU/bNVxoXiYo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-work-around-inet_ntop-inet_pton-problems-for-MSVC-bu.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 0d49be3449e86365364378f48393e5e2b75a1045 Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Thu, 24 Nov 2011 21:09:36 +0100
Subject: [PATCH] work around inet_ntop/inet_pton problems for MSVC builds on
 WinXP

always use our built-in replacement functions now, even if building
on Win7 (which has inet_ntop/inet_pton in the system libraries) because
the resulting binary will then fail on WinXP.

Signed-off-by: Gert Doering <gert@...1296...>
---
 socket.c |    9 ++++-----
 win32.h  |   10 ++++++----
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/socket.c b/socket.c
index 5302eca..c8a86ea 100644
--- a/socket.c
+++ b/socket.c
@@ -3083,11 +3083,12 @@ link_socket_write_udp_posix_sendmsg (struct link_so=
cket *sock,
 /*
  * inet_ntop() and inet_pton() wrap-implementations using
  * WSAAddressToString() and WSAStringToAddress() functions
+ *
+ * this is needed as long as we support running OpenVPN on WinXP
  */
=20
-#ifndef _MSC_VER
 const char *
-inet_ntop(int af, const void *src, char *dst, socklen_t size)
+openvpn_inet_ntop(int af, const void *src, char *dst, socklen_t size)
 {
   struct sockaddr_storage ss;
   unsigned long s =3D size;
@@ -3111,7 +3112,7 @@ inet_ntop(int af, const void *src, char *dst, socklen=
_t size)
 }
=20
 int
-inet_pton(int af, const char *src, void *dst)
+openvpn_inet_pton(int af, const char *src, void *dst)
 {
   struct sockaddr_storage ss;
   int size =3D sizeof(ss);
@@ -3134,8 +3135,6 @@ inet_pton(int af, const char *src, void *dst)
   return 0;
 }
=20
-#endif
-
 int
 socket_recv_queue (struct link_socket *sock, int maxsize)
 {
diff --git a/win32.h b/win32.h
index 5b18e3c..0607cad 100644
--- a/win32.h
+++ b/win32.h
@@ -278,10 +278,12 @@ char *get_win_sys_path (void);
=20
 /* call self in a subprocess */
 void fork_to_self (const char *cmdline);
-#ifndef _MSC_VER
-const char *inet_ntop(int af, const void *src, char *dst, socklen_t size);
-int inet_pton(int af, const char *src, void *st);
-#endif
+
+const char *openvpn_inet_ntop(int af, const void *src,=20
+                              char *dst, socklen_t size);
+int openvpn_inet_pton(int af, const char *src, void *dst);
+#define inet_ntop(af,src,dst,size) openvpn_inet_ntop(af,src,dst,size)
+#define inet_pton(af,src,dst)      openvpn_inet_pton(af,src,dst)
=20
 /* Find temporary directory */
 const char *win_get_tempdir();
--=20
1.7.4.4


--RgdcFU/bNVxoXiYo--

--ZewgRHh93g6NDxMQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTs6k3akuBuNlUUl1AQKVgAQAnDiZGPZvIk6CyGF4Lu9PlF1Pns5hGgit
nXVTD0qmuLy7TaX6sS2VkEjUbsNibauzUME4hR12/mKTes+O10ULbGw3/mO/37zF
5WsyPlvpBNywC6BlemnGousQdqtzy3jYRk3uNi1vYiGaEQIzAeeLmjN0x9dUvsbQ
F2c9Znk7GQo=
=StbP
-----END PGP SIGNATURE-----

--ZewgRHh93g6NDxMQ--

