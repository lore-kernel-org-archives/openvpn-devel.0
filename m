Date: Sat, 10 Oct 2015 11:39:02 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20151010093902.GU22054@...1296...>
References: <1425319111-21291-1-git-send-email-lstipakov@...277...>
	<201510100910.t9A9AAH0027143@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qpqR4wE1CEr+Roqx"
Content-Disposition: inline
In-Reply-To: <201510100910.t9A9AAH0027143@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Fast recovery when host is
 in unreachable network
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--qpqR4wE1CEr+Roqx
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Oct 10, 2015 at 11:10:10AM +0200, Gert Doering wrote:
> Your patch has been applied to the master branch.

And *blam* it explodes if --disable-crypto is used...

gcc -DHAVE_CONFIG_H -I. -I../.. -I../../include  -I../../include
+-I../../src/compat             -g -O2 -MT forward.o -MD -MP -MF
+.deps/forward.Tpo -c -o forward.o forward.c
forward.c: In function 'process_outgoing_link':
forward.c:1203: error: 'struct context_2' has no member named 'tls_multi'
*** [forward.o] Error code 1


Waiting for an update :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--qpqR4wE1CEr+Roqx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVhjctakuBuNlUUl1AQKiDgP9GxWKVlf+N1MNpBoTzU+/CMXhEJGF5dKu
LTXMZKM6eQ5aP4NzIMT+m3tiTZUYrFWPULEW/oxT2l16NIt0a8bDi6s2LWrEIWQy
DM1oseSFUnpeDNnIc5YqBwJIJ7+1ovmfOi2XtfRLr0mplRBBzgbpUuz6EUC1AlLp
e8Z3kCu7/3Q=
=8G0z
-----END PGP SIGNATURE-----

--qpqR4wE1CEr+Roqx--

