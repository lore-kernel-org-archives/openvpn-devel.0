From: Jan Johansson <jan.johansson@...1...>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-37ygDqbSHB8AvtJRY0dH"
Message-Id: <1024320139.1336.17.camel@...2...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Small thought.
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
Date: Mon Jun 17 06:23:04 2002
To: openvpn-devel@lists.sourceforge.net

--=-37ygDqbSHB8AvtJRY0dH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The redhat-initscript (well, linuxish initscript) that comes in the
sample-scripts (openvpn.init) really needs to have $prefix somewhere,
since it does count on you installing openvpn in /usr/sbin, though
configure puts everything in /usr/local by default.

--=20
Jan Johansson (jan.johansson@...1...)
BioMat System AB
Klarabergsgatan 37, III
SE-111 21 Stockholm, Sweden
Phone: +46-(0)8-233500, Fax: +46-(0)70-3873952

THIS COMMUNICATION IS ONLY INTENDED FOR THE USE OF THE INDIVIDUAL, OR
ENTITY, TO WHICH IT IS DIRECTED AND MAY CONTAIN INFORMATION THAT IS
PRIVILEGED, CONFIDENTIAL AND EXEMPT FROM DISCLOSURE UNDER APPLICABLE
LAW.  IF RECEIVED IN ERROR: PLEASE NOTIFY US IMMEDIATELY THROUGH
INFO@...25...

--=-37ygDqbSHB8AvtJRY0dH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9DeKLNJYxu+mj1OkRAluAAJ9M3FOyDL5z/LM55A0VKOYzhxidJACfYubs
0AO1IrRndGclXUuNm/1Usog=
=LvfS
-----END PGP SIGNATURE-----

--=-37ygDqbSHB8AvtJRY0dH--


