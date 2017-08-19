Reply-To: openvpn-devel@lists.sourceforge.net
References: <20170813205217.16736-1-chipitsine@...277...>
 <20170813205217.16736-2-chipitsine@...277...>
 <efccf463-749f-73d6-2c9c-94b17fc64f20@...1856...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <21c0790e-696f-1326-c48d-95f697fd56da@...2080...>
Date: Sat, 19 Aug 2017 22:58:13 +0200
MIME-Version: 1.0
In-Reply-To: <efccf463-749f-73d6-2c9c-94b17fc64f20@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="1HSjAwMVNxcMMmkd8r30TcU1MJhAoQK8G"
Subject: Re: [Openvpn-devel] [PATCH 1/1] travis-ci: add libressl build for
 osx
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1HSjAwMVNxcMMmkd8r30TcU1MJhAoQK8G
Content-Type: multipart/mixed; boundary="LCNUlASP293qJm0vPvhoULXmGac15pp8x";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: openvpn-devel@lists.sourceforge.net
Message-ID: <21c0790e-696f-1326-c48d-95f697fd56da@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] travis-ci: add libressl build for osx
References: <20170813205217.16736-1-chipitsine@...277...>
 <20170813205217.16736-2-chipitsine@...277...>
 <efccf463-749f-73d6-2c9c-94b17fc64f20@...1856...>
In-Reply-To: <efccf463-749f-73d6-2c9c-94b17fc64f20@...1856...>

--LCNUlASP293qJm0vPvhoULXmGac15pp8x
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 19/08/17 10:30, Steffan Karger wrote:
> Hi,
>=20
> On 13-08-17 22:52, Ilya Shipitsin wrote:
>> Tunnelblick ships openvpn binary built with libressl
>> (see https://github.com/Tunnelblick/Tunnelblick/issues/317 )
>=20
> I'm a bit on the fence about this one.  We do not support libressl,
> while including a libressl build in travis creates an image as if we do.
>  On the other hand, it is useful to know when libressl builds break.
> I'm leaning towards a NAK, to be perfectly clear about the state of our
> libressl support: "we do not support it, we do not test it, using it is
> completely at your own risk".

I agree with Steffan.  That is pretty clean; officially we only support
OpenSSL and mbed TLS.

The Tunnelblick project can easily enough re-use our Travis setup and
slightly modify it to add libressl to run those tests for their userbase
as well.  But that's their decision how they want to test their stuff.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--LCNUlASP293qJm0vPvhoULXmGac15pp8x--

--1HSjAwMVNxcMMmkd8r30TcU1MJhAoQK8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZmKZqAAoJEIbPlEyWcf3y3d0P/1qSDuQJjyCmqpiVMHrqx3Ij
7GPKqv2bMn2HtmstKPHUZ7sMMsLrw5s7kUizmOVxzshznrex0ozZzd12Ife90lAJ
CERL6GcttVXgxFISlxirs9FIKdujJFJyhFwd+pKiIhR7CH3RRasjpRib8PDpNVS3
zXXfF/GLyIKF1O6yi7M3c1f6wPZyoCX8X74QOd8zVf3V1jKSolAJfOkDviMge5YD
CYHrwrpaE/aQidO2zJ8+qUjgojhIyQBuuFnZHeAS8U8DInwE6PCF/s1bGvrfpYs0
tLC4pPsWD4cC8rBSQEd8wUtNKeYbEPy/WRMf1UGvbsQJ0gxvdzFiYKEROzw2AZSm
26q9p+YZ1vg1oun+iaGRBEriEO4SDO3wE84Sfnnlerqz08qZy52qrsXCdyqhoshL
R9aqb51VVTSPZZaXsh8DLXyI8vyqpY7UBsf91OFT8JN8M3Yo2VqoJb864fFhOvzn
ohqTTKqp4u6KUm4nlsmXhG4oeOlXn1GpfFkBtAS3i8eGPxJuL4W0njDG+1XFP+1R
W5r1cE5BKYGOm7WBlVBjng/SH95O69OPATQVOSjysuWAHt0Iy2Q0owdHTW+j7Gte
Um+X7P+QuoqMaZDlFTZQ+0CnLXgnAR4oUqiHS0sO6wbKxHOO7zpWfZ3DU3btNeKE
rjSaQpymfJ4z1dfGjYmV
=T74+
-----END PGP SIGNATURE-----

--1HSjAwMVNxcMMmkd8r30TcU1MJhAoQK8G--

