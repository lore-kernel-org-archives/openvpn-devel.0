References: <20190623180157.29390-1-gert@...1296...>
 <20190623183210.6005-1-gert@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <b5d2e0c8-8ea6-1819-7ed2-3e2547efd47e@...2080...>
Date: Mon, 24 Jun 2019 20:26:55 +0200
MIME-Version: 1.0
In-Reply-To: <20190623183210.6005-1-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="cc9LOEZ8ZQ1J6OsI8LSgkYm1wZBDbOn4M"
Subject: Re: [Openvpn-devel] [PATCH v3] Remove cmocka submodule,
 rely on system-wide installation instead.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cc9LOEZ8ZQ1J6OsI8LSgkYm1wZBDbOn4M
Content-Type: multipart/mixed; boundary="JTvg8uRAnZa4CB28cLwExd9ETcZgZxrBc";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net
Message-ID: <b5d2e0c8-8ea6-1819-7ed2-3e2547efd47e@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v3] Remove cmocka submodule, rely on
 system-wide installation instead.
References: <20190623180157.29390-1-gert@...1296...>
 <20190623183210.6005-1-gert@...1296...>
In-Reply-To: <20190623183210.6005-1-gert@...1296...>

--JTvg8uRAnZa4CB28cLwExd9ETcZgZxrBc
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 23/06/2019 20:32, Gert Doering wrote:
> We used to ship git submodule instructions to build a local copy of
> cmocka in vendor/cmocka/ and use that (if cmake is installed) to build
> unit tests.  With the network test driver this turns out to be a
> LD_LIBRARY_PATH vs. SUDO complication which is really outweighing the
> benefit of a local build today - so, use the system-wide installation
> if available (querying pgk-config).  Do not build unit-tests otherwise.
>=20
> v2: (inspired by patch from David Sommerseth)
>   introduce "configure --disable-unit-test" switch
>   simplify configure.ac logic
>   use CMOCKA_LIBS and CMOCKA_INCLUDE (set by PKG_CHECK)
>=20
> v3:
>   repair conflict with commit 7473f326366fbceb
>   CMOCKA_INCLUDE is not correct, must be CMOCKA_CFLAGS (see config.status)
>=20
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  .gitmodules                  |  4 ----
>  INSTALL                      | 14 +++++++++++++
>  Makefile.am                  |  2 +-
>  configure.ac                 | 40 +++++++++++++++++-------------------
>  tests/unit_tests/Makefile.am |  2 +-
>  vendor/Makefile.am           | 22 --------------------
>  vendor/README.md             |  8 --------
>  vendor/cmocka                |  1 -
>  8 files changed, 35 insertions(+), 58 deletions(-)
>  delete mode 100644 .gitmodules
>  delete mode 100644 vendor/Makefile.am
>  delete mode 100644 vendor/README.md
>  delete mode 160000 vendor/cmocka


Acked-By: David Sommerseth <davids@...515...>

Changes looks good too now.

I've tested this with a few configs, passes 'make distcheck' with and witho=
ut
cmocka available.  A big plus with this change is also that these cmocka un=
it
tests are also run via 'make check' if it is available on the system.  I ha=
ve
not verified "how to install cmocka from source" in INSTALL.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--JTvg8uRAnZa4CB28cLwExd9ETcZgZxrBc--

--cc9LOEZ8ZQ1J6OsI8LSgkYm1wZBDbOn4M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJdERXvAAoJEIbPlEyWcf3y1qsQAJJeRyoUMroy/+wz7il6hdVH
SesUxCMZYJzTi3livNI7E3k+Tzo53+Ah0aKPdAdjuwY3vzap0rnb++eSdlrU1jhO
pvA18qad3EfJ8bL11msYA+rFwIjjUYQXmet/RW3u4eGkFIHKfN75Yv8rFfGMGSnQ
LbXStaMam+Y+Xp6w0r1UqBqKJbE2y4i+q+Y2pdmSzuQc3bm7EUui2hrdjbR37mtH
trv+Ls4CjDmaJ5r3zZF4KnowG9jJ+WIX65xyUQNSqCTQJEKb+tEZrPQE3YcVKbGQ
MVtV01OOuhqvHqxYdAqDB/O2wNMYFQdBx2g3MP5WKUIteDWbgDc/1AQdAFB9J1xT
IVuok+XiKHOjAUUTZhC5h3Rl3a4DKF5uW48C0tLfyZ3jgbjlYP/L1yGw9mlqh/JF
mlgpeMK30QRbeI56hBxkWoo7BLEpS9ROnNI6iC4MclzhmcpozBUp+Dx5kM7pSvvn
bxhmitj15/rW0OoyyCAxuqmLDCORMBtu+wGiyPKx3FRQT7V685BwiaZiQvY/mxo6
S2ricRdacBaJMmL7oxm+HsYZ8X16nG5TZKmu6WONzXKGFjku04LiDhMs3tEMH3uG
Vdl9eCBdwrmtnRKXbdbu9otFp8q6rY0TeTYT5cG5qPi3M4aNheNvO9lJBOI3wn2I
FAKsDeg2KN6TP6tPpK4G
=A3VX
-----END PGP SIGNATURE-----

--cc9LOEZ8ZQ1J6OsI8LSgkYm1wZBDbOn4M--

