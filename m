From: Guus Sliepen <guus@...126...>
Message-ID: <20031027161456.GN25238@...126...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bFUYW7mPOLJ+Jd2A"
Content-Disposition: inline
Subject: [Openvpn-devel] Splitting functionality of VPN daemons
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
Date: Mon Oct 27 08:16:20 2003
To: tinc-devel@...127..., openvpn-devel@lists.sourceforge.net, vpn@...128...

--bFUYW7mPOLJ+Jd2A
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

Today there are lots of VPN implementations, each having their strengths
and weaknesses. In particular, OpenVPN has focussed on creating tunnels
using standards such as SSL/TLS and ESP and provides better security
than many other VPN implementations. Tinc on the other hand is probably
the only VPN daemon that handles multiple tunnels on one tun/tap device,
using built-in routing. In order to allow both projects (and maybe
others) to combine their efforts in a manageable way, their should be a
standardised API, so that code can be reused without having to change it.
You can find a concept here:

http://sliepen.eu.org/~guus/vpnsplit.html

This is by no means finished, your input is greatly appreciated.

--=20
Met vriendelijke groet / with kind regards,
    Guus Sliepen <guus@...126...>

--bFUYW7mPOLJ+Jd2A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/nUSAAxLow12M2nsRAt22AKCsl/t7WE/ODPmbjkGcOH9r39qeWgCeKlfr
RDuubF8GEZeQ9kp5S97mKHM=
=papI
-----END PGP SIGNATURE-----

--bFUYW7mPOLJ+Jd2A--

