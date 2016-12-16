References: <f5ca3f0f-dd01-e82e-b339-68f5791e0928@...1435...>
	<20161216182659.18194-1-jm@...1926...>
	<dfbcd54a-29c2-d8e5-1200-66f217832063@...1435...>
From: Julien Muchembled <jm@...1926...>
Message-ID: <44d2e307-1954-de7f-9979-68728de900b3@...1926...>
Date: Fri, 16 Dec 2016 23:16:08 +0100
MIME-Version: 1.0
In-Reply-To: <dfbcd54a-29c2-d8e5-1200-66f217832063@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6emtoJ0gjQ4MvFBriWAgNBSbmCq1MdXFL"
Subject: Re: [Openvpn-devel] [PATCH] Build with a few -Werror= flags if the
 compiler supports them
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6emtoJ0gjQ4MvFBriWAgNBSbmCq1MdXFL
Content-Type: multipart/mixed; boundary="kw3S80p2BdNpJtgEsMTRT6XaC5eUmJxsX";
	protected-headers="v1"
From: Julien Muchembled <jm@...1926...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <44d2e307-1954-de7f-9979-68728de900b3@...1926...>
Subject: Re: [Openvpn-devel] [PATCH] Build with a few -Werror= flags if the
	compiler supports them
References: <f5ca3f0f-dd01-e82e-b339-68f5791e0928@...1435...>
	<20161216182659.18194-1-jm@...1926...>
	<dfbcd54a-29c2-d8e5-1200-66f217832063@...1435...>
In-Reply-To: <dfbcd54a-29c2-d8e5-1200-66f217832063@...1435...>

--kw3S80p2BdNpJtgEsMTRT6XaC5eUmJxsX
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Le 12/16/16 =E0 21:52, Steffan Karger a =E9crit :
>> +AX_CHECK_COMPILE_FLAG([ -Werror=3Dimplicit ], [
>> +    CFLAGS_EXTRA=3D"$CFLAGS_EXTRA -Werror=3Dimplicit"
>> +])
>> +AX_CHECK_COMPILE_FLAG([ -Werror=3Dformat -Werror=3Dformat-security ], [
>> +    CFLAGS_EXTRA=3D"$CFLAGS_EXTRA -Werror=3Dformat -Werror=3Dformat-sec=
urity"
>> +])
>> +
>=20
> Shouldn't there be a CFLAGS=3D"${CFLAGS} ${CFLAGS_EXTRA}" somewhere?  Or
> just use CFLAGS directly, instead of _EXTRA.  Without that, I don't see
> the flags appear in the make output.

(how did I miss that?) anyway, there's also
  https://fossies.org/linux/alsa-lib/m4/attributes.m4

bigger, GPL2+, and it defines macros that simply append to CFLAGS (e.g. CC_=
CHECK_CFLAG_APPEND)


BTW, instead of failing on these 3 specific warnings, we could go the oppos=
ite way, since -Wall is quite silent. I suggest:

  -Wall -Wno-unused -Wno-pointer-sign -Werror -Wno-error=3Dstrict-aliasing =
-Werror=3Dformat-security

Julien


--kw3S80p2BdNpJtgEsMTRT6XaC5eUmJxsX--

--6emtoJ0gjQ4MvFBriWAgNBSbmCq1MdXFL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYVGesAAoJEEwjvlkacWMk2isQAInjHWrw0lJVqezyKMhPSiSE
JxHm+THUrp9841AOr7TZ/X3giuK7YbxVbO37ypE7hx0NylmV26e4ONXaEl1q3S3v
a/sv6lRW2OVJfHsl3epNN8RihhkRO4Yo2b1p6OX2dkPAuuGyHuZPh5Ca7eE1QUlo
i52HfDXmD6cBSZ5xN/HVS03Gnrn/pvxXdq38CdPgetyi8OAaB/csd/2+gUDxAInF
4mKI3Rb5x27BigSGEZ6SnW5v1oMoacvni0KWoPlX10Wsw+YlvHQWRWRzTcrzgdeX
Eo7F47ea34wbK7/Le6D/RzT1c2gYccnSSBoO4NsvTOSWid6AkWr0v6D7YW+iYf5M
XfrhI/XhBx6j9LZ13cgdMO3QwIxskpHyjwHdX5TOwwIkDTk0jHBl91BXnlYtJkDB
2SGjn6m/2MpisgwzmA+aXSU0th36pf+Uu05opxGNiOIDnGlfvSwz9giwYe+foUFa
fuJvTJBJQZmrDHc9dmxN2UBcqBRXso3ABthCEGg4eIDzVSxaBwFkIK/8VY9uSjxJ
ipcqv8d49EJngj+m1IY28DfzdtLFDRd5fTquIYEuhahHmsR5eJJR6s3FVJ5yXyXh
F+IUwBKUFTjgIjjcL5Th99iZcbPlxNuJhkZtdLe5n63SGNLmnXtnGpCSkUhFa+gf
y6IxatGclgs+r2jwPI0w
=kNc/
-----END PGP SIGNATURE-----

--6emtoJ0gjQ4MvFBriWAgNBSbmCq1MdXFL--

