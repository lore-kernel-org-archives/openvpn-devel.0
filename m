Date: Wed, 18 Nov 2015 15:53:47 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151118145347.GT24952@...1296...>
References: <20151118140650.GA1040@...2091...>
	<20151118143704.GR24952@...1296...>
	<20151118144806.GA975@...2091...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKh+x8PS77aidDsl"
Content-Disposition: inline
In-Reply-To: <20151118144806.GA975@...2091...>
Subject: Re: [Openvpn-devel] [PATCH] Adjust server-ipv6 documentation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christos Trochalakis <yatiohi@...2090...>
Cc: openvpn-devel@lists.sourceforge.net

--tKh+x8PS77aidDsl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 18, 2015 at 04:48:06PM +0200, Christos Trochalakis wrote:
> On Wed, Nov 18, 2015 at 03:37:04PM +0100, Gert Doering wrote:
> >On Wed, Nov 18, 2015 at 04:06:50PM +0200, Christos Trochalakis wrote:
> >>  o --server-ipv6 is incompatible with the 'nopool' option
> >>  o ifconfig-ipv6-pool starts at 0x1000 and not 0x10000 since v2.3
> >>    c55e9562: Implement IPv6 interface config with non-/64 prefix lengt=
hs
> >>
> >> Signed-off-by: Christos Trochalakis <yatiohi@...2090...>
> >
> >Uh, yes, in principle, but...
> >
> >>     * push "tun-ipv6"
> >>     * ifconfig-ipv6 2001:db8::1 2001:db8::2
> >> -   * if !nopool:
> >> -   *   ifconfig-ipv6-pool 2001:db8::1:0/64
> >> +   * ifconfig-ipv6-pool 2001:db8::1000/64
> >
> >... the "if !nopool" should still be there, no?
> >
>=20
> If I understand correctly 'nopool' option is only valid for --server and =
not
> --server-ipv6.

What brings you to that assumption?  (Background: if there is no IPv4 pool,
the IPv6 pool will not work, given the way the IPv6 pool is implemented)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--tKh+x8PS77aidDsl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVkyQ+qkuBuNlUUl1AQK4igP/Y6ou9oa2/yTc5q3k0/gdIDiqkMrComfh
Bj1cxnCCkXwkE0J5CFVqRYbwTGFGndAoKRkSs2NhZMw+xTBsWoK7/HzBAYfi/SrZ
G6LdS3jh0CmOk8x3s+eIk6d4/W+rpqTEt2/X7AnHaDXC3l38ZpESMX9xDgFxvy+s
u6euP+z9E6U=
=nyL8
-----END PGP SIGNATURE-----

--tKh+x8PS77aidDsl--

