References: <e6f1b674-b382-0626-03c8-a20e0fbefc1b@...2080...>
	<1491996924-24576-1-git-send-email-steffan.karger@...1435...>
	<024c8d0b-b82d-4ea2-2445-9c57bf734c83@...1435...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <afa63dbb-715c-8775-2ac9-4dbdf0e7aaf5@...2080...>
Date: Thu, 13 Apr 2017 15:09:43 +0200
MIME-Version: 1.0
In-Reply-To: <024c8d0b-b82d-4ea2-2445-9c57bf734c83@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="scgF1sAmjoTBF7EFiVqDNb9sRlbj1Iu2V"
Subject: Re: [Openvpn-devel] [PATCH v2] Add --tls-cert-profile option for
 mbedtls builds
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--scgF1sAmjoTBF7EFiVqDNb9sRlbj1Iu2V
Content-Type: multipart/mixed; boundary="pI4vh1hwOfW699hcWQvAXjNHfcELEXdjg";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan.karger@...1435...>,
	openvpn-devel@lists.sourceforge.net
Message-ID: <afa63dbb-715c-8775-2ac9-4dbdf0e7aaf5@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add --tls-cert-profile option for
	mbedtls builds
References: <e6f1b674-b382-0626-03c8-a20e0fbefc1b@...2080...>
	<1491996924-24576-1-git-send-email-steffan.karger@...1435...>
	<024c8d0b-b82d-4ea2-2445-9c57bf734c83@...1435...>
In-Reply-To: <024c8d0b-b82d-4ea2-2445-9c57bf734c83@...1435...>

--pI4vh1hwOfW699hcWQvAXjNHfcELEXdjg
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 13/04/17 14:39, Steffan Karger wrote:
> On 12-04-17 13:35, Steffan Karger wrote:
>>  Version 2.4.1
>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> - - ``--remote-cert-ku`` now only requires the certificate to have at le=
ast the
>> -   bits set of one of the values in the supplied list, instead of requi=
ring an
>> -   exact match to one of the values in the list.
>> - - ``--remote-cert-tls`` now only requires that a keyUsage is present i=
n the
>> -   certificate, and leaves the verification of the value up to the cryp=
to
>> -   library, which has more information (i.e. the key exchange method in=
 use)
>> -   to verify that the keyUsage is correct.
>> - - ``--ns-cert-type`` is deprecated.  Use ``--remote-cert-tls`` instead.
>> -   The nsCertType x509 extension is very old, and barely used.
>> -   ``--remote-cert-tls`` uses the far more common keyUsage and extended=
KeyUsage
>> -   extension instead.  Make sure your certificates carry these to be ab=
le to
>> -   use ``--remote-cert-tls``.
>> +- ``--remote-cert-ku`` now only requires the certificate to have at lea=
st the
>> +  bits set of one of the values in the supplied list, instead of requir=
ing an
>> +  exact match to one of the values in the list.
>> +- ``--remote-cert-tls`` now only requires that a keyUsage is present in=
 the
>> +  certificate, and leaves the verification of the value up to the crypto
>> +  library, which has more information (i.e. the key exchange method in =
use)
>> +  to verify that the keyUsage is correct.
>> +- ``--ns-cert-type`` is deprecated.  Use ``--remote-cert-tls`` instead.
>> +  The nsCertType x509 extension is very old, and barely used.
>> +  ``--remote-cert-tls`` uses the far more common keyUsage and extendedK=
eyUsage
>> +  extension instead.  Make sure your certificates carry these to be abl=
e to
>> +  use ``--remote-cert-tls``.
>> +- The new option ``--tls-cert-profile`` can be used to restrict the set=
 of
>> +  allowed crypto algorithms in TLS certificates in mbed TLS builds.  The
>> +  'legacy' profile can be used to re-enable support for SHA1 and 1024-b=
it RSA
>> +  keys.
>=20
> Hrmpf, this should of course get a new section '2.4.2'...  Let me know
> if you want a v3, or whether this can be fixed on-the-fly.  Apologies!

No problem.  I don't mind moving things to a 2.4.2 section.

I'm however a bit puzzled of the "non-changes" (well, the indenting is
changing, unless I'm blind to other changes) to --remote-cert-cu,
--remote-cert-tls and --ns-cert-type.  If we want to change the
indenting, I think that should be kept in a separate patch, and keep
--tls-cert-profile as a patch of its own.

Otherwise, Changes.rst tools fine to me.

On a more generic note to this patch.  I wonder if we should keep
"legacy" the default in the v2.4 branch.  In the Fedora 26 (and
Rawhide/27) builds I had to do something similar [1] to keep users
happy.  As OpenVPN isn't ready for OpenSSL v1.1, I had to switch to mbed
TLS.  Unfortunately that haven't been as successful as I really hoped it
would be, but that's an entirely different story (and mail thread).  As
long as the Fedora builds need to be built with mbed TLS, I will need to
ensure 'legacy' is the default there for a while.  For the coming Fedora
Rawhide (which will be F28), I can make some announcements preparing
users to move to stricter defaults.

[1]
<http://pkgs.fedoraproject.org/cgit/rpms/openvpn.git/tree/0001-workaround-A=
llow-weaker-RSA-keys-and-MD-algorithms-i.patch?h=3Df26>


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--pI4vh1hwOfW699hcWQvAXjNHfcELEXdjg--

--scgF1sAmjoTBF7EFiVqDNb9sRlbj1Iu2V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY73ihAAoJEIbPlEyWcf3y7ygQALn2MbP1ytmr2XCJ6TMRk8U0
HySRKvJMlhXIFbz3O6OUp5o64ZajBf1HuVGr1TZkuYpDhoRxmuluHHHFrwAclMjc
qP0/wseHk646UnGcK5Tm53NmiGs+KanGJ9IqZeJS/20lWgazw5Tv2/DXBIZ7WdMd
LHASAthkXloO24ad4pX8jDIs3CuRy1Eke5Pt/qPMjmrmxXa3hySNhyTGaFIX7nU4
ZF0XUOksPf84nYa/kW1AedlyquvNfMyJLHV+i3s802cz8ZzYYbwYag23zroQsOrB
Fcu2vrH+8RNXwMxhhAAuZTbhzYqmrNM/F1loziPnpQaTILRho47XyHifyOa5hy5N
0PDldDefSwzWlKVVEzvQQWd1eAru7KidoZKOpnulQGbPmexWrrgaE4kDXsF7/34c
onsLGzznLuVHNry11dZwQZmGEHZr/u3F/DVcybJoXARqP7KnWNxSSe9uuv4gIcUl
4mzTH/rFAN4yjwp8knUFhFqmRjTdGlXQkDh644rYINSRwCiX+GTE6GJEKkeMsHSv
ByA5A1zjklx/8zgd8QBWKjBu5suxzu97aWsBqeaWpjt+0d5r/z7TKJQ/1HntLVJ0
h+JKh7DnEYeOqeW4qfOt61cx0TC0OzuVA5MbBhqF1i+1Fn3UPoITOwO0PageWMbo
I/rqUIYII6B9mayh0oSI
=SbXi
-----END PGP SIGNATURE-----

--scgF1sAmjoTBF7EFiVqDNb9sRlbj1Iu2V--

