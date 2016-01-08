Date: Fri, 8 Jan 2016 16:22:31 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160108152231.GI24952@...1296...>
References: <1450127176-43837-1-git-send-email-fish.thss@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IGH6DwWgOn9XAAl6"
Content-Disposition: inline
In-Reply-To: <1450127176-43837-1-git-send-email-fish.thss@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Make MSVC happy about route.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Fish <fish.thss@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--IGH6DwWgOn9XAAl6
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Dec 14, 2015 at 01:06:16PM -0800, Fish wrote:
> Move the definition of out to the beginning of functions to comply with
> old-style C compilers. Tested on MSVC 2010.
[..]
>  #elif defined (WIN32)
> -
> -  struct buffer out =3D alloc_buf_gc (64, &gc);
> +  out =3D alloc_buf_gc(64, &gc);
>    buf_printf (&out, "interface=3D%d", tt->adapter_index );
>    device =3D buf_bptr(&out);

As things turns out, this is now actually no longer needed in the=20
release/2.3 branch, as with the new code from Lev, this looks like:

#elif defined (WIN32)
=20
  if (win32_version_info() !=3D WIN_XP)
    {
      struct buffer out =3D alloc_buf_gc (64, &gc);
      buf_printf (&out, "interface=3D%d", tt->adapter_index );
      device =3D buf_bptr(&out);
    }
=20
... and as such, avoids this VS2010 pitfall (thanks anyway!).

Master still has problematic code here, so if VS2010 compatibility is
desired, I'd appreciate a patch for it.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--IGH6DwWgOn9XAAl6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVo/UNqkuBuNlUUl1AQLwzwP/Zt5Qk5ERmwlRd+DMGmRNGYwxkLCsIfD1
tJCfGyhOYYXGVikccD2JaAV1QofvuJyXqCNNbPuz7QsQ+79kWvvHlR4g3TUFhjKA
6BEoJ6pGGGT6TmH6YNsKejZRKJG++inKFECVgaMpC6d3r4Pfp/ODINeFyt8rcYHU
zu8dSBLdno8=
=g2wr
-----END PGP SIGNATURE-----

--IGH6DwWgOn9XAAl6--

