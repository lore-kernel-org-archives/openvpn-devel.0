Date: Tue, 30 Sep 2014 13:41:53 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140930114153.GZ396@...1296...>
References: <54291DD9.6060802@...515...> <54297B80.8010902@...1147...>
	<542A6728.6000707@...515...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3xQkynibq3FKlJyM"
Content-Disposition: inline
In-Reply-To: <542A6728.6000707@...515...>
Subject: Re: [Openvpn-devel] Any Windows-based OpenVPN servers available for
	fixing bug #432?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--3xQkynibq3FKlJyM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Sep 30, 2014 at 11:17:44AM +0300, Samuli Sepp=E4nen wrote:
> Just got more info from Thomas who's fixing the tap-windows6 issues.
> According to him most of the bugs are actually triggered by user-space
> code in OpenVPN 2.x which does not handle tap-windows errors correctly.
> He's working on that issue right now.

Patches for the 2.x code welcome :-)  - I have no idea what we do wrong,
as the whole "talk to a windows device driver" thing is magic for me.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--3xQkynibq3FKlJyM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVCqXAakuBuNlUUl1AQJaLwP+Jo508hEpBOXD/Vw/RGIYocLJQElfqTnJ
r8ATCFOFVQnixIAiOaqKtnNwKpAo1647YMGvbRCVDf7I9aVIrAn240o7HlGiC4Yj
w1/qaTbVjE1hYBc3qHbQOlgs9dBduMsD1fzhradDwK8hLyalqCQOxYcZdWymFuNR
zmlZ5J03IV0=
=fSF8
-----END PGP SIGNATURE-----

--3xQkynibq3FKlJyM--

