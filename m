Date: Tue, 19 Jun 2012 13:00:42 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120619110042.GV1059@...1296...>
References: <1340044749-10694-1-git-send-email-arne@...1227...>
	<1340044749-10694-2-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yUw0eFUXHKnFujKq"
Content-Disposition: inline
In-Reply-To: <1340044749-10694-2-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 1/6] Only use tmpdir if tmp_dir is
	really used.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--yUw0eFUXHKnFujKq
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jun 18, 2012 at 08:39:04PM +0200, Arne Schwabe wrote:
> This fixes starting openvpn compiled as client only version of systems th=
at have no /tmp (Android). --tmp-dir could only be set if P2MP_SERVER has b=
een enabled too.

ACK - as previously discussed on the list and IRC.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--yUw0eFUXHKnFujKq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBT+Bb2akuBuNlUUl1AQI9XQQAjB0j0BQwXIK35CuogtL59GfpYCyBc+Co
xOUx+8y5SweKiIZGyklxq1ZDlgyrhxS4GzdYNQwfxEbFjQtRnt4Vlc5JUj2hNUPs
Uhne4hoBa+Aho9Iw1sXMEivR/YFB/IJA0bh3+Q++cHz/kZnQMCtngJ65oCa+QhXt
baH+ujG40Hc=
=vewf
-----END PGP SIGNATURE-----

--yUw0eFUXHKnFujKq--

