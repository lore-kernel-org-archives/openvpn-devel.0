Date: Mon, 17 Jun 2013 18:28:19 +0200
From: Alberto Gonzalez Iniesta <agi@...64...>
Message-ID: <20130617162819.GF3750@...1330...>
References: <20130617110003.GX4767@...1330...>
	<20130617115112.GQ20843@...1296...>
	<20130617140518.GB3750@...1330...>
	<20130617143644.GA6399@...1330...>
	<20130617153623.GS20843@...1296...>
MIME-Version: 1.0
In-Reply-To: <20130617153623.GS20843@...1296...>
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

On Mon, Jun 17, 2013 at 05:36:23PM +0200, Gert Doering wrote:
> Hi,
>=20
> On Mon, Jun 17, 2013 at 04:36:44PM +0200, Alberto Gonzalez Iniesta wrote:
> > Seems like "cmsg_len" went nuts...
>=20
> Seems your compiler grew too much smarts and optimized that bug to death =
:-)
>=20
> > Again, only happens with multihome, if that helps...
>=20
> That code path is only used for multihome.  Bugfix is here (if it's indeed
> *that* problem):
>=20

Thanks a log Gert. Yes, applying the patch solved the problem.

Cheers,

Alberto

--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
agi@(inittab.org|debian.org)| en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.com

Key fingerprint =3D 5347 CBD8 3E30 A9EB 4D7D  4BF2 009B 3375 6B9A AA55

