Date: Fri, 13 May 2016 08:56:15 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160513065615.GJ53051@...1296...>
References: <5731B295.4040301@...515...>
 <57350DC5.80801@...68...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fz7Dnydx+M42Ztf/"
Content-Disposition: inline
In-Reply-To: <57350DC5.80801@...68...>
Subject: Re: [Openvpn-devel] SIGSEGV (NULL ptr deref) in PolarSSL-based
 build if noTLS ciphers specified (was: OpenVPN 2.3.11 released)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel@lists.sourceforge.net

--Fz7Dnydx+M42Ztf/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, May 13, 2016 at 01:12:05AM +0200, Matthias Andree wrote:
> Unfortunately, it appears that at least with PolarSSL 1.3.16, this
> release introduces a crasher regression which easily shows up in a "make
> check" on FreeBSD when no specific ciphers are selected.  Backtrace
> below.  The OpenSSL-based build seems fine.

Thanks for the report.  Indeed, I can reproduce that here just fine

If the addresses are in use, this test will retry up to two times.
Segmentation fault (core dumped)
Fri May 13 08:54:22 2016 OpenVPN 2.3.11 amd64-unknown-freebsd10.1 [SSL (Pol=
arSSL)] [LZO] [MH] [IPv6] built on May 13 2016
Fri May 13 08:54:22 2016 library versions: PolarSSL 1.3.16, LZO 2.09

(and that was a combination I should have tested, sorry - we do automated
tests of "polarssl" builds on all supported platforms for master, but the
code there is sufficiently different by now that the 2.3 change was not
"just apply the patch from master")

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Fz7Dnydx+M42Ztf/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVzV6jqkuBuNlUUl1AQKdIQP/Yy0Du+CoxVJJuWwNJkgWMJdFC+Vk9JSt
TVL3b1GE4haR4BXOi6Qzu33ho6STfOh8rC5Bk8/QmAtbOUFpJ/Z6ymLPi0EWgUVP
cbOLOF8Gif27j9BiUrWZEM8F8oPmPB3hrGKjtNUMX1nNwHaIQg0BN+ZIk9RkSae5
lhc5WF7rQ7c=
=lrTo
-----END PGP SIGNATURE-----

--Fz7Dnydx+M42Ztf/--

