From: David Hollis <dhollis@...368...>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-h1e9q0kINz6sAaPTjp0o"
Message-Id: <1112822463.3662.16.camel@...369...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Proxy OpenVPN connection thru Apache SSL?
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Apr  6 14:23:45 2005
To: openvpn-devel@lists.sourceforge.net

--=-h1e9q0kINz6sAaPTjp0o
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I currently have OpenVPN running on the standard port of 1194 but at
some client sites, that port is blocked outbound.  In most of these
cases, I can access port 443 externally.  Would it be possible to setup
the Apache instance that I have running on 443 to proxy the connection
to 1194 so that OpenVPN will work essentially on port 1194 as well as
443?  I know that I can just change OpenVPN to listen on 443, but I
already have SSL based web services there and can't relocate them.=20=20

--=20
David Hollis <dhollis@...368...>

--=-h1e9q0kINz6sAaPTjp0o
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCVFK+xasLqOyGHncRAnBQAJ40aVknknMIVzpvtS//mfH7K8iTzACfeCWD
h+cWKeJgNXxV2sAbZIsqlJw=
=weEz
-----END PGP SIGNATURE-----

--=-h1e9q0kINz6sAaPTjp0o--


