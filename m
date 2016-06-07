Date: Tue, 7 Jun 2016 16:11:12 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160607141112.GX53051@...1296...>
References: <CAFHpkQF9s4JnDKHsomjo0ud72nwOXF7g_hLEiNreZ1ozTn4QLA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dK2IXLa0zlbGuJlr"
Content-Disposition: inline
In-Reply-To: <CAFHpkQF9s4JnDKHsomjo0ud72nwOXF7g_hLEiNreZ1ozTn4QLA@...278...>
Subject: Re: [Openvpn-devel] potential segfault on strlen(NULL)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--dK2IXLa0zlbGuJlr
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 07, 2016 at 06:04:54PM +0500, ???????? ?????????????? wrote:
> as I see, there's call to format_hex_ex with separator=3DNULL here:

Interesting find.=20=20

This code is funny - format_hex_ex() is called from various places with=20
separator=3DNULL, and has been that way since at least 2005... it's part of
the oldest commit we have in git.

Now, that expression

  struct buffer out =3D alloc_buf_gc (maxoutput ? maxoutput :
                                    ((size * 2) + (size / (space_break_flag=
s & F
HE_SPACE_BREAK_MASK)) * (int) strlen (separator) + 2),
                                    gc);

will of course *only* call strlen(separator) if "maxoutput" is 0
(C short-circuit evaluation of conditionals).  So if all callers respect
that and *either* set "maxoutput > 0" *or* pass "separator !=3D NULL", we're
fine.

The line 152 in ssl_openssl.c is passing in "len", which is not 0...

         const char *key =3D format_hex_ex (ekm, size, len, 0, NULL, &gc);

... so there will not be a strlen() call.


I wouldn't mind an ASSERT( maxoutput > 0 || separator !=3D NULL ) call
in format_hex_ex(), though.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--dK2IXLa0zlbGuJlr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV1bWAKkuBuNlUUl1AQIvKgP/TAI8usimZeHkjDayllOOAW/HYbqUNWWk
hVq+9tW99McMWeKNsi6wY9f3Cw9Fjwy88dlvQOPMu311Xbqh9VxVUzySYiN6rQ3x
KFLWSByelK9zNfnt9KhSFVh6ZE4kv/Nki+R2JpU3XiCxxYG2LFdsv8CrOkrwG1Re
Rl/GLycz7g0=
=OR6k
-----END PGP SIGNATURE-----

--dK2IXLa0zlbGuJlr--

