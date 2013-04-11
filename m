Date: Thu, 11 Apr 2013 17:11:31 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130411151131.GX569@...1296...>
References: <1346422753-19520-1-git-send-email-arne@...1227...>
	<201304110933.r3B9XwPT011987@...1729...>
	<20130411105202.GA26778@...1296...>
	<5166B459.9020801@...515...> <5166C2B1.8050707@...1114...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gYb7txo4D4wAJl1C"
Content-Disposition: inline
In-Reply-To: <5166C2B1.8050707@...1114...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add the client id (CID) to
	the output of the status command
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--gYb7txo4D4wAJl1C
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 11, 2013 at 04:03:29PM +0200, David Sommerseth wrote:
> Rather have a policy ... if a patch breaks something, fix it within
> 24-48 hours, if not use git-revert.

works for me.=20=20

Usually these are minor issues anyway, like "symbol not available on
particular platforms" (MIN() comes to mind) or "breaks for a certain
combination of compile time options", and those can be fixed quickly
as soon as spotted by buildbot.

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--gYb7txo4D4wAJl1C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUWbSo6kuBuNlUUl1AQJK7QP+L7YQGaZAhyRypDOAS6KPLCjTxiicFSch
/SOJ2mlMg2uJZ55fbae5ZU9webpJ+Aksv8QIrfC9XaxOPvCjteSA4w1FZkeS8o/b
bs6iDJd2iYnLO9iH+vYMb/hEoD6O3yu9lPgog7RLsKnjt/zdE5pdqdoZfa/wpEvT
jTa/QfXrNMM=
=7v4p
-----END PGP SIGNATURE-----

--gYb7txo4D4wAJl1C--

