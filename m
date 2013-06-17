Date: Mon, 17 Jun 2013 16:05:18 +0200
From: Alberto Gonzalez Iniesta <agi@...64...>
Message-ID: <20130617140518.GB3750@...1330...>
References: <20130617110003.GX4767@...1330...>
	<20130617115112.GQ20843@...1296...>
MIME-Version: 1.0
In-Reply-To: <20130617115112.GQ20843@...1296...>
Subject: Re: [Openvpn-devel] Fix for CVE-2013-2061 breaks multihome?
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

On Mon, Jun 17, 2013 at 01:51:13PM +0200, Gert Doering wrote:
> Hi,
>=20
> On Mon, Jun 17, 2013 at 01:00:03PM +0200, Alberto Gonzalez Iniesta wrote:
> > I applied the fix for CVE-2013-2061 [0] to Debian's stable version of
> > openvpn (2.2.1) [1]. When the new package was sent to the mirrors I got
> > a couple of reports of broken VPNs [2]. After some testing I think the
> > problem arises with the use of "multihome" option. The server daemon
> > starts to log lots of these:
> > Jun 17 12:43:52 srv ovpn-srv[31073]: write UDPv4 []: Invalid argument (=
code=3D22)
> > Jun 17 12:43:53 srv ovpn-srv[31073]: write UDPv4 []: Invalid argument (=
code=3D22)
> >=20
> > If the "multihome" option is removed, the VPN comes back to live.
> >=20
> > Could a patch to fix this be made or should we go back to 2.2.1 without
> > the patch to fix CVE-2013-2061?
>=20
> This patch is most definitely not affecting multihome.  If you look at
> the patch, there is nothing in there that could affect external behaviour
> (except remove the timing variance).
>=20

Thanks Gert,

I compiled the package without the patch now, and get the same (bogus)
result. Somethigng must have changed in the build environment that
breaks this. Will investigate further.



--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
agi@(inittab.org|debian.org)| en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.com

Key fingerprint =3D 5347 CBD8 3E30 A9EB 4D7D  4BF2 009B 3375 6B9A AA55

