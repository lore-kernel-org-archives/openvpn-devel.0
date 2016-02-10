Date: Wed, 10 Feb 2016 11:27:41 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160210102741.GA24952@...1296...>
References: <CACqLfMnrWmytCz9Oz9ES1qsQienJXbxOjGAHydx2RS=5sL=waQ@...278...>
	<CACqLfMkwi_Y+jQg4zyivzwyTkPApNVQx6XWYBXiSxBANYC5nOg@...278...>
	<CACqLfMnBXwSY=MXyc7B1oMKwYE2Z_49G3mpkEPxbSAuG61tgZA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AeEJ77ig2uhsXvTj"
Content-Disposition: inline
In-Reply-To: <CACqLfMnBXwSY=MXyc7B1oMKwYE2Z_49G3mpkEPxbSAuG61tgZA@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Fix misleading socket error
 code on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Leonardo <leobasilio@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--AeEJ77ig2uhsXvTj
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

your patch has been committed to master and release/2.3 branch:

commit 5f5229e41d134b659e502bb2597c711aedaf8096 (master)
commit 7107fef4adaf6d7b139270a6e33f54466fbb9b05 (release/2.3)

Author: Leonardo Basilio <leobasilio@...277...>
Date:   Wed Feb 10 11:19:39 2016 +0100

    Correctly report TCP connection timeout on windows.

    Signed-off-by: Leonardo Basilio <leobasilio@...277...>
=20=20=20=20
    Acked-by: Arne Schwabe <arne@...1227...>
    Message-Id: <CACqLfMnBXwSY=3DMXyc7B1oMKwYE2Z_49G3mpkEPxbSAuG61tgZA@...1665...=
78...>
    URL: http://article.gmane.org/gmane.network.openvpn.devel/11085
    Signed-off-by: Gert Doering <gert@...1296...>

thanks.

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--AeEJ77ig2uhsXvTj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVrsQnKkuBuNlUUl1AQIeDAP/S61xApj8d+OMfYwMd64gkzS9pBADWRSo
4oXig/TsvyRz2yhYLTA5jvUwO0mlGLJgw71bdXgTvveGcXuLCWj5GYecbF2Mi7Eg
BoVt1fEY2LI+bRteZRMrBDqy4DcdUQxGksJ90yhKHLKkly2XqYMJKygpeHbG4N0m
hOAgs/i7UmI=
=n7t4
-----END PGP SIGNATURE-----

--AeEJ77ig2uhsXvTj--

