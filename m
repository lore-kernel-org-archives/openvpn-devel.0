Message-ID: <5519AA28.6030003@...68...>
Date: Mon, 30 Mar 2015 21:55:20 +0200
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <1426015605-4068-1-git-send-email-steffan@...1856...>
In-Reply-To: <1426015605-4068-1-git-send-email-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="Mv8O3ctuJXuwLMFO1LppHENsuqfcIbmLT"
Subject: Re: [Openvpn-devel] [PATCH] Re-enable TLS version negotiation by
 default
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
--Mv8O3ctuJXuwLMFO1LppHENsuqfcIbmLT
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Am 10.03.2015 um 20:26 schrieb Steffan Karger:
> Re-enable TLS version negotiation by default, so that users
> benefit from the stronger and better crypto of TLSv1.1 and
> TLSv1.2, without having to add 'tls-version-min' to their
> config files.
>=20
> We tried this before in 2.3.3, but got various reports of people
> no longer being able to connect.  Back then, we did not have a
> way for users to control the TLS version.  We now have
> --tls-version-min and --tls-version-max, and even automatically
> set --tls-version-max to 1.1 if --cryptoapi is used, because
> the cryptoapi code is incompatible with TLS 1.2.
>=20
> To make sure users can fall back to the _exact_ old default
> behaviour, not only limit the TLS version to 1.0 if
> --tls-version-max 1.0 is set, but also keep using the API calls
> TLSv1_{client,server}_method(), instead of the ones that support
> negotiation (SSLv23_{client,server}_method()).  (Yes, the naming
> is awkward, but 'SSLv23' really means 'enable negotiation' in
> OpenSSL-API language.
>=20
> This patch is for the release/2.3 branch only.
>=20
> Signed-off-by: Steffan Karger <steffan@...1856...>

conditional ACK, provided that:
a) the manual page is adjusted properly (I have sent a proposal in a
separate message that is an incremental Git patch on top of Steffan's)
b) the release notes mention the --tls-version-max 1.0 workaround.

I don't see why we need the workaround, but I subscribe to due
diligence, and caution.



--Mv8O3ctuJXuwLMFO1LppHENsuqfcIbmLT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUZqi8ACgkQvmGDOQUufZWtCwCbBlhzyNfSpEL3NnA5lJsfnG8N
FuMAn2Sdbt1Gj5+4CaaaqzsHLnII9RxU
=tRmH
-----END PGP SIGNATURE-----

--Mv8O3ctuJXuwLMFO1LppHENsuqfcIbmLT--

