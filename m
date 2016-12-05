Date: Mon, 5 Dec 2016 20:01:14 +0100
From: Alberto Gonzalez Iniesta <agi@...64...>
Message-ID: <20161205190114.skhklwwhrqtz6hci@...30...>
References: <20161121091013.imxgfilt3byyqu7u@...30...>
	<1479896418-16190-1-git-send-email-gert@...1296...>
	<20161123184321.GA28918@...1296...>
MIME-Version: 1.0
In-Reply-To: <20161123184321.GA28918@...1296...>
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

On Wed, Nov 23, 2016 at 07:43:21PM +0100, Gert Doering wrote:
> Hi,
>=20
> On Wed, Nov 23, 2016 at 11:20:18AM +0100, Gert Doering wrote:
> > The existing code can leak socket FDs to the "--up" script, which is
> > not desired.  Brought up by Alberto Gonzalez Iniesta, based on debian
> > bug 367716.
>=20
> I'm not sure if that patch is good enough yet.
>=20
> Arne brought up "port-share" - where we fork processes, so it needs to
> be ensured that whatever that process needs is still working.
>=20
> In addition to that, we have "TCP server" processes, which create new
> sockets not by calling socket() but by calling accept() on the listening
> socket, which is not in one of thew set_cloexec() paths - but watch out,
> *these* might be the ones needed for port-share.
>=20
> gert

Hi,

The patch, after being adjusted to the new source, is not working anymore:

Mon Dec  5 19:39:34 2016 Set FD_CLOEXEC flag on file descriptor failed: Bad=
 file descriptor (errno=3D9)
Mon Dec  5 19:39:34 2016 Set FD_CLOEXEC flag on file descriptor failed: Bad=
 file descriptor (errno=3D9)
Mon Dec  5 19:39:34 2016 Exiting due to fatal error
Mon Dec  5 19:39:34 2016 Exiting due to fatal error
FAIL: t_cltsrv.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
1 of 2 tests failed
(1 test was not run)
Please report to openvpn-users@lists.sourceforge.net
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

So I guess Debian's bug #367716 [1] will come back from the dead :-( with 2=
.4.

Regards,

Alberto

[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D367716

--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
mailto/sip: agi@...64... | en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.com

Key fingerprint =3D 5347 CBD8 3E30 A9EB 4D7D  4BF2 009B 3375 6B9A AA55

