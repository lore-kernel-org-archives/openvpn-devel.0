Reply-To: openvpn-devel@lists.sourceforge.net
References: <20170807132301.22759-1-chipitsine@...277...>
 <20170807132301.22759-3-chipitsine@...277...>
 <a2e7511e-2416-cfbc-4b0f-5ffcf8f15e17@...2080...>
 <CAFHpkQHkXWR512UXjQiTFf78fOJE+9_xo6fpYvhm8xRS8y3Aqg@...278...>
 <0f2ce121-9076-810b-373c-fcc3357a2981@...2080...>
 <CAFHpkQFdg7Q-4ep9usyZ_6FyJGdWM0VYhRzghnMN5aerivWA9A@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <d4f5b393-ee52-9a84-ed96-e8b5e16f47f4@...2080...>
Date: Wed, 9 Aug 2017 11:31:29 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQFdg7Q-4ep9usyZ_6FyJGdWM0VYhRzghnMN5aerivWA9A@...278...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="j5NvSWNVFf6dfmoX0GX2H9Lpl1MELJxAD"
Subject: Re: [Openvpn-devel] [PATCH 3/3] add a test to "openvpn --help"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j5NvSWNVFf6dfmoX0GX2H9Lpl1MELJxAD
Content-Type: multipart/mixed; boundary="2UJXqo9M3Cwr0fg64FgCpaXNDtPijPXbq";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <d4f5b393-ee52-9a84-ed96-e8b5e16f47f4@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] add a test to "openvpn --help"
References: <20170807132301.22759-1-chipitsine@...277...>
 <20170807132301.22759-3-chipitsine@...277...>
 <a2e7511e-2416-cfbc-4b0f-5ffcf8f15e17@...2080...>
 <CAFHpkQHkXWR512UXjQiTFf78fOJE+9_xo6fpYvhm8xRS8y3Aqg@...278...>
 <0f2ce121-9076-810b-373c-fcc3357a2981@...2080...>
 <CAFHpkQFdg7Q-4ep9usyZ_6FyJGdWM0VYhRzghnMN5aerivWA9A@...278...>
In-Reply-To: <CAFHpkQFdg7Q-4ep9usyZ_6FyJGdWM0VYhRzghnMN5aerivWA9A@...278...>

--2UJXqo9M3Cwr0fg64FgCpaXNDtPijPXbq
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 09/08/17 07:55, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
[...]
>     >     For example:
>     >
>     >     $ ./openvpn --help | grep -- ^-- | wc -l
>     >     238
>=20
>     But to do the spoon feeding:
>=20
>     optcount=3D"$(${top_builddir}/src/openvpn/openvpn --help | grep -E --
>     ^-- | wc -l)"
>     if [ $outcount -lt 220 ];
>     then
>             exit_code=3D1
>     fi
>=20
>=20
> if you suggest "that's a better check", please describe your idea.
> it is not clear for me why your approach is better


The approach I suggest above covers:

a)  The program is able to execute and usage() works

b)  There is no unexpected bigger changes in usage(), the
    number of options are within a reasonable threshold.
    Granted, only minimum options is checked in the example above;
    extending with an upper limit is easy and quick (for example
    add '-o -gt 245')

c) If the program segfaults, optcount =3D> 0 which ensures this test
   fails.

With your check only testing if the exit code is not 1, you only have an
indication if the program segfaults or not.  You don't know if usage()
provides nothing but garbage and then exiting with 1.  Checking that a
certain amount of outputted lines starting with '--' gives an indication
that usage() most likely have a reasonable output.

It would also be possible to build further on this check I suggest, to
also check for mandatory options (--dev, --dev-type, --remote, --listen,
--port, --proto, etc, etc).  It is also possible to have a copy of the
expected "openvpn --help | grep -E -- ^--" output and do a diff -
probably filter out some less important/deprecated options).   While
these are a nice checks too, it is not as crucial as ensuring we have at
least an reasonable expected amount of options.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--2UJXqo9M3Cwr0fg64FgCpaXNDtPijPXbq--

--j5NvSWNVFf6dfmoX0GX2H9Lpl1MELJxAD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZitZ2AAoJEIbPlEyWcf3yD50P/RsuxDRPM86U7fgNjbxIb6/K
ID2lYDVipToFaGyg6UvL6e/gz3724X06WPDAtayDV3gKhG9QfTjZRcbTHFB6/4Ax
kMivA1abt3FczBZYxBBkzIoJzLItiywAjA+lsbSvIHV53rZwjxoe/PQFPzWS/FRO
n/LYdZmwGQnrD/cucIG17ok9EGwl+GwqnUEKZyLHjSmu8KYGCZMNB7PUFZXTEC3P
Ds8b0osCubDf0Nb6fi+Kr2P6UliH13u+LXg1dYPX7M3uYCxMBk7wlviesCSgvoGj
waecUH3pBvx1n/QJl3BoANApAD07L3asaZ9ubdBDfdPU3U7W9o9yQvnKPhkCrcAm
4r3Rfd6HaOVSLti7T8a0qfjpGZorlx131/RyxaOniLve9ONuI3CDpP8VhbuG04u1
yWgujhz2fxnhWkBciDIugO/UsJ+ZPi1FUbG/NMDZQPjo/N9cUZ0mv36s/HCD6Dz/
3el82xRrPnrvSrn+BdxhRRv41G+8bS30CO3MAS0qJI3gg6YQERlwWR4GL5NOSXmo
GI6Dh2S7IbhG+YmkeJtpYbm/14YUB49EseRNv/pDXv4LAZF2rPGn6++iCWzbTP3E
mJXITbSLtYiMZ7ZZ5qf6faeuOrtAzTTJNPEDyH8uiwVNb81DgKp47g8wffE/pJIH
TyC8YOs1RVc/aXNRk7K4
=LICw
-----END PGP SIGNATURE-----

--j5NvSWNVFf6dfmoX0GX2H9Lpl1MELJxAD--

