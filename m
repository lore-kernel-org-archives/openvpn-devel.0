Date: Tue, 30 Sep 2014 14:25:51 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140930122551.GA396@...1296...>
References: <54291DD9.6060802@...515...> <54297B80.8010902@...1147...>
	<542A6728.6000707@...515...>
	<20140930114153.GZ396@...1296...>
	<542A9F92.7060908@...515...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GeONROBiaq1zPAtT"
Content-Disposition: inline
In-Reply-To: <542A9F92.7060908@...515...>
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

--GeONROBiaq1zPAtT
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Sep 30, 2014 at 03:18:26PM +0300, Samuli Sepp=E4nen wrote:
> > On Tue, Sep 30, 2014 at 11:17:44AM +0300, Samuli Sepp=E4nen wrote:
> >> Just got more info from Thomas who's fixing the tap-windows6 issues.
> >> According to him most of the bugs are actually triggered by user-space
> >> code in OpenVPN 2.x which does not handle tap-windows errors correctly.
> >> He's working on that issue right now.
> >
> > Patches for the 2.x code welcome :-)  - I have no idea what we do wrong,
> > as the whole "talk to a windows device driver" thing is magic for me.
>=20
> Apparently 2.x is not handling certain tap-windows6 return/error codes
> correctly. According to Thomas that is causing several of the issues
> we've experienced with tap-windows6.

I understood that - thus: patches (for OpenVPN 2.x) welcome :-9

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--GeONROBiaq1zPAtT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVCqhT6kuBuNlUUl1AQJbWAQAsjPjVVLYzN8ekwi3GZU+jLr7446EtRhK
Jw7r8eXK4DhBi8NhnenCW7So45WsHmMbrgPr+Bs16njIS1Bfq3WVQABKIdcETw42
OclFokNJg8RHWpfOHrZtl6D83UiWYqvxjyzDuvA0kHd8rqiNZzUjnPheTba4zD+T
Eggg0faYDwU=
=csnf
-----END PGP SIGNATURE-----

--GeONROBiaq1zPAtT--

