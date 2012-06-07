Date: Thu, 7 Jun 2012 12:02:51 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120607100251.GP1059@...1296...>
References: <4FD0735C.7090902@...515...> <CBF6422A.24DA%brabander@...1435...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline
In-Reply-To: <CBF6422A.24DA%brabander@...1435...>
Subject: Re: [Openvpn-devel] PolarSSL 1.1.0 support?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank de Brabander <brabander@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jun 07, 2012 at 11:35:58AM +0200, Frank de Brabander wrote:
> Maybe this should actually be changed to >=3D 1.1.2, since there is a
> security issue with versions from 0.99-pre4 up to and including PolarSSL
> 1.1.1.

If the PolarSSL author says so, we should follow :-)

> >I noticed that my Ubuntu 10.04 and 12.04 buildslaves which had PolarSSL
> >1.1.0 failed build during the configure phase:
> >
> >checking polarssl version... configure: error: invalid polarssl version

It might be good to improve the error message - while at it - to print
what we require.  Like:

checking polarssl version...=20
configure: error: polarssl version too old, minimum required version 1.1.2

(or so)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBT9B8S6kuBuNlUUl1AQI9KQQAtTr0PUQlqOypGACV44hoK8qxN1FU02yt
Rm3hd4NdfAmyVDkJGxt/jYhF5iXljUKMNnWr4s+l+Tv8oX/2s+Pwdgql54P2Hdd+
GOkO1nP2Qx7pZiw5T1lxPo1volupHTVwRCvcZ+aNuJjylzuwFmBpRkT1Ms4HLmEz
8cZVuLQmC8Q=
=FQ6p
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--

