Date: Wed, 29 May 2013 15:38:17 +0200
From: Alberto Gonzalez Iniesta <agi@...64...>
Message-ID: <20130529133817.GG6942@...1330...>
References: <CAMaBZnHDPHTpPmFoLbyDHxKnBwm7PdPDouZi99bgQzrA9=eXDw@...278...>
	<20130529122956.GH20843@...1296...>
MIME-Version: 1.0
In-Reply-To: <20130529122956.GH20843@...1296...>
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

On Wed, May 29, 2013 at 02:29:57PM +0200, Gert Doering wrote:
> Hi,
>=20
> On Wed, May 29, 2013 at 08:24:43AM -0400, Praetorian wrote:
> > With the stable release of Wheezy is there a time frame that there migh=
t be
> > a openvpn repo for Wheezy?  I have a multisite setup that I would like =
to
> > update to Wheezy that could take advantage of some of the advancements =
in
> > Wheezy. Sadly ver 2.2 is what is in the Debian repo for Wheezy currentl=
y.
> >  The setup currently runs off the 2.3 version for some of the ipv6 need=
s.
>=20
> Isn't Debian incorporating the IPv6 patches anyway that bring most of=20
> the 2.3 ipv6 functionality to 2.2?

Yes, it is. AFAIK.
Anyway, I'll try to make a backport one of these days, but the one in
unstable should work in Wheezy too.

--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
agi@(inittab.org|debian.org)| en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.com

Key fingerprint =3D 5347 CBD8 3E30 A9EB 4D7D  4BF2 009B 3375 6B9A AA55

