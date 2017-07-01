Date: Sat, 1 Jul 2017 15:59:19 +0800
From: Antonio Quartulli <a@...2181...>
Message-ID: <20170701075919.GF2133@...2287...>
References: <d6b9bca0-3ce4-0392-72b3-207eeada1a63@...2288...>
	<20170701073820.14809-1-steffan@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BI5RvnYi6R4T2M87"
Content-Disposition: inline
In-Reply-To: <20170701073820.14809-1-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Always use default keysize for NCP'd
 ciphers
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

--BI5RvnYi6R4T2M87
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sat, Jul 01, 2017 at 09:38:20AM +0200, Steffan Karger wrote:
> If a peer has set --keysize, and NCP negotiates a cipher with a different
> key size (e.g. --keysize 128 + AES-256-GCM), that peer will exit with a
> "invalid key size" error.  To prevent that, always set keysize=3D0 for NC=
P'd
> ciphers.
>=20
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
>  src/openvpn/ssl.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index f868457e..a8418d37 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -1976,6 +1976,7 @@ tls_session_update_crypto_params(struct tls_session=
 *session,
>      {
>          msg(D_HANDSHAKE, "Data Channel: using negotiated cipher '%s'",
>              options->ciphername);
> +        options->keysize =3D 0; /* Always use default key size for NCP */

How about printing a message to inform the user that if any keysize was set=
 it
is now getting cleared up?

Cheers,

--=20
Antonio Quartulli

--BI5RvnYi6R4T2M87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAllXVlQACgkQ0+HICM1s
oFBVsw/+PPzocx1OqjWviCEYO80GdHHaZ1/NJpti7veBwofqlKEIUT+mFyIWmosH
0oBdtWquMBJVf24unYaYi31G7srAAXhCQ5P6tzbywiwXMM0t2u9SaRzn1fTE/3lV
uGVei/MSmHbywOa3mHQJeeVUhbET15atw7bimWk4w8xXNHLd5pYN4vwgVBgNXv39
fr3Xeq20BbPd1jhf5UjvNogFuxnK2CE5lquhFdCdWCm9SLZTCgegEZl2AXbXco1S
AU68ffH0az4wAeAN0jzyNlCtZqeR8qwiUy0BQ0xugMt7xl/qKYoSe7KMvYa6L36d
7VITrUdLeYwTdcsBofnw3nKGsyW35n5l0ZTaO7/424mX+MDL3LFXUQl6LEaFtcSl
aYVEjwE82YbGlHc5KHrnC0ncSNvkO9M6xcFvpFij5cEyHsQdL1g+DgBDkeZXSblc
ACSkJbJhFfnqGSxu/iSZi7Kc3WYto6IkLduav5m79ETBY3wh3xfEIPL0pqSrrbhC
teZNomJ0pEuDxvgEvMVacHN0b4f8bNHLNShoBsazDeATl4JaySTt/8W+crkBgfMP
2wqr0F6C1Q338kM6rrYULGO+ALXIZhgh3hpRsFxmGQ4m1sXPzZ98nG8SOGaAZ0EI
lWkJCye75uZW++eVLRHR8Tub4AmTQSgkEjleJc/q4LQ6sVPjacs=
=iRqF
-----END PGP SIGNATURE-----

--BI5RvnYi6R4T2M87--

