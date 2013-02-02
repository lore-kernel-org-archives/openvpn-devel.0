Message-ID: <510D432C.1060107@...1114...>
Date: Sat, 02 Feb 2013 17:47:40 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1358854613-7150-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1358854613-7150-1-git-send-email-heiko.hund@...1489...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig983D4758CC0601B4CCF6118A"
Subject: Re: [Openvpn-devel] [PATCH] ignore UTF-8 byte order mark
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig983D4758CC0601B4CCF6118A
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 22/01/13 12:36, Heiko Hund wrote:
> Currently openvpn exits when reading configuration from a file
> that has an UTF-8 byte order mark (EF BB BF) at its start.
>=20
> While it is useless to put a BOM into UTF-8 encoded files, the
> Unicode standard [1] permits it (on page 36):
>=20
>   "Use of a BOM is neither required nor recommended for UTF-8,
>   but may be encountered in contexts where UTF-8 data is converted
>   from other encoding forms that use a BOM or where the BOM is
>   used as a UTF-8 signature."
>=20
> Notepad.exe, the default text editor on Windows, always puts the BOM
> into UTF-8 encoded files when saving them. Others may do as well.
>=20
> Just ignoring the UTF-8 BOM will make config files with UTF-8 BOM
> readable.
>=20
> [1] http://www.unicode.org/versions/Unicode5.0.0/ch02.pdf
>=20
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
>=20
> ---
>  src/openvpn/options.c |    3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 99f70ad..46f6f26 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -3773,6 +3773,9 @@ read_config_file (struct options *options,
>  	    {
>  	      CLEAR (p);
>  	      ++line_num;
> +              /* Ignore UTF-8 BOM at start of stream */
> +              if (line_num =3D=3D 1 && strncmp (line, "\xEF\xBB\xBF", 3)=
 =3D=3D 0)
> +                memmove (line, line + 3, strlen (line) - 2);
>  	      if (parse_line (line, p, SIZE (p), file, line_num, msglevel, &opt=
ions->gc))

Wouldn't this approach solve it in an easier way?

       int offset =3D 0;
       if (line_num =3D=3D 1 && strncmp (line, "\xEF\xBB\xBF", 3) =3D=3D 0)
          offset =3D 3

       if (parse_line (line+offset, p, SIZE (p), file, line_num ....

Should be safer as you don't need care about proper NULL termination of
the buffer.


--=20
kind regards,

David Sommerseth


--------------enig983D4758CC0601B4CCF6118A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlENQywACgkQDC186MBRfrouAgCglcE3t5rpjNHAjaYVeyjr14y3
3IsAoLAcmJUdVYhaYa3U4s1A2P18KTwD
=/if8
-----END PGP SIGNATURE-----

--------------enig983D4758CC0601B4CCF6118A--

