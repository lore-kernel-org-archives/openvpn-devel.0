From: Janne Johansson <jan.johansson@...1...>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-4XP8Q4niH8pY4vVf99xd"
Message-Id: <1017760165.9891.85.camel@...2...>
Mime-Version: 1.0
Subject: [Openvpn-devel] More BSD TUN info.
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Tue Apr  2 07:24:54 2002
To: openvpn-devel@lists.sourceforge.net

--=-4XP8Q4niH8pY4vVf99xd
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Sorry for "spamming" so much with my porting issues.

Now it seems that BSD (at least Free/OpenBSD) TUN devices send AF_INET
as a u_int32_t in network byte order first, which Linux tun-devs
dont.

That's why my last mail contains sending of "00000002" as the first
32 bits, it's telling the other end which AF to use.

When initiated from the Linux end, the BSD will say
"unknown address family" or something very similar, which is true
since it gets "45000054" as the first data.

Is there two types of tun or is the BSD tuns just slightly different and
incompatible by design?


--=20
Janne Johansson
jan.johansson@...1...
BioMat Systems AB
Klarabergsg 37 3tr
111 21 Stockholm


--=-4XP8Q4niH8pY4vVf99xd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8qcmkNJYxu+mj1OkRAhVFAKCZIgycq3eWWws8DtSkQZi2rOvEMwCgkEdH
J3IwfvbdYkTPK3qDP+1r6Tg=
=HJeB
-----END PGP SIGNATURE-----

--=-4XP8Q4niH8pY4vVf99xd--


