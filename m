Date: Mon, 7 Apr 2014 22:17:11 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140407201711.GN16637@...1296...>
References: <20140406083549.GG16637@...1296...>
	<20140406085311.GH16637@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3RKAbZK0qz+F2aAj"
Content-Disposition: inline
In-Reply-To: <20140406085311.GH16637@...1296...>
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

--3RKAbZK0qz+F2aAj
Content-Type: multipart/mixed; boundary="n4EeF/xh1NKEk5gA"
Content-Disposition: inline

--n4EeF/xh1NKEk5gA
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Apr 06, 2014 at 10:53:11AM +0200, Gert Doering wrote:
> A slightly simpler version of this could go to the beginning of
> create_socket() (--> no ai_next chain walking needed, etc.).

Arne suggested an even more simple version of this - which is convincing,
because it takes away lines of code, instead of adding more :-)

Patch attached.  (Tested, works!)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--n4EeF/xh1NKEk5gA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Work-around-Solaris-getaddrinfo-returing-ai_protoc.patch"
Content-Transfer-Encoding: quoted-printable

=46rom a9b7c4e0fcdf89efb71a910c2295c6158113a732 Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Mon, 7 Apr 2014 22:12:05 +0200
Subject: [PATCH] Work around Solaris getaddrinfo() returing ai_protocol=3D0

Create_socket() and sub-functions assume that the ai_protocol value
returned by getaddrinfo() is IPPROTO_UDP or IPPROTO_TCP.  On Solaris,
it is "0", because Solaris's socket() call will then "select the right
protocol" - but it breaks our code.  So remove ASSERT()s on ai_protocol,
and also accept properly set ai_socktype (SOCK_DGRAM/SOCK_STREAM) values
if ai_protocol is not set.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/socket.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 7deef0a..ed4bc6f 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -775,7 +775,6 @@ create_socket_tcp (struct addrinfo* addrinfo)
=20
   ASSERT (addrinfo);
   ASSERT (addrinfo->ai_socktype =3D=3D SOCK_STREAM);
-  ASSERT (addrinfo->ai_protocol =3D=3D IPPROTO_TCP);
=20
   if ((sd =3D socket (addrinfo->ai_family, addrinfo->ai_socktype, addrinfo=
->ai_protocol)) < 0)
     msg (M_ERR, "Cannot create TCP socket");
@@ -800,7 +799,6 @@ create_socket_udp (struct addrinfo* addrinfo, const uns=
igned int flags)
=20
   ASSERT (addrinfo);
   ASSERT (addrinfo->ai_socktype =3D=3D SOCK_DGRAM);
-  ASSERT (addrinfo->ai_protocol =3D=3D IPPROTO_UDP);
=20
   if ((sd =3D socket (addrinfo->ai_family, addrinfo->ai_socktype, addrinfo=
->ai_protocol)) < 0)
     msg (M_ERR, "UDP: Cannot create UDP/UDP6 socket");
@@ -858,7 +856,7 @@ static void bind_local (struct link_socket *sock, const=
 sa_family_t ai_family)
 static void
 create_socket (struct link_socket* sock, struct addrinfo* addr)
 {
-  if (addr->ai_protocol =3D=3D IPPROTO_UDP)
+  if (addr->ai_protocol =3D=3D IPPROTO_UDP || addr->ai_socktype =3D=3D SOC=
K_DGRAM)
     {
       sock->sd =3D create_socket_udp (addr, sock->sockflags);
       sock->sockflags |=3D SF_GETADDRINFO_DGRAM;
@@ -878,7 +876,7 @@ create_socket (struct link_socket* sock, struct addrinf=
o* addr)
 	}
 #endif
     }
-  else if (addr->ai_protocol =3D=3D IPPROTO_TCP)
+  else if (addr->ai_protocol =3D=3D IPPROTO_TCP || addr->ai_socktype =3D=
=3D SOCK_STREAM)
     {
       sock->sd =3D create_socket_tcp (addr);
     }
@@ -1806,7 +1804,6 @@ phase2_tcp_client (struct link_socket *sock, struct s=
ignal_info *sig_info)
   const bool proxy_retry =3D false;
 #endif
   do {
-    ASSERT (sock->info.lsa->current_remote->ai_protocol =3D=3D IPPROTO_TCP=
);
     socket_connect (&sock->sd,
                    sock->info.lsa->current_remote->ai_addr,
                    sock->connect_timeout,
--=20
1.5.6.5


--n4EeF/xh1NKEk5gA--

--3RKAbZK0qz+F2aAj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU0MHxqkuBuNlUUl1AQKQ1AQAqtjIvafr6MARCJK3TL+rKu1jPKln8x2T
kc6f6+a8ISWaXas7QKk/PTQuIpvQSswaiavPI1Ecf86W+be7IoC6BJVlsOQv17Tv
25TeXg6icPcNwqZTTvIH+024YXSNPlAP48h6k/Lv9Tns/J/y5j30zk7bHy9zQmHJ
D94dHqKWfjQ=
=51vN
-----END PGP SIGNATURE-----

--3RKAbZK0qz+F2aAj--

