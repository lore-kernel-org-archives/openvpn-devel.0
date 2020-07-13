References: <20200713093252.30916-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <b1673f4a-9b64-c8b2-6342-0717d21e8e97@...1227...>
Date: Mon, 13 Jul 2020 11:40:08 +0200
MIME-Version: 1.0
In-Reply-To: <20200713093252.30916-1-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UWb2nvHMDA6wUzaN4l7iHV8pGgiqtEbEf"
Subject: Re: [Openvpn-devel] [PATCH v2] Handle connecting clients without
 NCP or OCC without crashing.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UWb2nvHMDA6wUzaN4l7iHV8pGgiqtEbEf
Content-Type: multipart/mixed; boundary="CQ2nONzcCTUAeBh4FS01LcKLWGn8WCHhi"

--CQ2nONzcCTUAeBh4FS01LcKLWGn8WCHhi
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 13.07.20 um 11:32 schrieb Gert Doering:
> ssl_ncp.c:ncp_get_best_cipher() would crash if a client connects without
> NCP (or with a NCP cipher list that does not contain the first NCP cipher
> in the server list) due to a NULL pointer strcmp().
>=20
> Work around / fix by just assigning an empty string to remote_cipher here
> ("not NULL but will never match either").
>=20
> Add new warning message in multi.c for the "we do not know what the
> client can do" case (no NCP and non-helpful OCC), rewrapped the existing
> message to keep line lenght limit.                       tpyo

Acked-By: Arne Schwabe <arne@...1227...>


--CQ2nONzcCTUAeBh4FS01LcKLWGn8WCHhi--

--UWb2nvHMDA6wUzaN4l7iHV8pGgiqtEbEf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8MK/gACgkQFRhsZwKx
RFQOPA/+NFjT14cAvtT1EYVseqG3rJch+PgjTtSSFASSRW0/O+ZvkRYJFx7v/WUv
VKU9M3poF62MzZHafFMQMc8NQkT+l4eowIsGOUfhQlvc08qLXhq7N7+QXh3StxeL
k477PT5I5hLYAggmEEkS5p979AEdkVbz0f8+QoUJlsbvUS8pGMJu7XKEuleTHfzh
CAYz0oC06XPFFogqiW4NVKXvZZ+5MVC7KZHymQkRVkHu0GJHCfXyCON7uSYXdLXb
MUvM8DetutOOV5BAK5u3BJFuLUripvrHPZVI487lzVFKlaRF1C33oVqSgukUwTf3
AIbT8jKfN4laeVyDKyiBe2nqQ6lVk7CofNwRoDhvG9bEYFDB+UxdMPujpyrknz7C
oemzfsg1BLzx+l4Z9rraBGnYVTVJ84zm+3H5ZzGx93zp4vbbFaqrVdYxETOir69I
my9U6A1WlJeDaDDN0CLdjMU/4Rg3UhKT3Bj1I6RO/iWwugeiZ77MGhT2pC4p3sia
5dhm3xFfFSq8zdU83Jc4pSVvCrjmS1u1OaWSVRL9iGEqSTvbdhbqnlmii7HpUavX
LwgJdR8DOOHIO56bF2/7ppX1VueFAmHaM0yYKfrfJodA7HXIIvFZLbW5wFaybvGw
LD+lTbOrEhkwDbqxO9l7EXqQtKuXr5hjBOFIxjdBw8D60ACdHK4=
=OkL4
-----END PGP SIGNATURE-----

--UWb2nvHMDA6wUzaN4l7iHV8pGgiqtEbEf--

