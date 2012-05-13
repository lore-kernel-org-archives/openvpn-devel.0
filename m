Date: Sun, 13 May 2012 14:19:06 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120513121906.GL1359@...1296...>
References: <CAOazyz2N744s+VJekGJNK4sqHCONLCzMtsiJyRTkgrpO4RWHzw@...278...>
	<363B57F6-F3E8-4C7D-A19D-0E08541233BD@...1286...>
	<20120513090153.GG1359@...1296...>
	<CAOazyz1FB+JU7QRmeMuxMX7-6fAN28VH1-6ApJnOu7eHDq9jUA@...278...>
	<20120513092355.GH1359@...1296...>
	<CAOazyz0=+ZE6+n-KqyzZSJhbweHb236LjwefvV6BtMvfbh37mQ@...278...>
	<20120513093551.GI1359@...1296...>
	<CAOazyz0bEZMBYcKGvKTux=+7XE43=-4Aw02HGVCNHPoO35wAWg@...278...>
	<20120513111240.GK1359@...1296...>
	<CAOazyz1keZzQjqeUoUSQ88UzVn3=BMz1FWRp0KiB+gS6-43HhQ@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YD+BIkcXU0IoTTos"
Content-Disposition: inline
In-Reply-To: <CAOazyz1keZzQjqeUoUSQ88UzVn3=BMz1FWRp0KiB+gS6-43HhQ@...278...>
Subject: Re: [Openvpn-devel] [RFC] Split plugins into their own repositories
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

--YD+BIkcXU0IoTTos
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, May 13, 2012 at 02:26:05PM +0300, Alon Bar-Lev wrote:
> OK... now you are talking... so you say that like apache we need to
> integrate the plugins to main build system, this was the other
> alternative.

This would make more sense to me.  Either have them as optional
"configure" components, or just build and install all of them all=20
the time.

If we ignore the examples, we really only have "auth-pam" and "down-root"
in the main distribution today, and those are useful in many cases - so
I'd go for "always build and install them".

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--YD+BIkcXU0IoTTos
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT6+muqkuBuNlUUl1AQJU2QP/V1CDmGnNvbcsoNmILOVdoU1isDhUgrfx
fAoU7Cd1QOKhbiA3ZQZ/vrQ6OiUYp6F04TDOnEIsftAK8YwSLuITBO46UUbdJFlR
k6dkMC+v3rn50ngZNvDkBQcLJVEEDUprV9mh9GlWE6rj2MBTY5ouk8Ny7LQiFX8r
ydHyFs63pH4=
=K2pD
-----END PGP SIGNATURE-----

--YD+BIkcXU0IoTTos--

