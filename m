Date: Sun, 6 Apr 2014 10:53:11 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140406085311.GH16637@...1296...>
References: <20140406083549.GG16637@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A5c6bdJn5A3K/zIE"
Content-Disposition: inline
In-Reply-To: <20140406083549.GG16637@...1296...>
Subject: Re: [Openvpn-devel] getaddrinfo() confusion / way forward?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--A5c6bdJn5A3K/zIE
Content-Type: multipart/mixed; boundary="bvJdNHiH+WoPrK1d"
Content-Disposition: inline

--bvJdNHiH+WoPrK1d
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Apr 06, 2014 at 10:35:49AM +0200, Gert Doering wrote:
> One possible approach would be to add this hack to the end of=20
> openvpn_getaddrinfo():

A slightly simpler version of this could go to the beginning of
create_socket() (--> no ai_next chain walking needed, etc.).

Patch attached.  With that patch in place, my OpenSolaris machine passes
all my test cases.  So functionally it's ok, just "philosophically" one
might argue :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--bvJdNHiH+WoPrK1d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Work-around-Solaris-getaddrinfo-returing-ai_protoc.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 841ea45456e93f973be3f486a30549d35d9cade1 Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Sun, 6 Apr 2014 10:44:38 +0200
Subject: [PATCH] Work around Solaris getaddrinfo() returing ai_protocol=3D0

Create_socket() and sub-functions assume that the ai_protocol value
returned by getaddrinfo() is IPPROTO_UDP or IPPROTO_TCP.  On Solaris,
it is "0", because Solaris's socket() call will then "select the right
protocol" - but it breaks our code.  So if ai_protocol is 0, set the
IPPROTO_* value according to ai_socktype (SOCK_DGRAM/SOCK_STREAM).

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/socket.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 7deef0a..75dde7e 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -858,6 +858,19 @@ static void bind_local (struct link_socket *sock, cons=
t sa_family_t ai_family)
 static void
 create_socket (struct link_socket* sock, struct addrinfo* addr)
 {
+#ifdef TARGET_SOLARIS
+  /* fixup Solaris' getaddrinfo() returning ai_protocol=3D0=20
+   */
+  if (addr->ai_protocol =3D=3D 0 )
+    {
+      msg( M_WARN, "invoking Solaris ai_protocol=3D=3D0 fixup" );
+      if( addr->ai_socktype =3D=3D SOCK_DGRAM )
+          addr->ai_protocol =3D IPPROTO_UDP;
+      else
+	  addr->ai_protocol =3D IPPROTO_TCP;
+    }
+#endif
+
   if (addr->ai_protocol =3D=3D IPPROTO_UDP)
     {
       sock->sd =3D create_socket_udp (addr, sock->sockflags);
--=20
1.5.6.5


--bvJdNHiH+WoPrK1d--

--A5c6bdJn5A3K/zIE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU0EV96kuBuNlUUl1AQJdUgQAqmYX5qGDjiUvukaho7UkM0Sj4THUavIa
gfDGwfZrByPG//qoNYVsekFxmyLv+5kOKu1pjc7waDyZeR0xELXoPrism88Qdjg3
motv5isfgKz6uNqIVLyE3+m26aS3UGSqxB1p+cIcwWTtkXiDxJ6gj8Qeu4ThPwmu
Hc/GUNOT17k=
=1nsY
-----END PGP SIGNATURE-----

--A5c6bdJn5A3K/zIE--

