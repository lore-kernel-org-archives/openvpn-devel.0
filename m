Date: Sun, 13 Apr 2014 13:29:42 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140413112942.GN16637@...1296...>
References: <20140413111500.GM16637@...1296...>
	<534A72C8.1020203@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="REDQ9bXMXAvhQ/8c"
Content-Disposition: inline
In-Reply-To: <534A72C8.1020203@...1227...>
Subject: Re: [Openvpn-devel] github pull 15 / Fix typo in build script to
	use LDFLAGS
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: kangsterizer <kang@...1896...>
Cc: openvpn-devel@lists.sourceforge.net

--REDQ9bXMXAvhQ/8c
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Apr 13, 2014 at 01:19:36PM +0200, Arne Schwabe wrote:
> Am 13.04.14 13:15, schrieb Gert Doering:
> > From 553ca06af9e9c2daa8acfa36988aac0b8ed5dab4 Mon Sep 17 00:00:00 2001
> > From: kangsterizer <kang@...1896...>
> > Date: Thu, 10 Apr 2014 11:23:24 -0700
> > Subject: [PATCH] Fix typo in build script to use LDFLAGS

Applied to master and release/2.3

commit a95358af543b9106f4ef481e4556d1d03459d058 (master)
commit e8d8e50f4da33af6e81675174fcfbf0fd8642b91 (release/2.3)

Author: kangsterizer <kang@...1896...>
Date:   Sun Apr 13 13:15:00 2014 +0200

    Fix typo in sample build script to use LDFLAGS
=20=20=20=20
    Came in as github pull request #15
=20=20=20=20
    Signed-off-by: Gert Doering <gert@...1296...>
    Acked-By: Arne Schwabe <arne@...1227...>

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--REDQ9bXMXAvhQ/8c
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU0p1JqkuBuNlUUl1AQJDUQP/WjkWSoiBUDpM/0HH1ehVqdm7TSjDBcvu
fNYrqJk70d+QoaG6Kf9vJ2PtyxRAUsPfP6Hnw03tCM3h9Uv80Ibg/9Z12+DGOe5k
VVpKZOH10SiRjxatUwHbtYjaC8f1FtHLhPrVEPbgSoGwKonTjyMVfInLm6x1Swk/
Pwx6ksMjqy4=
=8oEy
-----END PGP SIGNATURE-----

--REDQ9bXMXAvhQ/8c--

