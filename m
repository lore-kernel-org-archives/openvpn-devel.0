Reply-To: openvpn-devel@lists.sourceforge.net
References: <20170807132301.22759-1-chipitsine@...277...>
 <20170807132301.22759-3-chipitsine@...277...>
 <a2e7511e-2416-cfbc-4b0f-5ffcf8f15e17@...2080...>
 <CAFHpkQHkXWR512UXjQiTFf78fOJE+9_xo6fpYvhm8xRS8y3Aqg@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <0f2ce121-9076-810b-373c-fcc3357a2981@...2080...>
Date: Tue, 8 Aug 2017 20:44:04 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQHkXWR512UXjQiTFf78fOJE+9_xo6fpYvhm8xRS8y3Aqg@...278...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="IJbEx11430Xp82On3MXBJ0XI4lTTIvbLR"
Subject: Re: [Openvpn-devel] [PATCH 3/3] add a test to "openvpn --help"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IJbEx11430Xp82On3MXBJ0XI4lTTIvbLR
Content-Type: multipart/mixed; boundary="nRWox3FMSct8nfivj614Bqh2TvAWlHM3J";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <0f2ce121-9076-810b-373c-fcc3357a2981@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] add a test to "openvpn --help"
References: <20170807132301.22759-1-chipitsine@...277...>
 <20170807132301.22759-3-chipitsine@...277...>
 <a2e7511e-2416-cfbc-4b0f-5ffcf8f15e17@...2080...>
 <CAFHpkQHkXWR512UXjQiTFf78fOJE+9_xo6fpYvhm8xRS8y3Aqg@...278...>
In-Reply-To: <CAFHpkQHkXWR512UXjQiTFf78fOJE+9_xo6fpYvhm8xRS8y3Aqg@...278...>

--nRWox3FMSct8nfivj614Bqh2TvAWlHM3J
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 07/08/17 20:25, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
[...]
>     > +"${top_builddir}/src/openvpn/openvpn" --help >/dev/null
>     > +
>     > +if [ $? -ne 1 ]
>     > +then
>     > +   exit_code=3D1
>     > +fi
>=20
>     This check is odd.  Where the --help option is parsed, it calls usage=
(),
>     usage_small().  And those functions will always call:
>=20
> Sometimes it segfaults.

That's no real argument, see below.

>        openvpn_exit(OPENVPN_EXIT_STATUS_USAGE);
>=20
>     And OPENVPN_EXIT_STATUS_USAGE is defined as:
>=20
>     error.h:#define OPENVPN_EXIT_STATUS_USAGE                   1
>=20
>     I would rather recommend you to grep for some information you expect =
to
>     be listed in --help and check if that was found instead.
>=20
>=20
> I tried to implement it with cmocka. However, I gave up

I didn't say this should be implemented in C and CMocka ... hence the
example below.  And that check below would implicitly account for SEGV
scenarios as well.

>     For example:
>=20
>     $ ./openvpn --help | grep -- ^-- | wc -l
>     238

But to do the spoon feeding:

optcount=3D"$(${top_builddir}/src/openvpn/openvpn --help | grep -E -- ^-- |=
 wc -l)"
if [ $outcount -lt 220 ];
then
	exit_code=3D1
fi


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--nRWox3FMSct8nfivj614Bqh2TvAWlHM3J--

--IJbEx11430Xp82On3MXBJ0XI4lTTIvbLR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZigZ6AAoJEIbPlEyWcf3yT54P/1PuusdYvq0zYoCVzuzHJhAU
yQ7aoIzbHKQU3Ryz2zpwUe2R01O1mi9ogBIkiG6f8KkU+D0L8l03bHpLFl1g+1KT
XcNV38TkWVOe1aO9Zv4CVQnysHiFxOVEbebVHYKcxGLBKjUMGUAVtsprolwBGaBd
BvZUORcctUqaT+j46Jev/G40J9Ai61X90W+wpyQqH1oFvaR59pKwCBrRcEV1m6AL
aOaWrdP26E9fGj9OAkKjSoUyT3EIe41swrsmRTweofevPCSdmYzTa0DV92KLHSbf
F7aj75XinhK2ChZ2LF/zA7Qe+zVh/qc6hpNWk89cZZSeL6XYgqK3GlCUvqNd5OEE
KUBZFp7IOgNtM5+FHKZcvwOMBBhCfwAzuuZRLi/ZYyKXy9B5WuN9Z59EnMIEnr7M
68sfz+2vFzCti/mL0Vo/5YCj1orojvm8WjopfZo9aGRS5ZqjluWMxZTl7aVnyd7t
1/N+dnQ3FR4XRO//yYw6i0IZWHcgtKDEkD8P9FWRBlHfHy2vzA+LDmZrix8+sHdx
NmC0BnW443O49uhUcrB0tsdOLqsRKhSnc43hHN5Vu6bIFPPyPom7mmwiZGkZVzMk
Wc2fk0r7Esz+7TZVdksdW/Qt/HxiVRYDgWZDJK/4BuN9caCxR87y1arKO7N1/UtS
NBZwnOZEnll8LaOkqp7t
=XPcg
-----END PGP SIGNATURE-----

--IJbEx11430Xp82On3MXBJ0XI4lTTIvbLR--

