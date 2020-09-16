References: <20200616180046.8069-1-juliusz@...2525...>
 <c926d584-471b-c66e-21f8-4c31410b5e4f@...2525...>
 <4f5787ef-fa03-f7d1-db9a-52fe61caf281@...1227...>
 <4cb6ea57-4dd1-8230-cec4-d4e8f434944b@...2525...>
 <5b5bd12b-d2a0-8901-1a0e-4ba7b3e5f7d0@...1227...>
 <9630aa71-2ba0-879a-3345-85a9551cd169@...2525...>
 <1e682031-8b10-7beb-1379-b32535f40de8@...1227...>
 <1998772f-b476-1862-9102-b95fd1a33be7@...2525...>
 <8e766bf2-a64e-63de-c69d-e899d2a11165@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <ea65d5d0-83b2-3c5f-7473-d19fabf463bb@...2080...>
Date: Thu, 17 Sep 2020 00:58:15 +0200
MIME-Version: 1.0
In-Reply-To: <8e766bf2-a64e-63de-c69d-e899d2a11165@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="pMyLNAAckYFFtMSqwFnRi4DAkmceXVceP"
Subject: Re: [Openvpn-devel] [PATCH] Support for wolfSSL in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Juliusz Sosinowicz <juliusz@...2525...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pMyLNAAckYFFtMSqwFnRi4DAkmceXVceP
Content-Type: multipart/mixed; boundary="arQ9GWRIK1WIQHuvKyHGhlcLaxfMZgTg3";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Juliusz Sosinowicz <juliusz@...2525...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Cc: Arne Schwabe <arne@...1227...>
Message-ID: <ea65d5d0-83b2-3c5f-7473-d19fabf463bb@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Support for wolfSSL in OpenVPN
References: <20200616180046.8069-1-juliusz@...2525...>
 <c926d584-471b-c66e-21f8-4c31410b5e4f@...2525...>
 <4f5787ef-fa03-f7d1-db9a-52fe61caf281@...1227...>
 <4cb6ea57-4dd1-8230-cec4-d4e8f434944b@...2525...>
 <5b5bd12b-d2a0-8901-1a0e-4ba7b3e5f7d0@...1227...>
 <9630aa71-2ba0-879a-3345-85a9551cd169@...2525...>
 <1e682031-8b10-7beb-1379-b32535f40de8@...1227...>
 <1998772f-b476-1862-9102-b95fd1a33be7@...2525...>
 <8e766bf2-a64e-63de-c69d-e899d2a11165@...1227...>
In-Reply-To: <8e766bf2-a64e-63de-c69d-e899d2a11165@...1227...>

--arQ9GWRIK1WIQHuvKyHGhlcLaxfMZgTg3
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 17/09/2020 00:05, Arne Schwabe wrote:
> This snippet in the configure.ac looks strange:
>=20
> 	if test -n "${WOLFSSL_DIR}"; then
> 		wolfssldir=3D"${WOLFSSL_DIR}"
> 	else
> 		wolfssldir=3D"/usr/local/include/wolfssl"
> 	fi
>=20
> I am not sure hardcoding a /usr/local path is something we want/allow.
> The people better at autoconf might have a better idea on this.

I'll bite on this one.

You seem to install wolfssl.pc in an appropriate directory, so it should
really pull the default path using PKG_CHECK_MODULES instead.  Having
overrides. like we do with OpenSSL (with OPENSSL_LIBS and OPENSSL_CFLAGS), =
is
fine.

The main challenge with the pkg-config is that it must use the same directo=
ry
on the system as the rest of the development packages uses.  This is usually
not an issue for developers using a distro package of the library; these
packages install all these pkg-config files in the appropriate directory.  =
The
challenge is more for those compiling and installing unpackaged versions of
the library; which is where the WOLFSSL_LIBS and WOLFSSL_CFLAGS comes into =
play.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--arQ9GWRIK1WIQHuvKyHGhlcLaxfMZgTg3--

--pMyLNAAckYFFtMSqwFnRi4DAkmceXVceP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJfYpiHAAoJEIbPlEyWcf3yLS0QAJ+OrJrdwQQCDvXPsReTUH5Z
bQng1Jbed+bY0VCUEW9lLALA+EGvr4F2wHTRoz3DX+pSGSZu6fOHljUhn8DGF3hv
GPicvvPowvhgQFiM4ksOPq7x6kfDasLk/+MaVqPzxg3oiobdlbQc40mXGz8OOYQU
kjUygHg79fyPV7DrOH100B3+vEJmq4hgd7XL+mCr3hV5/5nmZTJAyRt7ggiq1ITV
tbAQYSYDLuqPCE0aeQ78s5mORlplCTBGoJjp75+ET+VQ02SdkCzjBY25vq96ye4f
4oX9W9/ENKBj3lYN+rpASxsRqjSBdESi5KnhuIy5rivlFQZalQgbX5EYYy2798lh
Hwggw2zKHyU3pCOTq45TS4g29VJtUSU/DlHDHrKH3qeHcMzfYtxNYaXgG/aAc37E
UYMCXSdgKyJoBXYAJSjkfEZS6vv0y/LI8+DpnLgW1xbgjhRHCvzOkcbIZfFRCX1W
5xw5RkbmYC6fazi+xXDQIiwRnvOP8wVWs87by3z1nbm2AQ+VsjkzPkrA+3B4+BVd
HwHNLd+RKBOnHawdlRdt0ePNlRDwIWUtjVaBuXrl0e2UOH9bSJXrcB63fQPmkBYU
BKpBd/yZe6Vdi9j4tHV0ak9Xu6T74/XcuqTWHSuCYw1N/WoLy6AsXCGiolEoR3Fq
h/9qvC8Jyu0mmM9TIVj0
=25B8
-----END PGP SIGNATURE-----

--pMyLNAAckYFFtMSqwFnRi4DAkmceXVceP--

