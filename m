Reply-To: openvpn-devel@lists.sourceforge.net
References: <20170907022827.10658-1-davids@...515...>
 <20170907061333.GC70062@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <f5f4d25e-ad01-9431-39b3-17aed04126de@...2080...>
Date: Thu, 7 Sep 2017 15:23:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170907061333.GC70062@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="HmnO0h3AN01hsxUBVaCpg2QqTqvq6gkcj"
Subject: Re: [Openvpn-devel] [PATCH] lz4: Move towards a newer LZ4 API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HmnO0h3AN01hsxUBVaCpg2QqTqvq6gkcj
Content-Type: multipart/mixed; boundary="7EMnqEWgfLjH4MVC8th6sdAbp0nFc5AIR";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>, David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <f5f4d25e-ad01-9431-39b3-17aed04126de@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] lz4: Move towards a newer LZ4 API
References: <20170907022827.10658-1-davids@...515...>
 <20170907061333.GC70062@...1296...>
In-Reply-To: <20170907061333.GC70062@...1296...>

--7EMnqEWgfLjH4MVC8th6sdAbp0nFc5AIR
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 07/09/17 08:13, Gert Doering wrote:> HI,
>=20
> On Thu, Sep 07, 2017 at 04:28:27AM +0200, David Sommerseth wrote:
>> We are using a deprecated function, LZ4_compress_limitedOutput(), which
>> will be removed with time.  The correct function to use is LZ4_compress_=
default().
>> Both function takes the same number of arguments and data types, so the =
change
>> is minimal.
>=20
> I wonder why we should bother to have a wrapper function here.
>=20
> We can ship a lz4 library that has the new function, and if a system only
> provides an older version, declare it unsuitable (configure check) and
> use the bundled one.

Yeah, I was thinking along those lines too when working on this patch.
I just remembered vaguely our IRC chat long time a go and looked back at
the initial mail discussion, and there was a preference for the wrapping
back then.

But I like much more that we have a defined LZ4 version which we
support, and ditch the #ifdef'ed wrapper.  I'll send a v2 soon.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--7EMnqEWgfLjH4MVC8th6sdAbp0nFc5AIR--

--HmnO0h3AN01hsxUBVaCpg2QqTqvq6gkcj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZsUhHAAoJEIbPlEyWcf3y5EQP/1+jfkevlkkdwu/iX4nndh03
Noyo6aLLwLoWrJN9uN4ebwTqFrE8gci0Dvg5A0PdiFocwLchLJwlonZjLBatVvPS
1G6flx9CMQ2aMRW5KRc1scuYbJCOxgtlapgc8I8MIyo2bLkH7JQn306bLfMVm2kf
VO5qRyGVRqo9KBQsrnyxdaO3POUUhCi6JARsuouLYYCs0qeVbSwV99w8ydIAFxTS
mg+pDyGIm4k+s1Al/PABPrnFQSrRxRGNjXICk+sUhZt1H4JnOwcn7ip3g5DjzIV8
1NaMikfzBQmNvQ9CtxeWKp7wLZajCxujbFfauCWL8RIY/9QW3h57iDLFxdeSUJJW
pHgDRzohho1uApj/54nnbo6i38UAhtYuVEr9Pt9Km2z8/+jfW34jGbME1rq2ZPiz
WsgMOPdZbr2x+xDFXhGgqomCtvatqJMz3Qo5CHqLAa5Hk0NmJUWtGN+I/zEgcu60
pBSrM3Pv/YSDDu6RwIVkSwhq+oGa4GVQt+YHGMjJ9TvEfiF/LdjL4Tdl3aRyiDcp
sjekQcoktPamB5DPrXIk7hTflMWqMF8HieDstR9b+UefkYZuvbwP5dt9AVxPSCaP
0qMrimuRuNzeiVT+A5Uwk/1tDgp8IfBy0rZtJzfE12vXfJdEXgY2Mmv+qmz5T5Xh
U+8MwqLRqpuZ6tX/3Rrq
=RQ4r
-----END PGP SIGNATURE-----

--HmnO0h3AN01hsxUBVaCpg2QqTqvq6gkcj--

