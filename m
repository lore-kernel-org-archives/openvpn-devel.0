References: <20200908105130.24171-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <5ec10605-6b19-0ade-2a4a-5b1522628ab9@...1227...>
Date: Tue, 8 Sep 2020 13:16:43 +0200
MIME-Version: 1.0
In-Reply-To: <20200908105130.24171-1-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oRACxgZiqnIsn9mTTEUg8fmlsm2DpIOmo"
Subject: Re: [Openvpn-devel] [PATCH] Fix error detection / abort in --inetd
 corner case.
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
--oRACxgZiqnIsn9mTTEUg8fmlsm2DpIOmo
Content-Type: multipart/mixed; boundary="hQXuMxcKLGoPDzIgpTaok8LkdbVr5SeH4"

--hQXuMxcKLGoPDzIgpTaok8LkdbVr5SeH4
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 08.09.20 um 12:51 schrieb Gert Doering:
> Calling "openvpn --inetd" from the CLI (=3D no socket on stdin) will
> lead to endless looping in the accept(4) loop.
>=20
> Instead of cluttering that function further, detect failure to call
> getsockame() in phase2_inetd() already, and trigger a M_FATAL abort
> on "errno =3D=3D ENOTSOCK" ("The argument s is a file, not a socket").
>=20
> While at it, uncrustify the --bind-dev code (whitespace only).

Yes. Ack. I am happy when we can finally get rid of --inetd.

Acked-By: Arne Schwabe <arne@...1227...>


--hQXuMxcKLGoPDzIgpTaok8LkdbVr5SeH4--

--oRACxgZiqnIsn9mTTEUg8fmlsm2DpIOmo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl9XaBwACgkQFRhsZwKx
RFTfHQ/+JAxdtMaz9chSSX4HShz7Ji2IHmTWTOuzd/vMnfK1qiyzOpxsOB5P4or9
tMSmSeChOPkFpul9J/t3mYEGOlH985OuYLDYYf27VjXzfoJ+NZjciVfFnNZUHfRl
kAJFGSwlsQgfl5M4mt3j0je0uLrl5YNx9sGh3he95qM4Y1u0VKDeBLbGnhkcGgxr
SAVAUMcMMXoPudw9EqbZA8DDOZAxQqSvCKgcVsuQg+z/sZcWe4DCEbJZNOgDV5Z6
2VP7JRPJRNTibIuWEHnFIGwRKx28H3wePp2GCRRApS0QL0HFjKr0MMNtWEqzlLi2
3srQc/tHHx1WQSLsZwVgK8MUS3VrFChDZ08TKYtp/xrC9ta2u3lctwvcCEzsc7at
/1e00FMUW6wp89GTjDQSpKJtATwNZv4CbLV4FEMR0mLh+F544c/6keV6KOMQaBrd
P/3R3R35D/pDHJIcNfFfOx9MfEzOu1QUtwNOzCjAUiM4Y1CR1xVKpVPXCw6XCNxt
2+WVm/tbdvzIPyeC2SoKefh16Fdz4KVfPkmBXBLAnN8TDdx8gXF6OU7j7E5HhnTm
Aol7aiOR+BP4465/oj67W2ZiHzBiVeqUzUsWZwpZPSrePo8c4AgBs0N+OrRHQ+05
1XF7mARKY5nRXM2AHAvtXjfRd5TDNSkagrZx12uLSe6UPH9FLCQ=
=YNQV
-----END PGP SIGNATURE-----

--oRACxgZiqnIsn9mTTEUg8fmlsm2DpIOmo--

