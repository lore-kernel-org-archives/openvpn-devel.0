Date: Thu, 30 May 2013 11:45:34 +0200
From: Alberto Gonzalez Iniesta <agi@...64...>
Message-ID: <20130530094534.GM3623@...1330...>
References: <CAMaBZnHDPHTpPmFoLbyDHxKnBwm7PdPDouZi99bgQzrA9=eXDw@...278...>
	<20130529122956.GH20843@...1296...>
	<20130529133817.GG6942@...1330...>
	<CAMaBZnFwr4iMVTg4QSkosMYsqnpq5-_rt9eny-O9fCSLFLoiqg@...278...>
MIME-Version: 1.0
In-Reply-To: <CAMaBZnFwr4iMVTg4QSkosMYsqnpq5-_rt9eny-O9fCSLFLoiqg@...278...>
Subject: Re: [Openvpn-devel] Repos for Debian Wheezy?
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
To: openvpn-devel@lists.sourceforge.net

Well, 2.3 is in the Debian repos. Both in sid (unstable) and
jessie (testing). Wheezy (Stable) was frozen (no more updates) way
before OpenVPN 2.3.0 was released, so its inclusion was not possible.

We'll have a backport of 2.3.x for wheezy.


On Wed, May 29, 2013 at 02:37:12PM -0400, Praetorian wrote:
> I'll take a look at the one in unstable.  I'm not sure what parts have be=
en
> back ported to 2.2 that I have been testing in the 2.3 branch.  I would
> have thought that 2.3 is mature enough to be in the debian repos by now.
>=20
>=20
> On Wed, May 29, 2013 at 9:38 AM, Alberto Gonzalez Iniesta
> <agi@...64...>wrote:
>=20
> > On Wed, May 29, 2013 at 02:29:57PM +0200, Gert Doering wrote:
> > > Hi,
> > >
> > > On Wed, May 29, 2013 at 08:24:43AM -0400, Praetorian wrote:
> > > > With the stable release of Wheezy is there a time frame that there
> > might be
> > > > a openvpn repo for Wheezy?  I have a multisite setup that I would l=
ike
> > to
> > > > update to Wheezy that could take advantage of some of the advanceme=
nts
> > in
> > > > Wheezy. Sadly ver 2.2 is what is in the Debian repo for Wheezy
> > currently.
> > > >  The setup currently runs off the 2.3 version for some of the ipv6
> > needs.
> > >
> > > Isn't Debian incorporating the IPv6 patches anyway that bring most of
> > > the 2.3 ipv6 functionality to 2.2?
> >
> > Yes, it is. AFAIK.
> > Anyway, I'll try to make a backport one of these days, but the one in
> > unstable should work in Wheezy too.
> >
> > --
> > Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9=
cnico
> > agi@(inittab.org|debian.org)| en GNU/Linux y software libre
> > Encrypted mail preferred    | http://inittab.com
> >
> > Key fingerprint =3D 5347 CBD8 3E30 A9EB 4D7D  4BF2 009B 3375 6B9A AA55
> >
> >
> > -----------------------------------------------------------------------=
-------
> > Introducing AppDynamics Lite, a free troubleshooting tool for Java/.NET
> > Get 100% visibility into your production application - at no cost.
> > Code-level diagnostics for performance bottlenecks with <2% overhead
> > Download for free and get started troubleshooting in minutes.
> > http://p.sf.net/sfu/appdyn_d2d_ap1
> > _______________________________________________
> > Openvpn-devel mailing list
> > Openvpn-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> >

> -------------------------------------------------------------------------=
-----
> Introducing AppDynamics Lite, a free troubleshooting tool for Java/.NET
> Get 100% visibility into your production application - at no cost.
> Code-level diagnostics for performance bottlenecks with <2% overhead
> Download for free and get started troubleshooting in minutes.
> http://p.sf.net/sfu/appdyn_d2d_ap1

> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
agi@(inittab.org|debian.org)| en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.com

Key fingerprint =3D 5347 CBD8 3E30 A9EB 4D7D  4BF2 009B 3375 6B9A AA55

