References: <CAATJJ0JWDwT-BLR2W4bxRrJJu+jooVOhGpG2yrRvoXW3H1ii8g@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <80bf080e-a293-70a5-fab0-c4f814dd154e@...515...>
Date: Thu, 6 Sep 2018 15:25:31 +0300
MIME-Version: 1.0
In-Reply-To: <CAATJJ0JWDwT-BLR2W4bxRrJJu+jooVOhGpG2yrRvoXW3H1ii8g@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aYCRhEZY3ItkrN0kNDECKfbNtTLAzIvjf"
Subject: Re: [Openvpn-devel] sbuild_wrapper: please unify service rules with
 openvpn repository
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Ehrhardt <christian.ehrhardt@...1808...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aYCRhEZY3ItkrN0kNDECKfbNtTLAzIvjf
Content-Type: multipart/mixed; boundary="xrQHmBzNesTzTzGLFLoGW9XXcZqRkNBiL";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: Christian Ehrhardt <christian.ehrhardt@...1808...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <80bf080e-a293-70a5-fab0-c4f814dd154e@...515...>
Subject: Re: [Openvpn-devel] sbuild_wrapper: please unify service rules with
 openvpn repository
References: <CAATJJ0JWDwT-BLR2W4bxRrJJu+jooVOhGpG2yrRvoXW3H1ii8g@...278...>
In-Reply-To: <CAATJJ0JWDwT-BLR2W4bxRrJJu+jooVOhGpG2yrRvoXW3H1ii8g@...278...>

--xrQHmBzNesTzTzGLFLoGW9XXcZqRkNBiL
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I maintain the Debian/Ubuntu packages for OpenVPN.

Il 03/09/2018 12:24, Christian Ehrhardt ha scritto:
> Hi,
> the upstream provided .deb [1] e.g. for Ubuntu Xenial gets its service
> file from [2] which is outdated.
> This makes the upstream Repos [3] not being in sync=C2=A0
> I'd ask you to follow the main repo [4] on that to eliminate some Delta.
>=20
> In general I think that some of the packaging is outdated and
> sbuild_wrapper could fetch some more from Debian [5] and Ubuntu [6]
> (which match among each other on this)

I've generally reused packaging files in OpenVPN packages provided by
the Ubuntu and Debian projects. In some cases, though, the packaging
files may be from a package meant for a (slightly) older operating
system version.

Do you happen to have a diff at hand? I would not mind updating the
service files if the changes are fairly minor or fix a bug. But I don't
want to break setups that depend on the behavior of the outdated service
files.

Also, we don't have packages for Ubuntu 18.04 yet. So using the
packaging files from Ubuntu's repositories makes perfect sense there and
can't break anything.

> P.S. those upstream debs are AFAIK built by [7]

That is correct.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

> [1]:=C2=A0http://build.openvpn.net/debian/openvpn/release/2.4/pool/xenial=
/main/o/openvpn/
> [2]:=C2=A0https://github.com/OpenVPN/sbuild_wrapper/tree/master/packaging=
/xenial/debian
> [3]:=C2=A0https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos
> [4]:=C2=A0https://github.com/OpenVPN/openvpn/blob/master/distro/systemd/o=
penvpn-server%40.service.in
> [5]:=C2=A0https://salsa.debian.org/paelzer-guest/openvpn
> [6]:=C2=A0https://code.launchpad.net/~usd-import-team/ubuntu/+source/open=
vpn/+git/openvpn/+ref/ubuntu/devel
> <https://code.launchpad.net/%7Eusd-import-team/ubuntu/+source/openvpn/+gi=
t/openvpn/+ref/ubuntu/devel>
> [7]:=C2=A0https://github.com/OpenVPN/sbuild_wrapper
>=20
> --=20
> Christian Ehrhardt
> Software Engineer, Ubuntu Server
> Canonical Ltd
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>=20
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20



--xrQHmBzNesTzTzGLFLoGW9XXcZqRkNBiL--

--aYCRhEZY3ItkrN0kNDECKfbNtTLAzIvjf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAluRHLwACgkQKVhNn0CG
RXiEqgf9HFryqwffWJs/RwdssEaAr0mGMMdUJdBIvQdTpK4eOlOh4tbZd99wb5TJ
0iseBJW7ZfuoAQ56obZmLavEBVK09ULj2trriTWwjLMyjEpFhOhszF+IV2aVWIgd
S+W+xOdvg5E3enqiXs2xl5vB0o7ZTh/0sF/+Wvs2PiLSXgqEoFpF1qf66nYp3dRA
/bLg7VAgq9uWJ1Hs98Cmhw0l8n5vydeMwjbWZUAxs5AOLFemZPTzg+NFvuvl7dOv
QDr3tJN/A4lqOusjkElQ+mTJ71+Kwg2X81EcYFmn3SYpaJgn1gA0dwtZ3XYnSSDS
Tk8mwLzFr0YBiA8E9xNEMuAgqaJpag==
=u/Rh
-----END PGP SIGNATURE-----

--aYCRhEZY3ItkrN0kNDECKfbNtTLAzIvjf--

