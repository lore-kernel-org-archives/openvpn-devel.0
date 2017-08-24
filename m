Reply-To: openvpn-devel@lists.sourceforge.net
References: <20170824133305.25604-1-a@...2181...>
 <20170824191848.GH70062@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <011fb50e-4b84-6f2c-c730-dc419b840f6f@...2080...>
Date: Thu, 24 Aug 2017 22:21:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170824191848.GH70062@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Ll0ruifUHUotbOfVkJ7rbH5Vgb0CcLd37"
Subject: Re: [Openvpn-devel] [PATCH] bash: substitute legacy `` with modern
 $()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ll0ruifUHUotbOfVkJ7rbH5Vgb0CcLd37
Content-Type: multipart/mixed; boundary="C3vU8Q0FvJ9I281KI0lrFWxJFCLsq2NkG";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>, Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <011fb50e-4b84-6f2c-c730-dc419b840f6f@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] bash: substitute legacy `` with modern
 $()
References: <20170824133305.25604-1-a@...2181...>
 <20170824191848.GH70062@...1296...>
In-Reply-To: <20170824191848.GH70062@...1296...>

--C3vU8Q0FvJ9I281KI0lrFWxJFCLsq2NkG
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 24/08/17 21:18, Gert Doering wrote:
> (gen-release-tarballs.sh only needs to work on FreeBSD and Linux, and
> FreeBSD's /bin/sh is sufficiently modern so so it's likely to work
>  - but the test scripts need to run robustly everywhere a user builds,
> so never assume "because bash says so!" is a way anywhere but into worlds
> of pain.  And yes, we've been there before :-) )

And to avoid style confusions ... as long as we can avoid having "one
style" on the test scripts and "another style" on the dev-tools scripts,
that will be easier to review and maintain.

We can have more slack in dev-tools, but if we deviate, then we need to
properly document it so we won't forget why.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--C3vU8Q0FvJ9I281KI0lrFWxJFCLsq2NkG--

--Ll0ruifUHUotbOfVkJ7rbH5Vgb0CcLd37
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZnzVgAAoJEIbPlEyWcf3yOGkQAKXpoDGSV++xr+UhWW/YEOAe
WuAVejouEYBTAT/aVax3MUYYCRqAknXj95TcVStKF9SGnN2qeRrKyIvLP0Pc/Ofu
/qiC/csqJhmPrA+rGD+O5b2LSr8Oc8u668XOPxjpJDEDZLiYHgo1NuVpaYalCpa5
KHj4gD15a6ZYQYWWw5TEZKdB97wDC8AOcAFsSKycKXPtldd0usbf3iyCsUtxdCk5
cUVpLq85SQRM08VGaXW4sn9vY7A8/rCru9E/MhF7W0avrfrqHWVPj3bcN8Kc/tbP
OoWTL83k+diDcA/bPpwJrQGa33bn7MiA/XapOsKLT8EF6FFaWH6g4bp71sYZCUEY
K+pmub2GG5o+tWvKKDgxSDOwSZ/+RGxhWW+TTgxsxtkuwCsKMBwcPtRkDj9g5p+T
Kzq/W+Q34OAlPKohKPNRXMyE66SWOniztU9BDZr1f83HWNfdX7y9eQe2nWiL7ptU
C9CKWyIDjy6woU+kQMdYE6L2XKozkdrEA1rh5FuCrYVWGzOeuedv6Lnmckq1BIn4
/mSkPrdkkfcRtEHAW3hOiuIl/8svWo2E0gsdAbgL0M7pesuvnpV0YuNEsBhGWoB+
XKSP/OoAVdeXMf9+eEwHco/VMThrHvZV+2Oe9bsS71RMZzsw6iB6UEIgdabSSSci
Aae4Xx7PhYrhF/Jc6xSW
=sGW2
-----END PGP SIGNATURE-----

--Ll0ruifUHUotbOfVkJ7rbH5Vgb0CcLd37--

