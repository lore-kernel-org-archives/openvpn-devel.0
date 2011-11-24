Date: Thu, 24 Nov 2011 20:51:28 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20111124195128.GE2555@...1296...>
References: <4e6f25dc2a58c3.42657146@...1498...> <4E801FAE.5010700@...515...>
	<4E806C6A.9090907@...515...>
	<201109261437.45686.heiko.hund@...1489...>
	<4EBA6F45.2030006@...515...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yH1ZJFh+qWm+VodA"
Content-Disposition: inline
In-Reply-To: <4EBA6F45.2030006@...515...>
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

--yH1ZJFh+qWm+VodA
Content-Type: multipart/mixed; boundary="vv4Sf/kQfcwinyKX"
Content-Disposition: inline

--vv4Sf/kQfcwinyKX
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 09, 2011 at 02:17:09PM +0200, Samuli Sepp=E4nen wrote:
> Il 26/09/2011 15:37, Heiko Hund ha scritto:
> > On Monday 26 September 2011 14:13:30 Samuli Sepp=E4nen wrote:
> >> Ok, did as suggested for socket.c and win32.h and got the following
> >> build failure using MSVC:
> >>
> >> <http://pastebin.com/xZ8J2yrq>
> > ---8<------------------------------------------------------------------
> > c:\users\samuli\openvpn-build\openvpn\win32.h(282) :=20
> > error C2373: 'inet_ntop' : redefinition; different type modifiers
> > ---8<------------------------------------------------------------------

after discussions with Samuli and Heiko, I propose to solve this in a
different way, namely "always use our own version of inet_ntop/inet_pton,
and do not even try to keep the prototypes right on windows".

That is, I #define inet_ntop() to openvpn_inet_ntop() and inet_pton()
to openvpn_inet_pton(), and thus change all the function calls to call
our own function on "#ifdef WIN32" builds.

Trying to keep the function names and playing with prototypes didn't
lead anywhere, and trying to play with the NTDDI_VERSION defines is
far beyond the level of detail I want to know about Windows building.

So here's the patch - it compiles (MSVC on Win7), the resulting binary
works on WinXP, and it's not too ugly - actually it removes more #ifdef's
that it adds...

Let me know your comments.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--vv4Sf/kQfcwinyKX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-work-around-inet_ntop-inet_pton-problems-for-MSVC-bu.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 853662a6d1f5ad90e8d73032cea137541f6194e2 Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Thu, 24 Nov 2011 19:48:27 +0100
Subject: [PATCH] work around inet_ntop/inet_pton problems for MSVC builds on
 WinXP

always use our built-in replacement functions now, even if building
on Win7 (which has inet_ntop/inet_pton in the system libraries) because
the resulting binary will then fail on WinXP.

Signed-off-by: Gert Doering <gert@...1296...>
---
 socket.c |    3 ---
 win32.h  |   10 ++++++----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/socket.c b/socket.c
index 5302eca..d91f2dc 100644
--- a/socket.c
+++ b/socket.c
@@ -3085,7 +3085,6 @@ link_socket_write_udp_posix_sendmsg (struct link_sock=
et *sock,
  * WSAAddressToString() and WSAStringToAddress() functions
  */
=20
-#ifndef _MSC_VER
 const char *
 inet_ntop(int af, const void *src, char *dst, socklen_t size)
 {
@@ -3134,8 +3133,6 @@ inet_pton(int af, const char *src, void *dst)
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


--vv4Sf/kQfcwinyKX--

--yH1ZJFh+qWm+VodA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTs6gQKkuBuNlUUl1AQIqwAP+MBzx0ONbBXv+CayPslc52uBfthm/+nOr
2gbESzgf+cv8xA0wRy8Da4AJBdK1hSIfzNOIj5b5gzqO91cxQmyVYBRmDyC916Ui
2wP5WNDeCef+M/9sRp6tCx13gukVJlF8PFKDjCcSKsFv5jBO7cZ4R9NH6YcQG8nw
xrj5B3Z17QY=
=yq7/
-----END PGP SIGNATURE-----

--yH1ZJFh+qWm+VodA--

