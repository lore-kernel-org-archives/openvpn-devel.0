References: <20170413172609.29093-1-davids@...515...>
	<20170415091647.GG30424@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <924aa9d7-bf6e-6428-4d24-9009d36b635f@...2080...>
Date: Sat, 15 Apr 2017 11:42:30 +0200
MIME-Version: 1.0
In-Reply-To: <20170415091647.GG30424@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pwo93qc4vtjnahAboJxnwQwCdEFjI9RKL"
Subject: Re: [Openvpn-devel] [PATCH] Fix broken ./configure on systems
 without openssl.pc
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pwo93qc4vtjnahAboJxnwQwCdEFjI9RKL
Content-Type: multipart/mixed; boundary="kCX2qq0O4MmulM8fdOoLwKNB9bs65HC1C";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>, David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <924aa9d7-bf6e-6428-4d24-9009d36b635f@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Fix broken ./configure on systems without
	openssl.pc
References: <20170413172609.29093-1-davids@...515...>
	<20170415091647.GG30424@...1296...>
In-Reply-To: <20170415091647.GG30424@...1296...>

--kCX2qq0O4MmulM8fdOoLwKNB9bs65HC1C
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 15/04/17 11:16, Gert Doering wrote:
> Hi,
>=20
> On Thu, Apr 13, 2017 at 07:26:09PM +0200, David Sommerseth wrote:
>> +/* Strip out some of the version information we don't care about */
>> +#define OSSLVER OPENSSL_VERSION_NUMBER >> 12
>> +#if OSSLVER < 0x10001
>> +#error OpneSSL too old
>> +#endif
>=20
> While this works (except for the typo) - why not just do full-length math=
,=20
> as in
>=20
> #if OPENSSL_VERSION_NUMBER < 0x10001000L
> #error OpneSSL too old
> #endif
>=20
> (note the L prefix, as in the opensslv.h #define)

Basically it was just to make the matching more similar to the matching
we do with pkg-config, which does not care for the letter in the version.

The OPENSSL_VERSION_NUMBER is also fairly complex, and also provides
"flags" if it is a beta releases or final releases too.  So by stripping
out the LSB 12 bits, the whole check gets a bit more "understandable"
without having to understand the whole version formatting.

What is also a bit confusing to me, is that they version spec they have
documented, says the last nibble (4 bits) is the status flag (dev, beta
or release).  While it seems to be encoded as a byte.  So the shift
operation considers 4 bits and not 8 bits.  The next 8 next bits is the
"letter" in version string.  Hence the shift is 12 bits.

So reviewing this now, this 12 bit shift may actually fail on big endian
machines.  It would probably be better to do a full 16 bit shift.

But if we don't want to reduce the match set to only version numbers,
I'm fine with skipping the shifts all together.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--kCX2qq0O4MmulM8fdOoLwKNB9bs65HC1C--

--pwo93qc4vtjnahAboJxnwQwCdEFjI9RKL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY8esKAAoJEIbPlEyWcf3yAwoQALI4KqS4bjmUVq0icTMZxWOQ
Pi5SkEOTqPLdTa2LfjrGarG2wyggUI3KWUMTj1i/NH1w8CxQO4RCsMHO5yKLx+Fa
V5G9vOAYhPcqqQYv8VSQ63CvQRzMs8Mc3Hn6wC6/J/X6hPrNsFfZyl4Lq2cNaHXU
1dT819sXfDN8nJ7jVrDIP253my8fLetsimlBGU3/SsEcXQkw5UN9PbyoeSCyai3A
IHW/PkaXGjii1lz6UK4+28G0LbATYXFyZ5nPIUl9KEFSa0LlxwfmgMJVB+3sbIty
N6tvC6PEs1Evj2XRrttUf6pEvlTz7WEW2tbaPbGi7QYuKrIH+cd3kNgZYv4hI1Op
WUR2kXMTr0I5xYbrwak0od7RT4+OsNG8lRXsbW1bfQBaYnO4NPkiok62Oxnggwvk
8qmxnwxf46oBNVTJW+VhUg/p+xqahzZHs1+TBHWoJCJQOtFR2xVt0Y9E12+Moz2E
Sw9lnRL5y7YHjxQzDpzB5hKt/eL0bHrhmqlzmSQEzbE7QcluFa7ghXZYVZSARzFt
f4v668WRY+AY7gW2b9gyA4EvB4hRmDOJFVbB9hU9O6+9sXRvUwJH+ybQInSbNldD
fhnY2QV+X4HFjHOvsuspd0XcVLqQMuXRYzqoVVuRAc/Wst5I6kt+Zi6lFJbloedv
+IyVzy8vQ/ih9wlCaeDI
=O9vE
-----END PGP SIGNATURE-----

--pwo93qc4vtjnahAboJxnwQwCdEFjI9RKL--

