Date: Sun, 14 Jan 2018 19:10:05 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180114181005.GE69387@...1296...>
References: <1515378076-5774-1-git-send-email-selva.nair@...277...>
 <1515378076-5774-2-git-send-email-selva.nair@...277...>
 <bb21c180-2618-6d83-e7e1-dbc8479e8d6e@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Wr26kid6E8rFCMyi"
Content-Disposition: inline
In-Reply-To: <bb21c180-2618-6d83-e7e1-dbc8479e8d6e@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Bring cryptoapi.c upto speed with
 openssl 1.1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--Wr26kid6E8rFCMyi
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Moin,

On Sun, Jan 14, 2018 at 12:28:40PM +0100, Steffan Karger wrote:
> This conflicts with the patch set from Emmanuel, where he removes
> EVP_PKEY_id().  Canbe easily resolved by changing the if to
>=20
>    if (!(pub_rsa =3D EVP_PKEY_get0_RSA))
>=20
> ... but only once the NULL-check patch for openssl_compat.h is applied.

"go for it" :-)

gert
--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--Wr26kid6E8rFCMyi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaW5z9AAoJEB2Cnv7KVigSgSMMAKILcus85J79jhcUTcdzRAG7
guCP9kZlpAzqzE8Ddct9ttcbFWP5bnk25sq/DlRnp9v3uhWL1w1VrFr50OCa+Aim
3ege7sunCovFngHL2SDDukmUeKe0rABHFDbNBr5OTW59mZCf+70UcdpgbxC775cf
6kfv8ab+CUQqhRPcW6NZGBeazP29ITx6LdcJ6dLG6g0x2KL1MkU43L1EP7JlrEGB
uB/3p2la7Xr3/yQBl4kwy/AMFHcEbvFEdCqNtxIG8n97GrNfBQyiZwkSDBV0p31y
VsY3/KUteDpHcx6xRzBKtwseh+LsfMpz7XZEZGFXQGNAXCSDARh6S6V1Pyim9W7M
fZaj3pz0YowFevnidcOo5S6e/VAUTpNCJB4s86B03a1IStHggSGDVdg47M9UtU2I
s9w1UqWW4TEveiz1YEBlgf9VAqdJgPfUQio+yUPKUBBcFIYjF3zVBB5f6nYCiSDy
EorDeMTRc7HmSCRgaWDX1P0GbXPwuEAa0DMt0+nsNg==
=/hAl
-----END PGP SIGNATURE-----

--Wr26kid6E8rFCMyi--

