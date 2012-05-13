Date: Sun, 13 May 2012 11:23:56 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120513092355.GH1359@...1296...>
References: <CAOazyz2FzRu8y6FR1xiygh=KCBB=q-N5HrjLLzn5q1_AgL_3ig@...278...>
	<4FA77AB9.7090001@...1114...>
	<CAOazyz3QDHLxY51u0Ya9PscD8Q5+VqqrSn6M6=XpVUiFJY_ENw@...278...>
	<4FA8D931.70107@...515...>
	<CAOazyz2N744s+VJekGJNK4sqHCONLCzMtsiJyRTkgrpO4RWHzw@...278...>
	<363B57F6-F3E8-4C7D-A19D-0E08541233BD@...1286...>
	<20120513090153.GG1359@...1296...>
	<CAOazyz1FB+JU7QRmeMuxMX7-6fAN28VH1-6ApJnOu7eHDq9jUA@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vcAHil5vpZ7GIFv9"
Content-Disposition: inline
In-Reply-To: <CAOazyz1FB+JU7QRmeMuxMX7-6fAN28VH1-6ApJnOu7eHDq9jUA@...278...>
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

--vcAHil5vpZ7GIFv9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, May 13, 2012 at 12:10:48PM +0300, Alon Bar-Lev wrote:
> And, if not split, they these two plugins should integrated within
> build system.=20

This is certainly true.

> The custom make files are not doing any good, but I
> still don't understand the difference between these two and other
> plugins out there.

They are maintained by the openvpn project, and other plugins are not.

That difference should be quite obious, no?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--vcAHil5vpZ7GIFv9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT699q6kuBuNlUUl1AQIVTgP9FZVH3e6xYae4INsaQXoXqbTUe4kJ/VSQ
6gmNp/Ug6dpam04JYGgaW7YTimgmmSzYDMEySbJ0K1CiCfx53DMhCU5IBnb+yNpW
LWHY7Yc0HmvQI45ih9sznC3Gk8GR9y0fU/tR3Rl45TMVQ/aV00w04aGl7O7Nj4Nu
6mA4qb2Pr0M=
=a1wR
-----END PGP SIGNATURE-----

--vcAHil5vpZ7GIFv9--

