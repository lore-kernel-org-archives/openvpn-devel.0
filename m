From: Teemu Kiviniemi <teemuki@...124...>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-2NFCPlYpU6VT6gMZvBrz"
Message-Id: <1067453558.12713.238.camel@...125...>
Mime-Version: 1.0
Subject: [Openvpn-devel] OpenVPN --resolv-retry and --chroot problem
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Oct 29 10:54:07 2003
To: openvpn-devel@lists.sourceforge.net
Cc: James Yonan <jim@...41...>

--=-2NFCPlYpU6VT6gMZvBrz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

OpenVPN 1.5beta12 and the CVS version have a problem when --resolv-retry
and --chroot are used at the same time. In chroot environment,
gethostbyname() can't resolve the remote IP address:

Wed Oct 29 17:19:17 2003 13: RESOLVE: Cannot resolve host address:
somehost.somedomain: [unknown h_errno value]

This problem occurs with Debian Woody. I think it's related to the Glibc
dynamic loader. If the name resolver libraries aren't loaded before
OpenVPN enters the chroot jail, OpenVPN can't do any DNS queries. If
gethostbyname() is run before entering chroot(), the resolver libraries
are loaded and everything works as it should.

I changed link_socket_init_phase1() in socket.c to resolve the remote
host even if resolve_retry_seconds is set. That way, gethostbyname() is
run before chroot(). I don't know if that's the right way to do it, but
it fixes the problem for me.

The patch for 1.5 beta12 and the CVS version is available at:
http://iki.fi/teemuki/openvpn/openvpn-resolvfix.diff

Teemu


--=-2NFCPlYpU6VT6gMZvBrz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/oAx1q0EylM9fq6oRAnnHAJ0a1K3SqVjdXgt/F6TJ4qtKZLlquQCcDNxB
jtrJBeOCUZsEtLG3L3E8CIA=
=rkbX
-----END PGP SIGNATURE-----

--=-2NFCPlYpU6VT6gMZvBrz--


