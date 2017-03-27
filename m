References: <1490444478-13188-1-git-send-email-chipitsine@...277...>
	<20170325131746.GC93896@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <5cbc00da-6297-c90a-611c-63ed9b0136a0@...2080...>
Date: Mon, 27 Mar 2017 23:40:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170325131746.GC93896@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="q2TQvi1NkTeU0fhRjW8k0N6UX7mx4SiLm"
Subject: Re: [Openvpn-devel] [PATCH] resolve format string warnings
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Ilya Shipitsin <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q2TQvi1NkTeU0fhRjW8k0N6UX7mx4SiLm
Content-Type: multipart/mixed; boundary="uHXGsVm73iTrr7GgOnQCv9oraiC78ObfE";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>, Ilya Shipitsin <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <5cbc00da-6297-c90a-611c-63ed9b0136a0@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] resolve format string warnings
References: <1490444478-13188-1-git-send-email-chipitsine@...277...>
	<20170325131746.GC93896@...1296...>
In-Reply-To: <20170325131746.GC93896@...1296...>

--uHXGsVm73iTrr7GgOnQCv9oraiC78ObfE
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 25/03/17 14:17, Gert Doering wrote:
> Hi,
>=20
> On Sat, Mar 25, 2017 at 05:21:18PM +0500, Ilya Shipitsin wrote:
>> [src/openvpn/options.c:1163]: (warning) %x in format string (no. 1) requ=
ires 'unsigned int *' but the argument type is 'signed int *'.
>=20
> Please use "uint8_t" then, and also adapt the "ret[i] =3D (uint8_t)byte"
> line - the cast would then be obsolete.

I would normally agree to use uint8_t ... but the man page for sscanf()
on Linux says:

   "Matches an unsigned hexadecimal integer; the next pointer must be a
    pointer to unsigned int."

And stdint.h declares: typedef unsigned char           uint8_t;

AFAIR, char is defined as 8 bits (hence uint*8*), while unsigned int are
32 bits on my system.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--uHXGsVm73iTrr7GgOnQCv9oraiC78ObfE--

--q2TQvi1NkTeU0fhRjW8k0N6UX7mx4SiLm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY2YbhAAoJEIbPlEyWcf3yoxQQAJu2VH/pKwE/4YfDXvV806rI
1x397uW3x+5gMKYRU+FK6+6CjqUw+Vv9N+CqL5YsSlPM4NJdQQHRDszTSvP9lFkD
0Z4XHco0pmzC9niSekoEywqz8+BuWE8CtY8w5HwlcSr5fyUR47OIwSvPLZMb+S+m
AaBzF/ZdNNQbeigXwrJgqD9bU/rH4JnxSGfg/r0k/HCS/IyA3cAQ3QuYt4ZTambA
CGZVkjDfTeUpbIF1ohOFkx4gOCvoXkrjFlVa/PIzT7qPYWR3t3c5oGwWICMrFJKo
eDWmdqXNljNasPCHCcfce/5xciJFpzt6ZXjWOvVwy9qcYLF0OZvpFCXQa9d8xND8
aluk8abiKPM1Ng12i5J+9GDkiBrOfpFfVU+tkny51CibVbX3/coDgGwzDsZniDcG
CtOyW7OdIthbVAXM3YXYCMb+0xRrSjLob+bPjJcLX+qtH0xLlhV9VAUHlzFO1hGv
40goWRARh1HN9Sd4GYbugHeZRhaXduA6z0qyAS2f+Utn2O9boxm3g9CxvCetcCd3
WchG4ih+lY7cDJixk7FtNa0jAo3MQjLhnAq3/aBwSfcE434flOZWSVBsxTC4uGmK
JJyLA96AnAXhFuVHsbYZHbMw2bBGPfF6weSngE1d3xtdqf0j4M7pdYSeAq0CenQT
lBg2MWNNhfR9cCs1DY/h
=Yvnv
-----END PGP SIGNATURE-----

--q2TQvi1NkTeU0fhRjW8k0N6UX7mx4SiLm--

