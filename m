Date: Sat, 23 May 2015 21:10:47 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150523191047.GH382@...1296...>
References: <555BF270.3090706@...1147...>
	<1432404098-29401-1-git-send-email-gert@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GIrCAcOpC7mETZ4T"
Content-Disposition: inline
In-Reply-To: <1432404098-29401-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] repair --dev null breakage caused by
	db950be85d37
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--GIrCAcOpC7mETZ4T
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, May 23, 2015 at 08:01:38PM +0200, Gert Doering wrote:
> "make check" self-test was broken after commit db950be85d37 due to
> do_ifconfig_setenv() not checking whether tt->did_ifconfig_setup
> was set (which isn't, for "dev null" type setups)

Applied to master and release/2.3 branches.  Tested with "make check".

commit 970c4bd2e473f625699bd56db44c1970a9e10ed9 (master)
commit 7b285112d22f74c19dd5b1476ddbf1bd83339c84 (release/3.)

Author: Gert Doering <gert@...1296...>
Date:   Sat May 23 19:35:05 2015 +0200

    repair --dev null breakage caused by db950be85d37
    Signed-off-by: Gert Doering <gert@...1296...>
    Acked-by: Steffan Karger <steffan@...1856...>
    Message-Id: <1432404098-29401-1-git-send-email-gert@...1296...>
    URL: http://article.gmane.org/gmane.network.openvpn.devel/9718

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--GIrCAcOpC7mETZ4T
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVWDQt6kuBuNlUUl1AQK5GwP+KgqS1bRqkFybDnreE+7LXw174+uTJYCF
9lOgRp4gw0GvH/YnTvrFVOWk3juvCPsFST8LF5bEHGYbQ6Lxylad0yuIC4y7L8o8
igasIzSFaLDZ5ErNBzLv/sMTqgvyl6bWy7uZyHNq4ZumUbd3J2tdcqcHoO7cgn7W
wrAW0JhDwpg=
=xhMX
-----END PGP SIGNATURE-----

--GIrCAcOpC7mETZ4T--

