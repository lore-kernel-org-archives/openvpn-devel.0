Message-ID: <487CDF08.3070002@...1115...>
Date: Tue, 15 Jul 2008 11:31:52 -0600
From: Joshua Rubin <joshua@...1115...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig00BCB75888A220F0A4A51296"
Subject: [Openvpn-devel] IPv6 Feature Request
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig00BCB75888A220F0A4A51296
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

I understand that OpenVPN has some support for IPv6. I presently use=20
IPv6 through OpenVPN with the tap interface and it works well.

However, my environment uses ifconfig-push so that I can maintain=20
central control over the assigned IPs. I would really like to be able to=20
push IPv6 address and redirect IPv6 routes in the same way.

I understand that all ifconfig, route and server (including push/pull=20
commands) are still strictly IPv4 centric [1].

I currently work around my problem with a route-up script, but this=20
eliminates centralized IP management.

I am just wondering what the plans for adding such features to OpenVPN are.

I hope this has not been asked often/recently. I have searched and only=20
came up with discussions several years old.

Thank you very much for such a great product!!!

Joshua Rubin

Footnotes:
[1] http://openvpn.net/archive/openvpn-devel/2005-06/msg00069.html


--------------enig00BCB75888A220F0A4A51296
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iQIVAwUBSHzfCNlUrD+J4RHYAQIsUg/+Nd56dEFq7Z2pLgxl5fztXQwJdLkgU3Ys
JmyvEsuoW4NHLDKdGpme7ERsz9pBHQ6Ee0i/bGtkUUD9ct81ULLzICZC/w+143Pa
HN0eezoYq/1A1AsFW25keZHGbiWkQZP/FwcYooaJNZeDfDr+RAPXM51gw3kjLBPa
keSeBFbrVfcCD7Zl+4a1b9CS4spd07YME1l+/p68KPAS37qMGaHgLLObZWOaGR3I
SYod6D72tyPHKzxjL+He7MB2nzIi2k/LoAOvDcD8NBAT95byDAWdWR/UCjMhOLX8
N+XhwZ+NMdfrUL8du25iEn9vI/+CkNtSBjpNikweCqZE57mW35M7ceVPmf/zDWIX
Yd2K4dkYP4R1QgNYcLe3DhyiKvsNljiDprt12vxJYh0ji2KA/ezaRZJeTDwOgoRe
lh/8uRwrf6oXj2JGDQoznklUGFrpkH6da4H+Ysu0lc5cfaerX1zmRfISYqja2hb5
Az4acPouuyOFj9lyI7PUBFLIB9T9QY/gl3XKW378TmbWSgrfcR5f9v35Onqu8k70
J3K5Sa7OOZH2g3yp9QUQrlZMZ5AYlKCH8f2j5JVjQwDDph574KTdi1/GZfHKHh4B
sdTzBgTs2RS1K5TBBlZaaVzjJ0WiXQNLB9tSDDGIAbeq1dzFAqt+/xCzzNAXwHBx
+JwVEWBjClk=
=ZRM0
-----END PGP SIGNATURE-----

--------------enig00BCB75888A220F0A4A51296--

