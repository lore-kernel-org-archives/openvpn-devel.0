Date: Mon, 20 Oct 2014 11:54:51 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20141020095451.GV396@...1296...>
References: <5444CE65.5000901@...515...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQv0vi9oZBoYbpa7"
Content-Disposition: inline
In-Reply-To: <5444CE65.5000901@...515...>
Subject: Re: [Openvpn-devel] Regarding OpenVPN 2.3.5 release and
	tap-windows6-related fixes
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

--LQv0vi9oZBoYbpa7
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Oct 20, 2014 at 11:57:09AM +0300, Samuli Sepp=E4nen wrote:
> However, those fixes are for the Git "master" branch, which cannot
> currently be built using "openvpn-build" (i.e. for Windows). A few weeks
> ago I backported the above patches to OpenVPN 2.3.4 and released test
> installers[1] which apparently fixed the primary issue[2]. Do we / can
> we merge the patches to "master" without testing based on the fact that
> they worked for OpenVPN 2.3.4?

If you can send the patches to the list ("as we require for patches to
be reviewed") I'll look, merge, and backport.

> Anything blocking 2.3.5 release atm?

I'm not aware of anything, except "time" maybe :-) - but this should
be doable this week.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--LQv0vi9oZBoYbpa7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVETb66kuBuNlUUl1AQJcWQP/RSh1gYbc3PZa9SK9TJAxdeDMjUBRTG8E
UKes2JHg04x/VgXg7EKeov4CdGfNPOcNeFUlzASy0L01IKZM/QSHV2V00YX24yJM
DBbL8o32zEI21PG9/Z1jbwtKVphMpQXMvQX5t+uBSdaUlJLW05Fyq0YrrDaxJTFv
SzmUl5/wtCU=
=cKj7
-----END PGP SIGNATURE-----

--LQv0vi9oZBoYbpa7--

