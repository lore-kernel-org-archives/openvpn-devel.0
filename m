References: <b5f2ab31-3e15-932e-87dd-ddf068b8dee6@...515...>
 <3d3fd560-be51-5095-1c83-78f51effb8f4@...515...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <21f04b80-c555-3c97-d498-43a3fbb3b051@...1227...>
Date: Wed, 13 Feb 2019 13:44:43 +0100
MIME-Version: 1.0
In-Reply-To: <3d3fd560-be51-5095-1c83-78f51effb8f4@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jUZbXwRh8tffmAOPc1StI4l2rsSpgkZXN"
Subject: Re: [Openvpn-devel] Summary of the community meeting (Wed,
 13th Feb 2019)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jUZbXwRh8tffmAOPc1StI4l2rsSpgkZXN
Content-Type: multipart/mixed; boundary="L7AD4P6a3gqIGL0uXQf1TDcZNCTkIOG0f";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <21f04b80-c555-3c97-d498-43a3fbb3b051@...1227...>
Subject: Re: Summary of the community meeting (Wed, 13th Feb 2019)
References: <b5f2ab31-3e15-932e-87dd-ddf068b8dee6@...515...>
 <3d3fd560-be51-5095-1c83-78f51effb8f4@...515...>
In-Reply-To: <3d3fd560-be51-5095-1c83-78f51effb8f4@...515...>

--L7AD4P6a3gqIGL0uXQf1TDcZNCTkIOG0f
Content-Language: de-DE
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable



>=20
> Discussed OpenVPN 2.4.7 release. Agreed that 2.4.7 should be tagged the
> upcoming Monday, so that it can go to Debian 10. The patches that we
> still need or would like to have are:
>=20
> - script-security vs. GUI
> - auth-token-hmac (fairly intrusive but well-isolated)
>=20

Note that auth-token-hmac for OpenVPN 2.4.6 will require additional
patches/backports from master. These would be:

- Cherry pick buffer_read_from_file from 5817b49
- Introduce buffer_write_file()
- Add crypto_pem_{encode,decode}()
- Cherry-pick integer htonll and ntohll from master

And also the other commits do not cleanly apply to 2.4 without a bit of
conflict resolution.

https://github.com/schwabe/openvpn/commits/schwabe/auth-token-hmac-24
has a branch of this.

Arne


--L7AD4P6a3gqIGL0uXQf1TDcZNCTkIOG0f--

--jUZbXwRh8tffmAOPc1StI4l2rsSpgkZXN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlxkETwACgkQFRhsZwKx
RFQmcRAAp0k8JnwzjBYW+aYrWeeaXYPh2TFUZb/RgEp5MHamBRdF78ibzpvjcjFS
tyBhtr/bv8zfiQsEP4J7rFBbS92vE+UU0qcNjnvZWejna3rooxuA6DHeQI4CT3i7
DmK7HgEXs13anGgPIBLi6YO8zzD+TeIxJlS7ddYgrY1sVabduw7zUGG9PV2FvAcx
82MAK8XF3T2UYe1RSacY8s0TX8DB288LESTHjlHz+z/i1ST7kj4Rvtsz5aOzAiZ7
DSu8tdO3W/QGrklLQHSI8+seKtKVuabYtq2zzppk9JfB9ZalAsIN6UDhFp40iKLP
xyOXGqzFaga7MUNQn1ZhXaknp+me4x4KacTQMk0bk3FsA8U/dW0XNMJnO9p3L6Tf
l/xHua+A55t423HdAKwSNBZoE7RUtLw0kPR+uFRUCyEfLT5UZgll7AmtgA2a97jj
jxplsBPzryu29/F9cvI8IYk/2+LyAcpErh+0ZLbxQcATOaTXRdLje/qK0Gm7pQbL
7XHSoVOI8rIvvdawFcfM5ejxxGtSzHcl/qL6L4lya/xM332suhkP9W0c4z/Rmo44
PXsas7f+o0m4VcPSq27egIhLnFNKXPnOM3xibXqAeSWs2ZybtTGBpqAynDJ7rhfG
WtoGn8h38Zs8YFQmy8FJ1y2lyUgFuPnunG/d95lqqbG0LZ5b81o=
=SSNF
-----END PGP SIGNATURE-----

--jUZbXwRh8tffmAOPc1StI4l2rsSpgkZXN--

