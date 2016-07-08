Date: Sat, 9 Jul 2016 00:27:46 +0300
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@...124...>
Message-ID: <20160708212746.GD13212@...1281...>
References: <CAFHpkQGrube6hF3+hab3NdNhcifjV15ZSefdUWCcXJPg_CApKw@...278...>
	<20160629081109.GU78279@...1296...>
	<CAFHpkQGD10-N=fX6osaMKE4SN+S55A8EN+8byw6aTM9Aosd1Mw@...278...>
	<20160629090025.GV78279@...1296...>
	<CAFHpkQEQq8sbEfMDXwMBNUi4-qt81drpQETKTWmHKAxfwpmdyw@...278...>
	<caae589a-7710-2d22-0add-95d450e96a79@...515...>
MIME-Version: 1.0
In-Reply-To: <caae589a-7710-2d22-0add-95d450e96a79@...515...>
Subject: Re: [Openvpn-devel] git master: no more WinXP ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Wed, Jun 29, 2016 at 01:14:21PM +0300, Samuli Sepp=E4nen wrote:
> This seems like a reasonable approach. We already provide static links=20
> to "latest" releases:
>=20
> <http://build.openvpn.net/downloads/releases/latest/>
>=20
> Right now all of the links point to OpenVPN 2.3.x, but there is already=20
> support for "latest testing version" and "latest stable version", so the=
=20
> 2.3/2.4 split is easy to do. Once 2.4 goes "stable" we could either drop=
=20
> 2.3 support _or_ add another variant such as "oldstable".
>

If openvpn 2.3 is the last version which is supported on WinXP, then the li=
nk to it=20
should have "2.3" on it, otherwise the link will get broken at some point..


-- Pasi
=20
> Samuli
>=20
> > my colleguae suggested that
> >
> > 1) installer should detect "running on windows xp"
> > 2) installer should suggest to install previous version of openvpn and
> > provide a link to it.
> > 3) after that installer should refuse to install
> >
> > looks good
> >
> > 2016-06-29 14:00 GMT+05:00 Gert Doering <gert@...1296...
> > <mailto:gert@...1296...>>:
> >
> >     Hi,
> >
> >     On Wed, Jun 29, 2016 at 01:57:14PM +0500, ???????? ?????????????? w=
rote:
> >     > ok, if so, we need to modify installer to detect that.
> >
> >     Right, "master" installers should refuse cooperation on XP.
> >
> >     Samuli, you're listening? ;-)
> >
> >     gert
> >
> >     --
> >     USENET is *not* the non-clickable part of WWW!
> >
> >      //www.muc.de/~gert/ <http://www.muc.de/~gert/>
> >     Gert Doering - Munich, Germany
> >      gert@...1296... <mailto:gert@...1296...>
> >     fax: +49-89-35655025
> >     gert@...1297...
> >     <mailto:gert@...1297...>
> >
> >
> >
> >
> > -----------------------------------------------------------------------=
-------
> > Attend Shape: An AT&T Tech Expo July 15-16. Meet us at AT&T Park in San
> > Francisco, CA to explore cutting-edge tech and listen to tech luminaries
> > present their vision of the future. This family event has something for
> > everyone, including kids. Get more information and register today.
> > http://sdm.link/attshape
> >
> >
> >
> > _______________________________________________
> > Openvpn-devel mailing list
> > Openvpn-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> >
>=20
>=20
> --=20
> Samuli Sepp=E4nen
> Community Manager
> OpenVPN Technologies, Inc
>=20
> irc freenode net: mattock
>=20
> -------------------------------------------------------------------------=
-----
> Attend Shape: An AT&T Tech Expo July 15-16. Meet us at AT&T Park in San
> Francisco, CA to explore cutting-edge tech and listen to tech luminaries
> present their vision of the future. This family event has something for
> everyone, including kids. Get more information and register today.
> http://sdm.link/attshape
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

