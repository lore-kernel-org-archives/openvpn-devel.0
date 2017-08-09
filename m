Reply-To: openvpn-devel@lists.sourceforge.net
References: <20170807132301.22759-1-chipitsine@...277...>
 <20170807132301.22759-3-chipitsine@...277...>
 <a2e7511e-2416-cfbc-4b0f-5ffcf8f15e17@...2080...>
 <CAFHpkQHkXWR512UXjQiTFf78fOJE+9_xo6fpYvhm8xRS8y3Aqg@...278...>
 <0f2ce121-9076-810b-373c-fcc3357a2981@...2080...>
 <CAFHpkQFdg7Q-4ep9usyZ_6FyJGdWM0VYhRzghnMN5aerivWA9A@...278...>
 <d4f5b393-ee52-9a84-ed96-e8b5e16f47f4@...2080...>
 <CAFHpkQFFPVGOFr=F-5zTFUqgEjfEv1xyLEs95j5KihyyC6AKmA@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <d2dfddc7-a5cb-d9a6-c450-a5bc7732c79f@...2080...>
Date: Wed, 9 Aug 2017 13:03:35 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQFFPVGOFr=F-5zTFUqgEjfEv1xyLEs95j5KihyyC6AKmA@...278...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="oABis58IUKv2Dh8esra0QSrbnMAsL83JF"
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
--oABis58IUKv2Dh8esra0QSrbnMAsL83JF
Content-Type: multipart/mixed; boundary="pW0EiTKC139NKRXugNrG4bobA0Dpc86Vv";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <d2dfddc7-a5cb-d9a6-c450-a5bc7732c79f@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] add a test to "openvpn --help"
References: <20170807132301.22759-1-chipitsine@...277...>
 <20170807132301.22759-3-chipitsine@...277...>
 <a2e7511e-2416-cfbc-4b0f-5ffcf8f15e17@...2080...>
 <CAFHpkQHkXWR512UXjQiTFf78fOJE+9_xo6fpYvhm8xRS8y3Aqg@...278...>
 <0f2ce121-9076-810b-373c-fcc3357a2981@...2080...>
 <CAFHpkQFdg7Q-4ep9usyZ_6FyJGdWM0VYhRzghnMN5aerivWA9A@...278...>
 <d4f5b393-ee52-9a84-ed96-e8b5e16f47f4@...2080...>
 <CAFHpkQFFPVGOFr=F-5zTFUqgEjfEv1xyLEs95j5KihyyC6AKmA@...278...>
In-Reply-To: <CAFHpkQFFPVGOFr=F-5zTFUqgEjfEv1xyLEs95j5KihyyC6AKmA@...278...>

--pW0EiTKC139NKRXugNrG4bobA0Dpc86Vv
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 09/08/17 12:28, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
>=20
>=20
> 2017-08-09 14:31 GMT+05:00 David Sommerseth
> <openvpn@...2080...
> <mailto:openvpn@...2080...>>:
>=20
>     On 09/08/17 07:55, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=
=D1=86=D0=B8=D0=BD wrote:
>     [...]
>     >     >     For example:
>     >     >
>     >     >     $ ./openvpn --help | grep -- ^-- | wc -l
>     >     >     238
>     >
>     >     But to do the spoon feeding:
>     >
>     >     optcount=3D"$(${top_builddir}/src/openvpn/openvpn --help | grep=
 -E --
>     >     ^-- | wc -l)"
>     >     if [ $outcount -lt 220 ];
>     >     then
>     >             exit_code=3D1
>     >     fi
>     >
>     >
>     > if you suggest "that's a better check", please describe your idea.
>     > it is not clear for me why your approach is better
>=20
>=20
>     The approach I suggest above covers:
>=20
>     a)  The program is able to execute and usage() works
>=20
>     b)  There is no unexpected bigger changes in usage(), the
>         number of options are within a reasonable threshold.
>         Granted, only minimum options is checked in the example above;
>         extending with an upper limit is easy and quick (for example
>         add '-o -gt 245')
>=20
>     c) If the program segfaults, optcount =3D> 0 which ensures this test
>        fails.
>=20
>     With your check only testing if the exit code is not 1, you only have=
 an
>     indication if the program segfaults or not.  You don't know if usage()
>     provides nothing but garbage and then exiting with 1.  Checking that a
>     certain amount of outputted lines starting with '--' gives an indicat=
ion
>     that usage() most likely have a reasonable output.
>=20
>     It would also be possible to build further on this check I suggest, to
>     also check for mandatory options (--dev, --dev-type, --remote, --list=
en,
>     --port, --proto, etc, etc).  It is also possible to have a copy of the
>     expected "openvpn --help | grep -E -- ^--" output and do a diff -
>     probably filter out some less important/deprecated options).   While
>     these are a nice checks too, it is not as crucial as ensuring we have=
 at
>     least an reasonable expected amount of options.
>=20
>=20
>=20
> I'm afraid that that approach introduce implicit things (while my is
> pretty explicit).
> Value seems questionable for me.

Well, then I'm just giving this patch a NAK, to be explicit.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--pW0EiTKC139NKRXugNrG4bobA0Dpc86Vv--

--oABis58IUKv2Dh8esra0QSrbnMAsL83JF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZiuwHAAoJEIbPlEyWcf3ySakQAKl+/2yreZ+E/dTVn4kjysEW
hzFM4mTAmbUMcWLniN8ma10dDiH+DCJYTB66WFFq2t/6eBROdoWTAwIy9TGzjxmP
eUha9j+4zDd6HQ2xb9dy3nkqjOaXU5PtdWLaVaAW6yEqqUv87BlCd88yq/1GKiK4
7N3bDoBXNnnJTtyrE8KCS3YVhN4Uof8FeexbdOdyHQ5zgXezhRrLW1WSGL8wRcl0
oHCbSjHm9Gw7ucGJFFDAjCCPKNAa53Lxzjh2RxrZeBwnAIPPBXT9o7da2ob+o4cD
1+vEBHZUyR2/EC30YCcYqNM7DIrfJ65avJlTCRS5w8yRqxD9uAArCSHFCI75FFS6
wuyfjIREbq8Berb+rwZ2jHGJCC6rjKffl574YetMS1pd8G3XaOXaJiKd0DaorQVK
M39z5JQ9RxfI34ewH9iEvdhIHLu19lS19IxzJlzPP7V/KJHTfhHnar1uXJnsOHSO
D7UEY0K6hTWhQDVrcYZDytUXBO6VKMnB+aQo7BgWMa1gGV3nzJB5shQez4yhdghw
rxrbLWGcQubOXcBWPelRpc2K8xB8XQgPaMkOF12Ud4eSEDKfwNUis1WOprteNcBZ
83t2WuYQUi3PI0oWHi/QlXoU7gZ59PxiQwLKvPbkicjXfnsiNwJQ3GuRD+tbB4IQ
kBUwl5f1waoK2kPSNOtl
=BGfB
-----END PGP SIGNATURE-----

--oABis58IUKv2Dh8esra0QSrbnMAsL83JF--

