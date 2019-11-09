References: <20190613144113.6418-1-arne@...1227...>
 <CAKuzo_jUGHTenM_cL_c7+h+703YN7nyXzhYA0r3JDPGyohqfsg@...278...>
 <CAEsd45QANhjtiwacOEyLou6F2V3tnhnEYb4T0Pjb928dFLWXng@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <1faff859-7b52-ef1e-56ac-f06c2181ca6f@...1227...>
Date: Sat, 9 Nov 2019 15:57:43 +0100
MIME-Version: 1.0
In-Reply-To: <CAEsd45QANhjtiwacOEyLou6F2V3tnhnEYb4T0Pjb928dFLWXng@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ad3BmOePk3SmUH4cXVEFQeU2YO344oAd0"
Subject: Re: [Openvpn-devel] [PATCH 0/5] Implement additional two step
 authentication methods
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Jonathan K. Bullard" <jkbullard@...277...>, Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ad3BmOePk3SmUH4cXVEFQeU2YO344oAd0
Content-Type: multipart/mixed; boundary="lTZ515Lix0VlCBKHNwhF4CoSytIop2XoS"

--lTZ515Lix0VlCBKHNwhF4CoSytIop2XoS
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


>=20
> +1. What functionality does this new mechanism add?
>=20
> Tunnelblick implements 2FA through the management interface using the
> existing static and dynamic challenge-response mechanism. For a
> dynamic challenge, for example. Tunnelblick gets a response from the user=
 in
> a popup window or from a user-specified script. (A script is usually
> used to get the response from hardware devices.)
>=20


It adds 2FA without reconnect dance and also the ability to do something
like web based SSO authentication. But a server should not use these
unless your client will announce support for them via IV_SSO variable.

The v2 version of the patch will describe the IV_SSO variable too.

Arne


--lTZ515Lix0VlCBKHNwhF4CoSytIop2XoS--

--Ad3BmOePk3SmUH4cXVEFQeU2YO344oAd0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl3G0+gACgkQFRhsZwKx
RFTniA//YuD370jarzY/gyqYCvWOvnV+fJLYzf+KJADTbiE94ar4abTtremsnRpM
dyuTJ02fFkqBFUykK4aY+BvYcyJZIGC3HPCdupz5ZTBQYcWi29vyfwct3j9Y/uJt
+5A1CWZtNBrvjTGi71xh2uqWWEHuQm8ISorheUo5WsL/eU1qp/N/XfMjFQbR/STr
Rpbq9FXjPMkra1FRsnyQjnp2wdEhP5+4KtZeMzO7IZVDNoWa+XR8n7PBXeUf/Xbu
veHlAwuOJr8LTTiQTmd0P9QAyNh9d6s+Q3YrX4Oe1yY1FNefNJm6SQS0/Q9F5ymr
Mr0f8EMtuifPIHwwOXFgfTI5qaM36GLxGmQ0uE9IBQCbVDw+sXImbayu8owlA+sc
eee776nSHZcs4pBTdfiYEgOAA9PTzcUcjbCDAJZHqbtWVKcosfothHXZJhY9+plZ
TvH9xy9JXlwICTmvRQlSlNH+2zDxCVZZqzXypQ39X/riUoDgeUYom62HExnw7Vlb
wIOP+E0yG2d9ILPgNoRt2rdshYDuP/eXCt2o+RE6Sr5priqBa1jizog58DLJpTNa
Whtj/1DJUgGJ3q42YVK9cZqEiYLpkUuT0OMpvBq6KnMk1FBOv6ANrb0CgEVswXsz
yfzTNCL9l0kvdLzmVmZGWlnBpbWpwmNSvuTks1aZ3BEgb56UG8c=
=yFKZ
-----END PGP SIGNATURE-----

--Ad3BmOePk3SmUH4cXVEFQeU2YO344oAd0--

