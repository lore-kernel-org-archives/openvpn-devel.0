From: Janne Johansson <jan.johansson@...1...>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-SWVGJcAsX/ZyUEWydFm5"
Message-Id: <1017749577.9891.42.camel@...2...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Success with my OBSD diffs.
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
Date: Tue Apr  2 04:28:15 2002
To: openvpn-devel@lists.sourceforge.net

--=-SWVGJcAsX/ZyUEWydFm5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I have now pinged between linux2.4 with openvpn1.0.3 and openbsd3.0
running the version that comes out of my diff.

There is need for a small readme, since ifconfig differs on bsd
but apart from that, everything went smoothly after some initial
mistesting on my part. =3D)
It was done on an unencrypted channel, but since --keygen worked
without problems, I can't see how ssl would pose a problem.

I'll get back to you when I have tested ssl.

--=20
Janne Johansson
jan.johansson@...1...
BioMat Systems AB
Klarabergsg 37 3tr
111 21 Stockholm


--=-SWVGJcAsX/ZyUEWydFm5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8qaBINJYxu+mj1OkRArBDAJ9wgTg1dzb2VFrh6u6P5wkoDdsR4wCeJx1a
Si0IW1qLZ/ht+DJhbi02aYQ=
=Y3b1
-----END PGP SIGNATURE-----

--=-SWVGJcAsX/ZyUEWydFm5--


