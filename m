Date: Thu, 14 Mar 2013 16:33:59 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20130314153359.GV953@...1296...>
References: <20120203084426.GA24955@...1296...>
	<20130120164951.2d335b30@...1801...>
	<20130120185030.GR22465@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o+XGOUgEmmuBaVbd"
Content-Disposition: inline
In-Reply-To: <20130120185030.GR22465@...1296...>
Subject: Re: [Openvpn-devel] IPv6 enhancement: non-/64 prefix lengths for
	IPv6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Marcel =?iso-8859-1?Q?Pennewi=DF?= <mailinglists@...1145...>
Cc: openvpn-devel@lists.sourceforge.net

--o+XGOUgEmmuBaVbd
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Jan 20, 2013 at 07:50:30PM +0100, Gert Doering wrote:
> From cdfbc8952a01acde0eedf08fa0ebefed38fa2763 Mon Sep 17 00:00:00 2001
> From: Gert Doering <gert@...1296...>
> Date: Sun, 20 Jan 2013 20:50:38 +0200
> Subject: [PATCH] Permit pool size of /64.../112 for ifconfig-ipv6-pool
>=20
> (Leftover check from the early days where --server-ipv6 also only
> accepted /64 - nowadays we handle smaller pools just fine)

... talking to myself again... committed to master and release/2.3

commit 704d9273b6e0e253b62eb728fddd5bbb02503eea (master)
commit 0fb2391660a369853f20fd4807eaa5ed3461e755 (release/2.3)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--o+XGOUgEmmuBaVbd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUUHt56kuBuNlUUl1AQI/BAQAuEZFaXx5ECqxHdsXEy0PNjF951vVgZKV
1UH1/0ye3INKqC8EXy8utIpkjZGYPobjBYcfN9PzyEuglyCHsI0c+il4BIxXte1k
082q4fKqmwtXtECplqA+3rwSdnpA6G5lnnPcoXJtfEyezj1oapzzE4YZB6IfHD0F
+cOtCxwhgug=
=hEgo
-----END PGP SIGNATURE-----

--o+XGOUgEmmuBaVbd--

