Date: Mon, 2 Dec 2013 09:47:34 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20131202084734.GZ161@...1296...>
References: <1354303076-13606-1-git-send-email-arne@...1227...>
	<1354303076-13606-10-git-send-email-arne@...1227...>
	<50CC4FB8.8040005@...1790...> <20121215120924.GU22465@...1296...>
	<50CEDE97.6020808@...515...> <51C580F4.8040804@...1790...>
	<20131129195713.GN161@...1296...> <529C421B.3060104@...1790...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1cjC1NRoRtNJgc9d"
Content-Disposition: inline
In-Reply-To: <529C421B.3060104@...1790...>
Subject: Re: [Openvpn-devel] [PATCH 10/10] Implement dual stack client
	support for OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Tore Anderson <tore@...1790...>
Cc: openvpn-devel@lists.sourceforge.net

--1cjC1NRoRtNJgc9d
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Dec 02, 2013 at 09:17:31AM +0100, Tore Anderson wrote:
> * Gert Doering
>=20
> >> FWIW, I'd like to push the GNOME NetworkManager folks some more to
> >> implement IPv6 support in their OpenVPN plugin, which is currently IPv4
> >> only. This patch breaks one of the assumptions made there, in particul=
ar
> >> that IPv4 transport will always be used when OpenVPN is started
> >> "--remote <dns-hostname> --proto [tcp|udp]". I'm hoping that when
> >> dealing with that, which they'll have to do anyway, they'll seize the
> >> opportunity to implement IPv6 payload support as well.
> >=20
> > There!  I'll take you up on this now :-)  (thanks!)
>=20
> On it!
>=20
> BTW: Will this go into 2.3.3 or 2.4.0, and approx. when is the first
> alpha/beta/rc/whatever release containing it due?

It will not go int 2.3.3 - these changes are way too intrusive, and=20
2.3.2 -> 2.3.3 is meant to only receive "bugfixes" and "new features that=20
are needed for long-time client/server compatibility" (like the TLS=20
negotiation part).

It will go into 2.4.0 - I'm not promising anything, but about half
of the "really big things" are in the tree now, so it depends a bit=20
on Heiko's windows privilege separation patches - but we *might* be able
to do "February/March 2014" for a first 2.4_alpha.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--1cjC1NRoRtNJgc9d
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUpxJJqkuBuNlUUl1AQLs1AP+K7tq9BbRkVCddGYokX/Pc8yLpNr7fYBB
/X5MWULIf+4h9amFlVGAv8u1PIEqxhUUHGNmZLGkv4rXr3GFjPyGrE8Jro2l/C1s
Yj3/ZPOjQqOD0QwACdCmG0p5WC2TnwSs5NsPNgk16h9Cq6IcmQzN5nz5eCSTb1H6
d0PZd/Ncxy8=
=spnG
-----END PGP SIGNATURE-----

--1cjC1NRoRtNJgc9d--

