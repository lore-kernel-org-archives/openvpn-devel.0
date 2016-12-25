Date: Sun, 25 Dec 2016 20:41:14 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161225194114.GT78624@...1296...>
References: <20161219013949.19551-1-a@...2181...>
	<2fc5173c-b27b-3828-f227-e15687831667@...1856...>
	<20161225100901.GG8708@...2182...>
	<20161225125823.GI8708@...2182...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5UgT1ku+qTHnlONB"
Content-Disposition: inline
In-Reply-To: <20161225125823.GI8708@...2182...>
Subject: Re: [Openvpn-devel] [PATCH] convert *_inline attributes to bool
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--5UgT1ku+qTHnlONB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Dec 25, 2016 at 08:58:23PM +0800, Antonio Quartulli wrote:
> What is the general rule then? cron2 explained me on IRC that in the past=
 some C
> programs would crash when trying to print NULL, but it should not be
> the case anymore (at least on Linux).

As mentioned occasionally, we run on more than Linux.  So this is only
safe if all supported platforms can handle=20

  printf( "%s\n", NULL );

correctly - Solaris, all the BSDs, MacOS, Windows(!), AIX.

"It works on Linux" is good, but this is a "boolean and" condition - it
needs to work on *all* supported platforms.

I'm not generally opposed to modernizing the code, but the onus of
recherching whether such a change is safe is on the proposer.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--5UgT1ku+qTHnlONB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYYCDZAAoJEB2Cnv7KVigS3bIL/2xlA1VK7JI1TAO+xrcryb+x
0cjek7K+GtLE+wSMOrPTUbQgfEllc5o1rAY5SkhPxgRMHKTUMn8EiztA4VD0xvHn
83c8Mj05ZzLRakj+3AV0RZHoCjF62SRncApkBd+N5OA0qybVIfCMkzuRfv2z9yKk
obRF9FoAUG0Jfh0lP3uVJf/JJeQGbinfW9doixfGCuk1qcaZJZ8NRGM80yxRgUsA
NvO13YjI2WLz9nOXIzWRaT5s3BO1DfksAoAmaTNtPr+wXO9N+oBio/WiZo9uHQ73
qLmX7aytWOa9p7Mo4+7Hk+uEcFgWG82oiYWYnzl7KgjSVTA4L2Oz7Bfcto7DgvFw
dZaAsqfERl3XxB+t2lzBL6gaEhRq8oTKZB+WU+UVVgZJ+DtCDeM/krch8I/EqMeb
s1Y4NJ/q8ceGfB6snYIiIwOSNbcB0WbQvhTQK/zIpi0v4I7kG+nsGX62d27B/ubz
HnOpLlDqnfbaCHVKK5s+HZuoqgcM5NVmY+5C1dSRdQ==
=+ucP
-----END PGP SIGNATURE-----

--5UgT1ku+qTHnlONB--

