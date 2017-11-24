Date: Fri, 24 Nov 2017 19:02:07 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20171124180207.GO631@...1296...>
References: <040701d36546$f3cc1270$db643750$@carroll.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="F4+N/OgRSdC8YnqX"
Content-Disposition: inline
In-Reply-To: <040701d36546$f3cc1270$db643750$@carroll.com>
Subject: Re: [Openvpn-devel] [PATCH] Added OpenSSL FIPS 2.0 support to
 OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jim Carroll <jim@...2322...>
Cc: openvpn-devel@lists.sourceforge.net

--F4+N/OgRSdC8YnqX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 24, 2017 at 12:09:13PM -0500, Jim Carroll wrote:
> Modified the autoconf, automake and code to support building OpenVPN with
>=20
> OpenSSL FIPS Object Module v2.0 validated encryption.
>=20
>=20=20
>=20
>         * Adds: --enable-fips-mode switch to configure.ac
>=20
>         * Adds: --enable-fips-mode command line switch to openvpn
>=20
> ---
>=20
> INSTALL                      | 72
> ++++++++++++++++++++++++++++++++++++++++++++
>=20
> Makefile.am                  |  5 +++
>=20
> configure.ac                 | 42 ++++++++++++++++++++++++++

Please use "git send-email" to send patches.  Whatever you used this
time, it massacred whitespace (between every single line there is an
extra blank line), so it cannot be applied.

gert
--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--F4+N/OgRSdC8YnqX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaGF6fAAoJEB2Cnv7KVigS8pkL/iVugI0eTwiWkfMlyA181LM3
diUnDypMtiDa0JJ0mPj4IF4P0j1FI6K50J/Q2kjcnAPxrO0Rt9kdOu9jfM29jSrF
FcnxchTL7tQleEhcIMi6BMNAI0mvsMKHm0ROz6mejsyh9Qc4GVMfm+D95VTNw3x/
4nSjhm5yauEorHB/KVZ8CSjV0blmO0SyyzDveNHI0uwBLxrJmKvd35OernRAU7Fb
jGmJu1tFo7Ylu5YSrQ7v2ED+//0kRotS3iRIF+C7uAWSnDETqAgPzCSGnoTS7QnE
N37UNujxVUBFeCFD1K+j9nDD/0AiwxMlNMQ6dtug2ixcCy2wwbb3E/VzV2+B76PI
TQQZOVW47HmURS7IpMjsA56D5SJSlYdRPxJ3JiYvkqb7Lk2HwvX79/mRFMb4FiMt
FUQ6U8egGKAG9qyz5lX3rfK6BmUbY5tPTzZmh+oDuGAf3wgo0+veOenv1PZfM/HV
+k9sfcyLYdL8HJi/VTOdaUXTtMb+oRYq9UIurxGrew==
=DNrK
-----END PGP SIGNATURE-----

--F4+N/OgRSdC8YnqX--

