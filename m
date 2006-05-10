Message-ID: <4461EC4B.2090200@...411...>
From: Giancarlo Razzolini <linux-fan@...411...>
Reply-To: linux-fan@...411...
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Restricted client-to-client mode
References: <000601c673fc$d621a5c0$0200050a@...636...>
In-Reply-To: <000601c673fc$d621a5c0$0200050a@...636...>
Content-Type: multipart/signed; micalg=pgp-ripemd160;
 protocol="application/pgp-signature";
 boundary="------------enig8D7C582E8DD3C61721E32A17"
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
Date: Wed May 10 06:37:12 2006
To: OpenVPN Devel List <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8D7C582E8DD3C61721E32A17
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Serge Wautier wrote:
> The OpenVPN HOW-TO suggests a method using a firewall to restrict clients=
 access to parts of the network. I wonder if it will work in this case: Wil=
l the firewall be triggered for packets transmission over the local (VPN) s=
ubnet ? I don't think so.
>=20

AFAIK, all traffic coming from a client to another, pass through the
openvpn server. So your firewall rules would be able to filter this
traffic easily. There was already a discussion on this list requesting
that openvpn would be a full mesh vpn. If it was, then one client would
be able to connect directly to the other, without passing through the
server. But i don't know if this was implemented. If it was like this,
then certainly you would need the filter you are willing to implement.
But, the way it is now, you don't need it.

My regards,
--=20
Giancarlo Razzolini
Linux User 172199
Moleque Sem Conteudo Numero #002
Slackware Current
OpenBSD Stable
Snike Tecnologia em Inform=C3=A1tica
4386 2A6F FFD4 4D5F 5842  6EA0 7ABE BBAB 9C0E 6B85


--------------enig8D7C582E8DD3C61721E32A17
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFEYexQer67q5wOa4URAw98AKCvrp72B5H8t56/zBoyBcZW0KXkAQCeM/Hc
eFRIieKuYs1egffT8rrqkts=
=quWY
-----END PGP SIGNATURE-----

--------------enig8D7C582E8DD3C61721E32A17--

