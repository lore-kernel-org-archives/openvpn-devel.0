Reply-To: openvpn-devel@lists.sourceforge.net
References: <b40a8930-a6aa-cd9d-8cfb-0ed57d1cdc93@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <bfb1203d-06e7-8242-c4bd-091e7d50801f@...2080...>
Date: Sun, 28 May 2017 23:09:41 +0200
MIME-Version: 1.0
In-Reply-To: <b40a8930-a6aa-cd9d-8cfb-0ed57d1cdc93@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eJ6q9wNfF6BXlPfsBn95LfAj3LR2jew0U"
Subject: Re: [Openvpn-devel] Ubuntu 16.04.2 LTS --enable-systemd ./configure
 error
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eJ6q9wNfF6BXlPfsBn95LfAj3LR2jew0U
Content-Type: multipart/mixed; boundary="dPvUwUehbXPfPF5ekggTUPrpJQdlFr8pB";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: debbie10t <debbie10t@...277...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <bfb1203d-06e7-8242-c4bd-091e7d50801f@...2080...>
Subject: Re: [Openvpn-devel] Ubuntu 16.04.2 LTS --enable-systemd ./configure
 error
References: <b40a8930-a6aa-cd9d-8cfb-0ed57d1cdc93@...277...>
In-Reply-To: <b40a8930-a6aa-cd9d-8cfb-0ed57d1cdc93@...277...>

--dPvUwUehbXPfPF5ekggTUPrpJQdlFr8pB
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 28/05/17 22:47, debbie10t wrote:
> Hi
>=20
> This is just a heads up !
>=20
> I cannot build openvpn on ubuntu 16.04.2 LTS (fresh install) because
> ./configure --enable-systemd fails to build with the following error:
>=20
[...snip...]
> checking for libsystemd... no
> checking for libsystemd... no
> configure: error: in `/home/dik/openvpn/master':
> configure: error: The pkg-config script could not be found or is too
> old.  Make sure it
> is in your PATH or set the PKG_CONFIG environment variable to the full
> path to pkg-config.
>=20
[...snip...]
>
> $ systemctl version
> Unknown operation version.

Can you try --version instead of just 'version'?

> apt-get install libsystemd-dev is done

Can you locate libsystemd.pc or systemd.pc on your system?  Are there
other systemd related -dev packages available?


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--dPvUwUehbXPfPF5ekggTUPrpJQdlFr8pB--

--eJ6q9wNfF6BXlPfsBn95LfAj3LR2jew0U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZKzyiAAoJEIbPlEyWcf3yCSYP/29vwr1ZSoZJ76VQYnrJr0lM
L07RZx0RVnsZbMAEr+bs5671U2UjMjJEYZmGB4SmOtHX43RDDNP4EUvEzX7/0Qip
w5gQPYqxxCwa+ZF+v8gk6zyRDY56wBqaOyFuyuhRITNVaDk5WFDdLkpmr/9/Eka/
aaFo+J9PJwpJ8FmHrGIIbiu2geOasjlhvnLB5vC5BIBeEL3hH8f6yi0jcf9ogMD4
gBuS00UBnhHGlpiySl/KBC1WojFBDLPFIx7dUptAFWQlRyPjEHRIapeRQ7nLbJ1n
yTUSQFTnzA8SW3yrTd4UabUZXbpDn/8kPwBErQEHWnu2zHW1ZnaZBJL8s4YZmhre
fE8za7e7O2G5Sf4wksiWh8hBOzRnrcEl85xliRFJm7ukMdUlOKgsaRWEueea/FS1
+ZB1Dtj5GCupYdOny59bMAPz5jfRBrvXKNdmhThSBeXY9DN2pRitg9C0JMvMdshJ
99CcmyMOpfrcz46OKtYUk/PABwh4GIZ1TQqtlN/oWmQ/1lA3w0f7fHwGzQNLJS4Y
YyuLo9+Wcqd3zohv3gSHlZECacIUp4d+IvwkYgtRhNsIQCjI10wO4UxFVRYfnDlb
4DcgAXQBYW5pZImhUjOkRZDfMCdSrELv7DKX4NDhQXev9Rt6ecqFGAUYe90KBaUQ
Eh3CMuqy8uuigm1emw86
=w4Pv
-----END PGP SIGNATURE-----

--eJ6q9wNfF6BXlPfsBn95LfAj3LR2jew0U--

