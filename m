Date: Tue, 6 Dec 2016 10:10:59 +0100
From: Alberto Gonzalez Iniesta <agi@...64...>
Message-ID: <20161206091059.y3dzup635wvzkw6y@...30...>
References: <20161121091013.imxgfilt3byyqu7u@...30...>
	<1479896418-16190-1-git-send-email-gert@...1296...>
	<20161123184321.GA28918@...1296...>
	<20161205190114.skhklwwhrqtz6hci@...30...>
	<20161205200504.GV78624@...1296...>
MIME-Version: 1.0
In-Reply-To: <20161205200504.GV78624@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Refactor setting close-on-exec for
 socket FDs
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

On Mon, Dec 05, 2016 at 09:05:04PM +0100, Gert Doering wrote:
> Hi,
>=20
> On Mon, Dec 05, 2016 at 08:01:14PM +0100, Alberto Gonzalez Iniesta wrote:
> > The patch, after being adjusted to the new source, is not working anymo=
re:
> >=20
> > Mon Dec  5 19:39:34 2016 Set FD_CLOEXEC flag on file descriptor failed:=
 Bad file descriptor (errno=3D9)
> > Mon Dec  5 19:39:34 2016 Set FD_CLOEXEC flag on file descriptor failed:=
 Bad file descriptor (errno=3D9)
>=20
> This is with "the debian patch", or with my alternate suggestion?
>=20
> (I'm not sure if my patch is actually good enough as I think it's not
> fixing TCP "after accept" sockets yet - but some sort of initial feedback
> would be good :) )
>=20
> gert

So sorry Gert, I didn't notice yours. I' try it and let you know about
the result.


--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
mailto/sip: agi@...64... | en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.com

Key fingerprint =3D 5347 CBD8 3E30 A9EB 4D7D  4BF2 009B 3375 6B9A AA55

