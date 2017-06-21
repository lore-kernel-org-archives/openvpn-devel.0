References: <c129e755-6c9e-a35f-2958-84b44baa96f2@...515...>
	<CAEsd45RR25O+vw=70Q5ZXRc+nnw19t+gjtz4+yiuOMM350vgcg@...278...>
	<173d674815ccc3a42fc615dbebeb3b0a.squirrel@...2257...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <a36da645-f114-bbb8-7d28-c2357a76b77e@...515...>
Date: Wed, 21 Jun 2017 17:33:55 +0300
MIME-Version: 1.0
In-Reply-To: <173d674815ccc3a42fc615dbebeb3b0a.squirrel@...2257...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PhtLxwwcjlCvDWPSvc3bvWdiln3Jslgxf"
Subject: Re: [Openvpn-devel] OpenVPN 2.4.3 released (with security fixes)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Matter <simon.matter@...2249...>, "Jonathan K. Bullard" <jkbullard@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PhtLxwwcjlCvDWPSvc3bvWdiln3Jslgxf
Content-Type: multipart/mixed; boundary="fW2ThnQ1aTcfU3KmWNElWE8jcIXx6BVa9";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: Simon Matter <simon.matter@...2249...>,
 "Jonathan K. Bullard" <jkbullard@...277...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <a36da645-f114-bbb8-7d28-c2357a76b77e@...515...>
Subject: Re: [Openvpn-devel] OpenVPN 2.4.3 released (with security fixes)
References: <c129e755-6c9e-a35f-2958-84b44baa96f2@...515...>
 <CAEsd45RR25O+vw=70Q5ZXRc+nnw19t+gjtz4+yiuOMM350vgcg@...278...>
 <173d674815ccc3a42fc615dbebeb3b0a.squirrel@...2257...>
In-Reply-To: <173d674815ccc3a42fc615dbebeb3b0a.squirrel@...2257...>

--fW2ThnQ1aTcfU3KmWNElWE8jcIXx6BVa9
Content-Type: multipart/mixed;
 boundary="------------D10777ADE683DF0DE69512A2"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------D10777ADE683DF0DE69512A2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 21/06/2017 17:06, Simon Matter wrote:
>> On Wed, Jun 21, 2017 at 6:47 AM, Samuli Sepp=C3=A4nen <samuli@...515...>
>> wrote:
>>> The OpenVPN community project team is proud to release OpenVPN 2.4.3. It
>>> can be downloaded from here:
>>>
>>> <http://openvpn.net/index.php/open-source/downloads.html>
>>
>> Hi. Thanks for this release.
>>
>> Verifying the PGP signature on 2.3.17.tar.gz works fine (so did 2.4.2
>> a few weeks ago), but trying to verify the signature on 2.4.3.tar.gz
>> fails with:
>=20
> I wanted to ask this during the 2.4.2 hickup but now I really ask because
> there is confusion again with 2.4.3:
>=20
> Could you please add check sums of all release files so that one can
> easily check to have the correct download. Even MD5 works better no check
> sum :-)
>=20
> Regards,
> Simon
>=20

Makes sense. I'll see if I could tackle that tomorrow.

Meanwhile I added a test script which downloads every release file and
verifies their signatures. I will run this script as part of the release
process.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------D10777ADE683DF0DE69512A2
Content-Type: application/pgp-keys;
 name="0x40864578.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0x40864578.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v2

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
XuwT7RpGDZ6jBfphYQ=3D=3D
=3DFKLE
-----END PGP PUBLIC KEY BLOCK-----

--------------D10777ADE683DF0DE69512A2--

--fW2ThnQ1aTcfU3KmWNElWE8jcIXx6BVa9--

--PhtLxwwcjlCvDWPSvc3bvWdiln3Jslgxf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJZSoPTAAoJEClYTZ9AhkV4DuYH/1ZQ+L5+fb6mj1DzIxJVdBWF
V2J8Cp11rqsKaFHIh9NklsF+le8gRx2MFHOd4yOOkRoXK7aDTLFELXdgWr9iiYBv
nl4P8gN9haYg7PwAN2+A5qCU/ZHtDxHrLtNp/POQZ6O57DLVCOeF5X4XlpZf3t8Q
lHkirTxl3fyH0dzUX4BWsKBZsRvTQHRrHl2Q3lEES3dg8u361UYoIpvuu/L1oDXe
nsaBx2bX6W57F6QF+mbIrod3sldQ7Pb29iIzXwBIP4vjQNdLnXWxXjnEt/ptUrhl
qYsjpmbU1Bf3dz7ihbsFN8AQb9GgHKZ/wm14fmmBgMiTVH9VssKmS2qWwXOBsKY=
=OQPI
-----END PGP SIGNATURE-----

--PhtLxwwcjlCvDWPSvc3bvWdiln3Jslgxf--

