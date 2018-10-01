Reply-To: openvpn-devel@lists.sourceforge.net
References: <CAFHpkQGaXSniWKFFeiyWW=-_rN1iHBXUerfBfdGxD5UM0r+B6A@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <8b859470-e110-9b7e-606d-46c22be026b8@...2080...>
Date: Mon, 1 Oct 2018 12:47:39 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQGaXSniWKFFeiyWW=-_rN1iHBXUerfBfdGxD5UM0r+B6A@...278...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="D695Dq0Djh6EkY4qDM0bk4W0x8EjN869m"
Subject: Re: [Openvpn-devel] switching openvpn-gui to github releases
 (instead if http://build.openvpn.net/...)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D695Dq0Djh6EkY4qDM0bk4W0x8EjN869m
Content-Type: multipart/mixed; boundary="xHzQAGSCi2fAE3IRzqZM4Gey2IwqY0I9Z";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <8b859470-e110-9b7e-606d-46c22be026b8@...2080...>
Subject: Re: [Openvpn-devel] switching openvpn-gui to github releases (instead
 if http://build.openvpn.net/...)
References: <CAFHpkQGaXSniWKFFeiyWW=-_rN1iHBXUerfBfdGxD5UM0r+B6A@...278...>
In-Reply-To: <CAFHpkQGaXSniWKFFeiyWW=-_rN1iHBXUerfBfdGxD5UM0r+B6A@...278...>

--xHzQAGSCi2fAE3IRzqZM4Gey2IwqY0I9Z
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 01/10/18 11:49, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
> Hello,
>=20
> I was absent for few days :) Glad to see you again.
> I want to discuss whether we can choose github releases as primary source=
 here:
>=20
> https://github.com/OpenVPN/openvpn-build/blob/master/generic/build.vars#L=
15

No.  We do not want to change the trust centre of downloads to GitHub from =
our
own infrastructure.  And we don't know what GitHub might do to our uploads =
in
the future even (we don't even host downloads on sf.net any more).  GitHub
tried a while ago to hide quite well the "upload file" feature, as they wan=
ted
users to use auto-generated tarballs straight from the git tree; which does
not work well with autotools based projects (it complicates the receiving e=
nd).

We see no compelling reason why or how this would improve anything at all.
Plus the current approach works quite well with the release processes alrea=
dy
in use.  Remember that these release processes also includes a bit more than
just "create and upload a tarball".  Plus the fact that it may be conceived=
 as
a more trustworthy source to have these downloads hosted on a openvpn.net
domain.  And having the same file served both via GitHub and an openvpn.net
domain is just duplication and a seed of confusion; especially if these fil=
es
then begins to differ for various reasons.

So, no, we will not change this.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--xHzQAGSCi2fAE3IRzqZM4Gey2IwqY0I9Z--

--D695Dq0Djh6EkY4qDM0bk4W0x8EjN869m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJbsftMAAoJEIbPlEyWcf3ybWsP/R6BbVED9njwGllEQQWa/rhn
sXAGBWSAI21zBZkG6uZ3oUVg/42I1w7B/oSGhLxvz5Cx4+Nk6mU9TM16+tJ4+0fO
wp1l/1dU2EAAqN5XW3hqR8Tz/dP6unlIJeD3gi3b+1MWHkHTo/jNQ0xmOvqI2L4B
qK2t9mMr3lAcadIeKKz56PWb5x0OfNx8cFlqAt62e6yU3SXLn5azRTbm3jywxT7r
VHWOscxpokRaCqMQbhddtXKsAh82L5EXNRjwPhz049zhXDIuWCKaW93CbwBoJw6v
eKtnu9yPFvhxv8WrxOrA8yP9Zp1VPPkUd+M3hkXVLsDACwVJ2JkX7/j8iAgkPlmF
//dAkI21qsPvOxb5yp0VFCgmLfcVvno15YC3MgSsZyUy+U+EYqM/4mHoEP+SFMMB
26aK9a41bo2EHF5FI6Q4B01M8GXv13lQM6ylHjG1PBl+VpfG/WLHYVNbGAnFkpaa
sanjyzH2BJjc4SO4YgoIoUWbWMXE5h2c3exeVTjESvfOVvAHp99ZTgp31xSHaJu2
MA8aChMAlVVChVRW33JiKawi6tjyptGAWMoZUo5QpxrHDvkjyf7/QK3dMeWlaNqT
gtjrkceiC5eyet3aLDIBaF85NUjduqxCs4WL7p5TNaPR4GkiLhmXAR9hIVCrvpNl
+Hkrc+/jhZnNVIJFg1e3
=QCeR
-----END PGP SIGNATURE-----

--D695Dq0Djh6EkY4qDM0bk4W0x8EjN869m--

