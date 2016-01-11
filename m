References: <56936C78.3020505@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <5693BE57.2020505@...2080...>
Date: Mon, 11 Jan 2016 15:38:15 +0100
MIME-Version: 1.0
In-Reply-To: <56936C78.3020505@...515...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="NgsLr2paBDta9huRWUcCq7GjQ7G7aAgHr"
Subject: Re: [Openvpn-devel] Disabling auth_pam plugin by default in
 openvpn-build?
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NgsLr2paBDta9huRWUcCq7GjQ7G7aAgHr
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

On 11/01/16 09:48, Samuli Sepp=E4nen wrote:
> Hi,
>=20
> There is a pull request in GitHub to openvpn-build, which disables=20
> auth_pam plugin by default:
>=20
> <https://github.com/OpenVPN/openvpn-build/pull/10/files>
>=20
> For Windows this makes sense, as PAM is not present. However,=20
> openvpn-build can also be used to cross-compile for the ARM=20
> architecture, in which case PAM might be useful.
>=20
> Does the pull request makes sense, or should we just fix this with=20
> better documentation, e.g.
>=20
> "If you're cross-compiling for ARM, make sure you add=20
> --disable-plugin-auth-pam to EXTRA_OPENVPN_CONFIG"
>=20
> Thoughts?

You'll most likely upset quite some Linux distro maintainers.
Especially if such a change is not properly communicated.

I know at least RPM packaging will start failing when it detects that
files expected to be installed by 'make install' is missing.  Other
packaging systems may behave differently.


--=20
kind regards,

David Sommerseth


--NgsLr2paBDta9huRWUcCq7GjQ7G7aAgHr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlaTvloACgkQDC186MBRfrreGwCfRaWr60GW/kQ/Y0UNaVJuzSKA
koEAniVspbnasaQW/benQXClM/OAEu+g
=NFjG
-----END PGP SIGNATURE-----

--NgsLr2paBDta9huRWUcCq7GjQ7G7aAgHr--

