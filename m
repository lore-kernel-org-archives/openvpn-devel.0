References: <20200717190801.17780-1-gert@...1296...>
 <20200811104401.31075-1-gert@...1296...>
 <15bba1d3-81e9-e37b-9d30-ad99b2425767@...2080...>
 <20200911213947.GI75094@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <afa42edc-882e-4038-7d4f-9b9df57c97e5@...2080...>
Date: Mon, 14 Sep 2020 11:35:03 +0200
MIME-Version: 1.0
In-Reply-To: <20200911213947.GI75094@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Tp9mHOc3FHpsmvmmnXeCnlV6zdMv1t4h5"
Subject: Re: [Openvpn-devel] [PATCH v2] Add demo plugin that excercises
 "CLIENT_CONNECT" and "CLIENT_CONNECT_V2" paths
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Tp9mHOc3FHpsmvmmnXeCnlV6zdMv1t4h5
Content-Type: multipart/mixed; boundary="XdAbuBTEOSUDWGqwNaSCgP4SpzXQ3y9rX";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <afa42edc-882e-4038-7d4f-9b9df57c97e5@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add demo plugin that excercises
 "CLIENT_CONNECT" and "CLIENT_CONNECT_V2" paths
References: <20200717190801.17780-1-gert@...1296...>
 <20200811104401.31075-1-gert@...1296...>
 <15bba1d3-81e9-e37b-9d30-ad99b2425767@...2080...>
 <20200911213947.GI75094@...1296...>
In-Reply-To: <20200911213947.GI75094@...1296...>

--XdAbuBTEOSUDWGqwNaSCgP4SpzXQ3y9rX
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 11/09/2020 23:39, Gert Doering wrote:
[...snip...]
>> I'm getting a lot of "warning: implicit declaration of function ???strdu=
p???;" and
>>  "warning: assignment to ???char *??? from ???int??? makes pointer from =
integer
>> without a cast" compiler warning on all of these strdup() calls.
>>
>> We do use strdup() in the main openvpn code, but that code includes conf=
ig.h,
>> which contains #define _GNU_SOURCE 1.  This removes this compiler warnin=
g.
>>
>> This is on RHEL-7 with both gcc-4.8 and gcc-9.3.
>=20
> Not sure what you are hitting there.  According to "man strdup()",=20
> inclusion of <string.h> should be fully sufficient, without any extra
> declarations.  But maybe it's a -std=3D... thing to tell GCC what
> C language level is desired?

Yes, I read somewhere that -std=3Dc99 changes the behavior.  _POSIX_C_SOURC=
E is=20
not defined with -std=3Dc99 (nor c11), but is defined without -std=3D defin=
ed.
None of the compiler standards adds _XOPEN_SOURCE - and neither _SVID_SOURCE
nor _BSD_SOURCE (which is not really surprising)

> I developed and tested this on a gentoo linux, with gcc-9.2.0, and it's=20
> *not* throwing strdup() warnings.

Without -std=3Dc99 I get a clean compilation with GCC-9.3.1 (RHEL-7/devtool=
set-9=20
SCL).  But on stock RHEL-7 (GCC-4.8.5) this plugin does not compile without=
=20
-std=3Dc99 ...

------------------------
client-connect/sample-client-connect.c: In function =91openvpn_plugin_clien=
t_connect=92:
client-connect/sample-client-connect.c:356:9: error: =91for=92 loop initial=
 declarations are only allowed in C99 mode
         for (int i =3D 0; argv[i]; i++)
------------------------


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--XdAbuBTEOSUDWGqwNaSCgP4SpzXQ3y9rX--

--Tp9mHOc3FHpsmvmmnXeCnlV6zdMv1t4h5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJfXzlPAAoJEIbPlEyWcf3yYWQQAKsDc39qmdAaiK3a9B6wFImu
ZfZBi0DsI2h6f90hK0RutPfM+0l9yCgzZDWNGXwBbWQlQt4uuEMOBD+kn31N9VMp
UoMJ7w4DpDxwW++ICBHi5YCTF2+1mZMLQV6WejGHU3bEqf30iLUz2DJYr2Voo7WO
tfNFflclImkpTGMrsFc0w7jgVEYQYXNeae1mdpi63VHUDBix8BVOb0owhbfs+ld6
yCT/nUyOl2RD/E8B9G4OwmSuOIQIYRRfm/0G2yfAqMHOzhqcvH+5cWEE0/ba4vV4
IaFrweRbLyWduGddy2wytmayqu9GNrjBM1VM25faIi6m4NX0hkN3TRnDD391Y7ub
K9udRBYvnhP4oJtKO2dP8e6ALaIzl4SQCo136MJ05Lb9PJAstvylfjeq8ugej/FE
shFD4z3rzcghrJbcQOqCwMdcFiKDKE9xG29TRacqpi2K1VfNtjyMhwVRvIXii6fQ
MSSMiDcr+t9oQAKAArBIPx3r+LVTOTkCzjHNoaEg291Y3AZORzm9JYxL4GzcCvnu
SaISBmZNh9FPBxamdgGm8Qp074wwEYWqO2nvVU0lwPTJU/SJvRC0JMw+mhvmD2az
wHwjgtXcvtocRYMXSRqHW4ayGquwL1rJFodHz/a/kU3wUNQoRLg1K7yA5sPME1w+
mcu3K33WNBNpWj1cB1X0
=dRxU
-----END PGP SIGNATURE-----

--Tp9mHOc3FHpsmvmmnXeCnlV6zdMv1t4h5--

