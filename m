References: <1481645498-22043-1-git-send-email-selva.nair@...277...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <e9f8f61d-1d14-af88-5d8d-c4b78ac227cb@...1856...>
Date: Tue, 13 Dec 2016 19:32:50 +0100
MIME-Version: 1.0
In-Reply-To: <1481645498-22043-1-git-send-email-selva.nair@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kPqLEuTVRFjekhLnoPPn3RA9pC9cSsnk7"
Subject: Re: [Openvpn-devel] [PATCH] Unhide a line in man page by fixing a
 typo
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kPqLEuTVRFjekhLnoPPn3RA9pC9cSsnk7
Content-Type: multipart/mixed; boundary="rgpkdt4HX8LTHa9jnvs9BSo8409IQaGdn"
From: Steffan Karger <steffan@...1856...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <e9f8f61d-1d14-af88-5d8d-c4b78ac227cb@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Unhide a line in man page by fixing a typo
References: <1481645498-22043-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1481645498-22043-1-git-send-email-selva.nair@...277...>

--rgpkdt4HX8LTHa9jnvs9BSo8409IQaGdn
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable



On 13-12-16 17:11, Selva Nair wrote:
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  doc/openvpn.8 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index e5619c0..42ccd98 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -4575,8 +4575,8 @@ public.
>  .B \-\-ecdh\-curve name
>  Specify the curve to use for elliptic curve Diffie Hellman. Available
>  curves can be listed with
> -.B \-\-show\-curves
> -. The specified curve will only be used for ECDH TLS-ciphers.
> +.BR \-\-show\-curves .
> +The specified curve will only be used for ECDH TLS-ciphers.
>  .\"*********************************************************
>  .TP
>  .B \-\-cert file
>=20

ACK

-Steffan


--rgpkdt4HX8LTHa9jnvs9BSo8409IQaGdn--

--kPqLEuTVRFjekhLnoPPn3RA9pC9cSsnk7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYUD7XAAoJEJgCyj0AftKIwbIH/21KM3Skmwtei+EZT1Cco9Za
ZXru80y1gZqe42RJTFpVFCZchRHazRCFFLoMUunRl1TG0Yg99HakLgrLO5yCL6ez
gEonRUAVQCEA+huXoABIPIeV9AJHdG7cWO7UrrAtiFZLvbdz1dvezsp/fbl/QwPW
vZ0KQeKZjCMMY1D24WcQxGywvgkswE9aSSynuIBPLCS62VqYPPWAu/3WWgaDka0z
DV81VKBbVdZAXTfTaQnrCAnjucqocHmcpVwt3YWb5GYqh+2Uh1zhQ9zy4gCNaz3O
mVf9THIdqT/inNUrBWnxwA5pcbNA9nq7qYYv9bVVqJSXq0w9oLP/JPQszVioK9M=
=t2D2
-----END PGP SIGNATURE-----

--kPqLEuTVRFjekhLnoPPn3RA9pC9cSsnk7--

