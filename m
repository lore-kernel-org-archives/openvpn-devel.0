References: <20170426160021.25122-1-davids@...515...>
	<29e6daf6-6423-5fb7-ff55-7710b528ddab@...1856...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <1349e743-76a0-b021-0e26-94bb7694e820@...2080...>
Date: Thu, 4 May 2017 00:57:51 +0200
MIME-Version: 1.0
In-Reply-To: <29e6daf6-6423-5fb7-ff55-7710b528ddab@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ngNo6PH6TQfDCxsmHi3EspjMLD1PNNnQE"
Subject: Re: [Openvpn-devel] [PATCH] crypto: Enable SHA256 fingerprint
 checking in --verify-hash
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ngNo6PH6TQfDCxsmHi3EspjMLD1PNNnQE
Content-Type: multipart/mixed; boundary="fD4eC5qDCqlhPXFPgD0gF4HpFv83BS2ER";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <1349e743-76a0-b021-0e26-94bb7694e820@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] crypto: Enable SHA256 fingerprint
	checking in --verify-hash
References: <20170426160021.25122-1-davids@...515...>
	<29e6daf6-6423-5fb7-ff55-7710b528ddab@...1856...>
In-Reply-To: <29e6daf6-6423-5fb7-ff55-7710b528ddab@...1856...>

--fD4eC5qDCqlhPXFPgD0gF4HpFv83BS2ER
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 03/05/17 22:15, Steffan Karger wrote:
>> +        switch (opt->verify_hash_algo)
>> +        {
>> +        case MD_SHA1:
>> +            ca_hash =3D x509_get_sha1_fingerprint(cert, &gc);
>> +            break;
>> +
>> +        case MD_SHA256:
>> +            ca_hash =3D x509_get_sha256_fingerprint(cert, &gc);
>> +            break;
>> +        }
> This switch should have a default: case that fails, otherwise we might
> be reading from uninitialized memory.  And you might want to consider
> initializing ca_hash to "{ 0 }".  (But you still need to default: case,
> otherwise you'll be doing a 0-length memcmp()).

*grmbl*  I was sure the enumerated type would make the compiler
complain, but I must have mixed this with some C++ stuff I read not too
long ago.  But my stupid test allows assigning an enumerated type to any
invalid value as well.

I'll double check again tomorrow (when head and mind is fresh) and
submit a v2.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--fD4eC5qDCqlhPXFPgD0gF4HpFv83BS2ER--

--ngNo6PH6TQfDCxsmHi3EspjMLD1PNNnQE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZCmB0AAoJEIbPlEyWcf3yn8YP/0h8JhVS9JyGM1dyNuBinPjG
SJNGf3GXjHQnVt1SREMVqYPZAlrQKxQvGcNGasxbxaigpiWhH4l/K0rjPx35MzN2
VgGiu3iGPLWb813b153r6qn9R1RvXWY/1NX29YMUMJYyvh8QOs1Uc9BzoPrN79TM
slnQmByLFYUYQ/0UVTRJB3VJoE7Rg07kLin164KhPHnr86M02zUoXlcFqSzfWq+g
vfqTIK528LmkV5pVneXgPWUFXDwcEtWw4k3bn2n92kKH8pmxmraifAC5cX3h3mZh
9N1W7Lxfqr+t9hogoJ+Gcr7STIYiQxf7OHR9ssTcD5Wb9ZI+whrHyllGzQoEZKtW
TQjz1uhPXRbzFN9LEixajJiTsgiw8Ju9mAsCCXjMhWF+TUw6/0FsEA0Wkhkeogoc
A/mhghS0G30whEh+5eNU5gBETtZ8e85GvUSuTgvchCH2kS6IlT150VrA6zB6llEP
BSyDfEiVjFzxWgxY7uqhJV0ABTQD+TLHhIYrMtnXwJOiaYeZ/SRYmlCRPctUgIFu
5f7N/qv7ct+QTIEKfgeXq+fix76hO/c+SEI9nRxjHkYh7td7nYnfssWXk+EW3+X4
oQE0jDGJKgBXYDt9Vfi3BX6BjsFL2wNKC0WQcNTG64ujzXtw1f+KrML8duvqPM7y
G5BG22KyH3ogafu2cIIz
=twLv
-----END PGP SIGNATURE-----

--ngNo6PH6TQfDCxsmHi3EspjMLD1PNNnQE--

