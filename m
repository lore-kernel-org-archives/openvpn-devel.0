References: <20200821062443.69245-1-eric@...1918...>
 <bd154015-3f5f-6035-c4ff-fae5abc7857c@...1227...>
 <3df6fedd-f30a-4e08-0e82-b31a7728f21d@...1918...>
 <446bb2a7-7597-1c89-b4eb-543abf4e6e3f@...1227...>
 <2f192d4f-fa69-20d3-f9a2-90329d308b53@...1918...>
 <f2ddadee-f969-2bcb-5b19-ad2273a17b18@...1227...>
 <050fed64-f566-35be-f3fa-d9d79cf2a7c6@...1918...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <c6d1361f-f7d5-9a28-ff93-580b9dd75ad3@...1227...>
Date: Wed, 26 Aug 2020 10:55:42 +0200
MIME-Version: 1.0
In-Reply-To: <050fed64-f566-35be-f3fa-d9d79cf2a7c6@...1918...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uxuP1fPDa1pUM7e4pHjwedntoAixQg3x6"
Subject: Re: [Openvpn-devel] [PATCH] Adds client-auth-pending-extra
 management functionality.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Eric Thorpe <eric@...1918...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uxuP1fPDa1pUM7e4pHjwedntoAixQg3x6
Content-Type: multipart/mixed; boundary="i0pV3ATTdAUhJLXbEXFdKYlLHgxoW50vG"

--i0pV3ATTdAUhJLXbEXFdKYlLHgxoW50vG
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 26.08.20 um 03:15 schrieb Eric Thorpe:
> Hi Arne,
>=20
> I'm happy to resubmit the patch with further documentation to what I
> have already included with this patch, however I need to know what is
> likely to be accepted.
>=20
> Per my previous question and example, is it acceptable to keep using
> CR_TEXT and document the C and CR flags, or, as I think you have hinted,
> would you prefer I create a fourth INFOPRE spec, for example CR_DATA,
> and document that instead?

Maybe. I am not against the idea of allowing more authentication
methods. But I am not sure what you are trying to achieve.

> It would also be highly appreciated if I could get some indication if
> this patch is acceptable outside of the requirement for further
> documentation or if the code needs further changes.

Currently I don't understand what authentication method you are trying
to implement. It is frustrating for me that you avoid that question.

For accepting it is very simple. Either is something everyone using
OpenVPN can implement and understand and you are willing to share with
OpenVPN. Then the patches can go. If it a special private authentication
method and you don't want to share that, then your patches can also be
kept private and applied your own branch/client/server.

Arne


--i0pV3ATTdAUhJLXbEXFdKYlLHgxoW50vG--

--uxuP1fPDa1pUM7e4pHjwedntoAixQg3x6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl9GI44ACgkQFRhsZwKx
RFQRcA/9Ghh5Xu2jZPOWIXqKrLJXxZa6XDtoGHhUrbwrHqgsr06Tsbx99kY+DN+M
lObj/Ftoh6j3s6LapVlDdh8XfFELzj3wBTKc8m3l6T4OFa9EvJ6Z7hgPBEu/vJVi
OCIHMKoAQr/Y0hUs+j3eEA1BNmO+gC31OzuwBrwx3Eu3o05N8NBfmFzhDNJXwFCS
WyUeuQ2dTQV46DgkwuRKefRc20AH1COS757k2Iqp6KLX/NH3tqKK7mReG4uxcE5A
tJDRoFJgVCZQ10d/AMM7BF/NNnlCEMvZbBPxAPkRVV4cvR28pkgqgrmsKbhuC6R2
xke1dadicbe0q5zjmUducP2lukfNDNaYBImYCQE1qn4nfJy/QqcBdl6CpRgOI9ov
zvFZaJw1p5fNgalm55K524qxyb2snEFydSZxxFLd9oPb0kFAbp+eOe4hVtNZUZPK
amiUJ2Raxh2Q0yJZmFy+ywp979h+0TfXFzz7x0gbATWEaIxgqqs5ZfYeqIB7CZEn
NraHs//tkUY/8owtvcziVD8q4Ga8ILNi1N5oJeyrmWp0y0E410mTvYIMlmI+Txrl
AnQ4sKEfaoMBAPlj4VIo89tmnxU0KrNvJO+vcmUeVF9RIpoKUK2o+/PD3pOg+8f8
jSb+Klk7fl0+kIP1to8NLx2JhGwHuViW3Hpaf5RsK7Ug1GsaVqQ=
=aQa2
-----END PGP SIGNATURE-----

--uxuP1fPDa1pUM7e4pHjwedntoAixQg3x6--

