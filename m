Date: Fri, 23 Aug 2013 09:01:33 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130823070132.GV16543@...1296...>
References: <51C77F12.1090802@...515...> <5210B1EB.7000409@...1227...>
	<20130821072739.GG16543@...1296...>
	<52147A34.7050406@...1227...> <521684EA.2030202@...1114...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BldhxuJQ12PvT3+j"
Content-Disposition: inline
In-Reply-To: <521684EA.2030202@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] TLS versioning
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-users@lists.sourceforge.net
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, James Yonan <james@...515...>

--BldhxuJQ12PvT3+j
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Aug 22, 2013 at 11:38:50PM +0200, David Sommerseth wrote:
> However, I understand that some firmware "vendors" doesn't have the same=
=20
> "quick" turn-over as RHEL does.  So I think I would rather let these old=
=20
> firmwares run OpenVPN 2.0 or 2.1 and let them support their own ancient=20
> code base on their own.  We need to move forward and not cling to the old=
=20
> days forever.

This is not about "our source does not compile with 0.96 anymore" -=20
it's about "2.3 with the TLS changes does not *talk* to OpenVPN=20
2.2-compiled-with-0.96 anymore" (so asking the router vendors to
use OpenVPN 2.1 or 2.0 instead won't exactly improve things as the
TLS handshake code would be the same).

If this hits two users out of the whole Android user base, I tend to
"well, bad luck, get your router firmware updated" - if it hits more
"mainstream" users, we'll need to have a better answer.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--BldhxuJQ12PvT3+j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUhcIzKkuBuNlUUl1AQLswgQAn+Jy3tGvPOpaIE3STMF2WTp1mpD7zNWs
FNLaeqmcY56PyLIuJQJNaHG56LRE9yK4J02q9oWLoFOokW2e+K0CNBKkIslrAJpH
6m7wl4ozwmAd2xGw+h2Y13ihFGowtvWG9ptjpar5HsP/9mABPJJ5CZr8jcwI7pYa
ZkRrAdZIWis=
=1w3P
-----END PGP SIGNATURE-----

--BldhxuJQ12PvT3+j--

