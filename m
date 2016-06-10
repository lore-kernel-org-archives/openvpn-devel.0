Date: Fri, 10 Jun 2016 18:53:19 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160610165319.GF62247@...1296...>
References: <575AA2BD.60908@...277...> <20160610125457.GC62247@...1296...>
	<575AC1E2.9000802@...277...>
	<20160610133848.GE62247@...1296...>
	<575AC69F.9080108@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Content-Disposition: inline
In-Reply-To: <575AC69F.9080108@...277...>
Subject: Re: [Openvpn-devel] pull-filter reject = server hammering !
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 10, 2016 at 02:54:39PM +0100, debbie10t wrote:
> On 10/06/16 14:38, Gert Doering wrote:
> > On Fri, Jun 10, 2016 at 02:34:26PM +0100, debbie10t wrote:
> >> VPNB modifies VPNA client configs to include
> >> --pull-filter reject ""
> > How would VPNB do that?
> Download it, modify it and distribute it to their attack bots.

In that case - what would that be worse than just using=20
"--tls-remote-name bah" (which also leads to "go to next server" restarts)?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV1rwfqkuBuNlUUl1AQILzgQAtBxTNhW+4LhrELF5bzqwtnz1beQrzgGa
xmBbkWMwqRq+ZaJCTLy9OsZnILRpmKBHvqrLXZobT1VEarzCevbnJy1K689iTLgo
VwO8/Bwi/ZZC207DsRC/DPqIi0B4JU6/3nBUlf41GqEdD3SXBZRTJL3YWISDwDLi
E1tzpDM8itA=
=ppUs
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--

