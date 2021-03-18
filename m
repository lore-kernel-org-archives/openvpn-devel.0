From: David Sommerseth <openvpn@...2080...>
References: <20210318181258.89704-1-juliusz@...2525...>
 <206262d3-1ced-99f7-b28d-fce0b7982e65@...2080...>
Message-ID: <aa861963-2ed5-c67d-69ce-b56949cddc10@...2080...>
Date: Fri, 19 Mar 2021 00:12:33 +0100
MIME-Version: 1.0
In-Reply-To: <206262d3-1ced-99f7-b28d-fce0b7982e65@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vW8oxXShQIM08b6Twep2Oq2aWFz0P7BVf"
Subject: Re: [Openvpn-devel] [PATCH] Add PKG_CHECK_VAR compatibility
 definition for old autoconf versions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Juliusz Sosinowicz <juliusz@...2525...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vW8oxXShQIM08b6Twep2Oq2aWFz0P7BVf
Content-Type: multipart/mixed; boundary="0I5ehrsEE9dxRhfG059nLE7rYg6n4dCyU";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Juliusz Sosinowicz <juliusz@...2525...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <aa861963-2ed5-c67d-69ce-b56949cddc10@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Add PKG_CHECK_VAR compatibility
 definition for old autoconf versions
References: <20210318181258.89704-1-juliusz@...2525...>
 <206262d3-1ced-99f7-b28d-fce0b7982e65@...2080...>
In-Reply-To: <206262d3-1ced-99f7-b28d-fce0b7982e65@...2080...>

--0I5ehrsEE9dxRhfG059nLE7rYg6n4dCyU
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 18/03/2021 21:52, David Sommerseth wrote:
> It would be great to figure out if pkg-config is available on those=20
> build hosts failing without this change.=C2=A0 If it is present, it needs=
 to=20
> be checked which version it is.
>=20
> If this is due to an outdated pkg-config, I'm reluctant to give this=20
> patch an ACK.=C2=A0 Using properly up-to-date dependency stack should be =
a=20
> reasonable precondition to build OpenVPN.=C2=A0 If it is due to unavailab=
le=20
> pkg-config, it's a different story.

So I managed to test this more properly on RHEL-7 and CentOS-7.  This=20
major release is forked off from a mixture of Fedora 19 and 20.  And=20
pkgconfig got upgraded from 0.27 in F19 to 0.28 in F20; but this was not=20
pulled into RHEL-7 (which CentOS-7 builds on).

This is also the latest pkgconfig version available on RHEL-7, which is=20
the oldest enterprise Linux distro we support.  So my concern about not=20
up-to-date dependency stack is no longer valid.  We need this change.

If Gert is fine with updating the commit message at commit time, I'm=20
ready to give it my ACK now.

I propose this commit message:
----------------------------------------------------------------------
build: Add support for pkg-config < 0.28

RHEL-7 ships pkgconfig-0.27-1 which is lacking the PKG_CHECK_VAR() m4=20
macro.  This might be the situation on other OS distributions as well.=20
Ship our own macro providing this support when not found on the build host.
----------------------------------------------------------------------

Acked-By: David Sommerseth <davids@...515...>


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--0I5ehrsEE9dxRhfG059nLE7rYg6n4dCyU--

--vW8oxXShQIM08b6Twep2Oq2aWFz0P7BVf
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEgDq5E1p1aZrNLFFkhs+UTJZx/fIFAmBT3mEACgkQhs+UTJZx
/fJoXQ/+MAkWxaMUzyPa7uG/xn0kaHQYSKd71piKzpAuvNOzi9gFBd/WAp2W65Pt
D8aFgjwD/MjjQIHmjjVk6YcOJWQn10pguxaioTijH9Ya25DhqVhG/cHsyzwmK1XC
oj6SWMAX/wii0dQggdLoOR3JwL8r7C0hAZYiHoeHxfrRIM4ge+ohY4QtwhDCY+Qz
F0E1a7Jpk7ddneCyAVrLSuhsAMOKlb9g3itjlJgjyAtmzI7lMRbPo7skzoL6+TJ3
f4GBRUn24rEbaDm9de48m/hyShehdhbWpxMUmbcVZqi04LJsodk+yV4/gXKbxMxI
m/9tJhq/7Us7AQilbQO+F58T4oCcyt3qsTxUVlOtt+K7iayCA5cJ8NY7SENjXR9P
DH9GytVxnpOkStnsdr9CZem4MUdRkB7c0IM/Oxn1LoztHlrKZ13oyZzifZLb8RTc
/hLu9XxbVbhUK0dQHK6WCq8mV0HanFnPjj4M9UBHtDSuScaEuHlPxalVQoZz5q6b
ym/+kOiC3/P2RpVhtaU0Np26eImaNaIxSYqvrENx5imqyFLh4pOOQLm/fgy3IIuK
L8fGC5CKCLB73eB0bRU1IKd2n8/4YxqFRK2ll2ghVXN6Zrokc5B2yVAnft/SbwrX
qtacGRmTaP0wCZVcmZSGuEv2AOgsVdiqeo3G+J7nFVbCvVV43rI=
=yitb
-----END PGP SIGNATURE-----

--vW8oxXShQIM08b6Twep2Oq2aWFz0P7BVf--

