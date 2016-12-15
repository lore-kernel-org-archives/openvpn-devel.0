References: <1481808689.98151.88.camel@...1866...>
	<20161215140614.24291-1-list@...1798...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <4f3e6525-bbd4-7b68-f5e1-5561c70b3a36@...2080...>
Date: Thu, 15 Dec 2016 15:40:02 +0100
MIME-Version: 1.0
In-Reply-To: <20161215140614.24291-1-list@...1798...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="kIM5Tv1RLK9rww8tH48q2nlqgQkWwUMhx"
Subject: Re: [Openvpn-devel] [PATCH 1/1] replace deprecated LZ4 function
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Hesse <list@...1798...>, OpenVPN Development <openvpn-devel@lists.sourceforge.net>
Cc: Christian Hesse <mail@...1798...>, David Woodhouse <dwmw2@...1866...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kIM5Tv1RLK9rww8tH48q2nlqgQkWwUMhx
Content-Type: multipart/mixed; boundary="77tCwwfJ3pSOSniRkKFcmg9apAnRHnQV5";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Christian Hesse <list@...1798...>,
	OpenVPN Development <openvpn-devel@lists.sourceforge.net>
Cc: Christian Hesse <mail@...1798...>, David Woodhouse <dwmw2@...1866...>
Message-ID: <4f3e6525-bbd4-7b68-f5e1-5561c70b3a36@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] replace deprecated LZ4 function
References: <1481808689.98151.88.camel@...1866...>
	<20161215140614.24291-1-list@...1798...>
In-Reply-To: <20161215140614.24291-1-list@...1798...>

--77tCwwfJ3pSOSniRkKFcmg9apAnRHnQV5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 15/12/16 15:06, Christian Hesse wrote:
> From: Christian Hesse <mail@...1798...>
>=20
> The LZ4 function LZ4_compress_limitedOutput() is deprecated, compiler
> gives warning:
>=20
> warning: =E2=80=98LZ4_compress_limitedOutput=E2=80=99 is deprecated: use
> LZ4_compress_default() instead
>=20
> The new function LZ4_compress_default() appeared in r129 (1.7.0), so
> replace the function there.
>=20
> Signed-off-by: Christian Hesse <mail@...1798...>
> ---
>  src/openvpn/comp-lz4.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
> index 6b7c49b..a6ce4f7 100644
> --- a/src/openvpn/comp-lz4.c
> +++ b/src/openvpn/comp-lz4.c
> @@ -87,7 +87,11 @@ do_lz4_compress(struct buffer *buf,
>              return false;
>          }
>=20=20
> +#if defined LZ4_VERSION_NUMBER && LZ4_VERSION_NUMBER >=3D 10700
> +        zlen =3D LZ4_compress_default((const char *)BPTR(buf), (char *)B=
PTR(work), BLEN(buf), zlen_max );
> +#else
>          zlen =3D LZ4_compress_limitedOutput((const char *)BPTR(buf), (ch=
ar *)BPTR(work), BLEN(buf), zlen_max );
> +#endif
>=20=20
>          if (zlen <=3D 0)
>          {
>=20

This makes sense.  But I think we should do this in relation to an
update of the compat-lz4 library we also ship in OpenVPN.  I'm running
some tests now, and will submit a new mail thread which includes this
patch together with the compat-lz4.[ch] update.

This will be handled post v2.4.0 release, so we don't rush the testing
of the LZ4 support and inadvertently break anything.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--77tCwwfJ3pSOSniRkKFcmg9apAnRHnQV5--

--kIM5Tv1RLK9rww8tH48q2nlqgQkWwUMhx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYUqtCAAoJEIbPlEyWcf3y+WsP/1nAEhGcc9Lana+Mg5eTIz8k
3LDsimZTMGZn9JGw7pozKqBPI0HtptPu9wEq5knKnnxXleelORot9LEDGmIHbByf
qnVpHnHS2TtW31aqTkfWhjGaC/8fMMJYbaviXVKKTovVPgaXQWqS7KpNtVJliWdx
tEEPLsA8HX7NzqZMCm5k5P4HEx2DFl7Wv24BtElGrPPRbdMjYM0m5F7CChHMP9Ln
u5PHIKkLYprM4vErqL7VUgT4FtOX6HcO79mn9JsCo4OrK1Tuo92JUilAaWTP2A/t
piVWZAqq+wdgbiG6yjbb9y9oJX/nkcU5hMpcxAQLaGbZV7z3h5O0Bokj7vnljfsn
gTXyBkdhhIDOOjmMJ/8NZjz6FKZA8vjj/sGmbK4hWqI7bmBC5vxuWX4OQzZ86TZE
ZH0FgqJHp29jlcqSZzUvzYwnIkalUSXUOop5xqgMS9slsXvK/L8PU+SzMfLaFuEH
Tpr7EXaQDQS52f8cvICW2Xn+Wfdlrq9HDsa1Ik2ztJErMN+xK1wW8rZvqUxA96bM
aLyKQz0ut/Y/gyqt1wOxTDyA0x/zXUGbdZAkL6F2A6jv7qUNC7CmuKogtViBvKzE
GEv0I8/bO8XE5KcjFOAekjrkKVm6Gl45V4RYLxgHAeufRZJViZ/6XqNvvDp/yWik
1FHWv5hqLFGa4myyv9Rq
=BLdQ
-----END PGP SIGNATURE-----

--kIM5Tv1RLK9rww8tH48q2nlqgQkWwUMhx--

