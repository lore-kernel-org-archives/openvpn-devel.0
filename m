Date: Thu, 24 Mar 2011 23:58:28 +0100
From: JuanJo Ciarlante <jjo+ml@...410...>
Message-ID: <20110324225826.GB26539@...1453...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
Subject: [Openvpn-devel] [PATCH 2/3] ipv6-0.4.14: fix xinetd usage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

NOTE: this is patch 2/3 over feat_ipv6_transport branch,
      commit 1b96baa8fc964bfba8bfba87f1e0e1fbabf0b47b

  - closes http://bugs.debian.org/574164
  - also needed for --disable-ipv6 builds
  - supports IPv6 from xinetd


Signed-off-by: JuanJo Ciarlante <jjo@...410...>
---
 socket.c |   36 ++++++++++++++++++++++++++++++++++--
 1 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/socket.c b/socket.c
index 08cab0e..d9e6bc9 100644
--- a/socket.c
+++ b/socket.c
@@ -1680,7 +1680,11 @@ link_socket_init_phase1 (struct link_socket *sock,
   /* were we started by inetd or xinetd? */
   if (sock->inetd)
     {
-      ASSERT (sock->info.proto !=3D PROTO_TCPv4_CLIENT);
+      ASSERT (sock->info.proto !=3D PROTO_TCPv4_CLIENT
+#ifdef USE_PF_INET6
+	      && sock->info.proto !=3D PROTO_TCPv6_CLIENT
+#endif
+      );
       ASSERT (socket_defined (inetd_socket_descriptor));
       sock->sd =3D inetd_socket_descriptor;
     }
@@ -1729,7 +1733,34 @@ link_socket_init_phase2 (struct link_socket *sock,
   /* were we started by inetd or xinetd? */
   if (sock->inetd)
     {
-      if (sock->info.proto =3D=3D PROTO_TCPv4_SERVER)
+      if (sock->info.proto =3D=3D PROTO_TCPv4_SERVER
+#ifdef USE_PF_INET6
+	  || sock->info.proto =3D=3D PROTO_TCPv6_SERVER
+#endif
+      ) {
+	/* AF_INET as default (and fallback) for inetd */
+	sock->info.lsa->actual.dest.addr.sa.sa_family =3D AF_INET;
+#ifdef USE_PF_INET6
+#ifdef HAVE_GETSOCKNAME
+	  {
+	    /* inetd: hint family type for dest =3D local's */
+	    struct openvpn_sockaddr local_addr;
+	    socklen_t addrlen =3D sizeof(local_addr);
+	    if (getsockname (sock->sd, (struct sockaddr *)&local_addr, &addrlen) =
=3D=3D 0) {
+	      sock->info.lsa->actual.dest.addr.sa.sa_family =3D local_addr.addr.s=
a.sa_family;
+	      dmsg (D_SOCKET_DEBUG, "inetd(%s): using sa_family=3D%d from getsock=
name(%d)",
+		    proto2ascii(sock->info.proto, false), local_addr.addr.sa.sa_family,
+		    sock->sd);
+	    } else
+	      msg (M_WARN, "inetd(%s): getsockname(%d) failed, using AF_INET",
+		   proto2ascii(sock->info.proto, false), sock->sd);
+	  }
+#else
+	msg (M_WARN, "inetd(%s): this OS does not provide the getsockname() "
+	     "function, using AF_INET",
+	     proto2ascii(sock->info.proto, false));
+#endif
+#endif
 	sock->sd =3D
 	  socket_listen_accept (sock->sd,
 				&sock->info.lsa->actual,
@@ -1739,6 +1770,7 @@ link_socket_init_phase2 (struct link_socket *sock,
 				false,
 				sock->inetd =3D=3D INETD_NOWAIT,
 				signal_received);
+      }
       ASSERT (!remote_changed);
       if (*signal_received)
 	goto done;
--=20
1.7.1


--=20
--JuanJo
oO Juan Jose Ciarlante - juanjosec Ogmail.com - jjo O{um.edu.ar,google.com}
Oo gpg --keyserver wwwkeys.eu.pgp.net --recv-key 81276430

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk2LzJIACgkQo/fiSWZycXcpmwCeKwIh0cUnoEeVxzZGQ6jw4mlq
AE4AniPojGqms0hW5VkTQLSCFnA8GNZh
=8mpz
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--

