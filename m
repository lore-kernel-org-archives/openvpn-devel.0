References: <56C5C6F7.1020903@...277...>
	<CAA1AbxJEJyrzJLOXLN2gO6EbA2=QSAbJf3pEr0SUAgVReT5xXA@...278...>
	<56C5EE36.5080906@...277...> <20160218170312.GV24952@...1296...>
	<56C5FA72.9040607@...277...> <20160218180846.GW24952@...1296...>
From: Jacek Wielemborek <d33tah@...277...>
Message-ID: <56C6F809.1070108@...277...>
Date: Fri, 19 Feb 2016 12:10:01 +0100
MIME-Version: 1.0
In-Reply-To: <20160218180846.GW24952@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="moRVtAdbsgKDFO4V2V0aEME3VshaSAuVX"
Subject: Re: [Openvpn-devel] Has openvpn been fuzzed?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--moRVtAdbsgKDFO4V2V0aEME3VshaSAuVX
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

W dniu 18.02.2016 o 19:08, Gert Doering pisze:
> Hi,
>=20
> On Thu, Feb 18, 2016 at 06:08:02PM +0100, Jacek Wielemborek wrote:
>> Well the attacker could send a funny packet with a valid checksum,
>> encrypted and authenticated, right?=20
>=20
> Indeed, but that would be someone we trust enough to let him talk to
> our network - protects against Joe Random from the Internet crashing
> our servers (or burning CPU resources trying to).
>=20
> But yeah.  Mistakes do happen :-) - so software shouldn't ever crash
> on malformed packets.
>=20
> gert
>=20

Crashing alone isn't as dangerous as having memory errors that could
lead to arbitrary code execution. Especially if OpenVPN is run as root,
which is probably the case quite often, given that one of its most
common use cases requires privileges to set up its own network interfaces...


--moRVtAdbsgKDFO4V2V0aEME3VshaSAuVX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWxvgWAAoJEGlViymZXJRv3VYP/0UtchNCOGLFAhaGB4fh3hyd
lbTDgUVfZXuJkt6vULfA2y2Uo/Q7/2TfZgN5/ncAPxoeogmtbHJtkRciti+dfQ6e
qx7duvnr55Ck+lnGm8l7gIlTTXCa7XXkmRorm+31G/uMfuYLZ2MLLZhcfaMG0xXa
Cpj1XruMij5ntluZSQ6ehF7BbFpWUWX8QzCMxQ3iNkc0AwrFCqoLdImtwXrHXsow
A7fhtahadBqZehLlHc6kHUYnN1APABDxF7Bt5J+HLz96dHzeFRs8ic0cuNMjDbqW
6g6Jqyt0kBy+oAT9Loq9BMJNC9wR25wrkRXkbX6vOyyjKnDdbv4W2z0GKbanPTtf
WYN3or/a14JA7APiBeqCVIreRDlc5ar+uofUMbVDbdYPkicP9lZkWPwzyY5zhuhm
bTn9C6Htd4e61uzp0uB8xAGapxlQKBiwa6F2zMwYGR2ToPQuDuMfqyf6GcoU+eqp
tJpYTz+M6hnAZ0cs83tfGNWUcK3Jr7OX6s9hBLL0/O9H4tMdjkuQsXdAnVNapOxl
dxXtdhkGFa31jH6RFXu1f1o9+EzizNovlMAmvgaKq9jWBeMHc01tX0tqAPowzJJh
3nKrnNxCHMSR75BBW2DftHyxIHNhkMd64KJ/7D8tRjTdALLMmfijIIP/ULuCsxMd
v5z//5Grve32rRpI1tTa
=djDX
-----END PGP SIGNATURE-----

--moRVtAdbsgKDFO4V2V0aEME3VshaSAuVX--

