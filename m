Date: Fri, 11 Nov 2016 23:10:04 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161111221004.GC28918@...1296...>
References: <20161108124506.32559-1-gert@...1296...>
	<201611092014.uA9KErZf048132@...2054...>
	<8feec195-c9ed-a0bb-31c5-459bf9757ce6@...68...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3vPM4r6bCybeb41V"
Content-Disposition: inline
In-Reply-To: <8feec195-c9ed-a0bb-31c5-459bf9757ce6@...68...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Repair topology subnet on
 FreeBSD 11
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Matthias Andree <matthias.andree@...68...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--3vPM4r6bCybeb41V
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 11, 2016 at 07:25:57PM +0100, Matthias Andree wrote:
> >      Repair topology subnet on FreeBSD 11
[..]
>=20
> This is now part of FreeBSD's openvpn 2.3.13_1 (on the port's head) and
> masked by an option that I enable by default and that I've dubbed
> FIXSUBNET. <https://svnweb.freebsd.org/ports?view=3Drevision&revision=3D4=
25811>.

Thanks, this is useful.

> If nothing new crops up, I can request to merge this back to the
> quarterly (stable) branch and drop the option if someone deems this
> urgent, else it will propagate to stable ports in early January 2017. I
> should probably kick the option before then and make this patch regular
> (unless 2.3.14 is out sooner, but I understand if people want to focus
> on getting 2.4.0 into Debian).

I might be tempted to do a quick 2.3.14 release in between - there's two
important platform fixes in that branch now (FreeBSD and OpenBSD topology
subnet :-) ) and Lev's recursive routing patch.  Add to that the windows
block-outside-dns patch that I hope to be testing this weekend, and it's
worth a minor bugfix release...  at least "before January".

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--3vPM4r6bCybeb41V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWCZBu6kuBuNlUUl1AQK6uwQAsTQyhwxpDENKYknOWCE2HBMMf4xRHaNG
qQYWt6RD8JFbhdFq0jes238TtbT816C8hC5dThIy6B+WxESssea244Yd+wlQ+Znt
TTRrX4upbyixJK4KNPts/NSCMbIvZmHwINzJNRQsezR9g5pNSwCCigeSiYFLpuLy
lG0ymdWujl0=
=OfHy
-----END PGP SIGNATURE-----

--3vPM4r6bCybeb41V--

