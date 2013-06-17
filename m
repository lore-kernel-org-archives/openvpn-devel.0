Date: Mon, 17 Jun 2013 16:36:44 +0200
From: Alberto Gonzalez Iniesta <agi@...64...>
Message-ID: <20130617143644.GA6399@...1330...>
References: <20130617110003.GX4767@...1330...>
	<20130617115112.GQ20843@...1296...>
	<20130617140518.GB3750@...1330...>
MIME-Version: 1.0
In-Reply-To: <20130617140518.GB3750@...1330...>
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

On Mon, Jun 17, 2013 at 04:05:18PM +0200, Alberto Gonzalez Iniesta wrote:
> On Mon, Jun 17, 2013 at 01:51:13PM +0200, Gert Doering wrote:
> > Hi,
> >=20
> > On Mon, Jun 17, 2013 at 01:00:03PM +0200, Alberto Gonzalez Iniesta wrot=
e:
> > > I applied the fix for CVE-2013-2061 [0] to Debian's stable version of
> > > openvpn (2.2.1) [1]. When the new package was sent to the mirrors I g=
ot
> > > a couple of reports of broken VPNs [2]. After some testing I think the
> > > problem arises with the use of "multihome" option. The server daemon
> > > starts to log lots of these:
> > > Jun 17 12:43:52 srv ovpn-srv[31073]: write UDPv4 []: Invalid argument=
 (code=3D22)
> > > Jun 17 12:43:53 srv ovpn-srv[31073]: write UDPv4 []: Invalid argument=
 (code=3D22)
> > >=20
> > > If the "multihome" option is removed, the VPN comes back to live.
> > >=20
> > > Could a patch to fix this be made or should we go back to 2.2.1 witho=
ut
> > > the patch to fix CVE-2013-2061?
> >=20
> > This patch is most definitely not affecting multihome.  If you look at
> > the patch, there is nothing in there that could affect external behavio=
ur
> > (except remove the timing variance).
> >=20
>=20
> Thanks Gert,
>=20
> I compiled the package without the patch now, and get the same (bogus)
> result. Somethigng must have changed in the build environment that
> breaks this. Will investigate further.

Does this strace output help?
From working build:

sendmsg(6, {msg_name(16)=3D{sa_family=3DAF_INET, sin_port=3Dhtons(33497), s=
in_addr=3Dinet_addr("62.82.17.220")}, msg_iov(1)=3D[{"h\22\260\274\377\244\=
300\234G\5,\256\376d\5+                                            \274\264=
V\260\20\201\tNO\202\271\354\351E}\322"..., 124}], msg_controllen=3D28, {cm=
sg_len=3D28, cmsg_level=3DSOL_IP, cmsg_type=3D, ...}, msg_flags=3D0}, 0) =
=3D 124
poll([{fd=3D6, events=3DPOLLIN|POLLPRI}, {fd=3D7, events=3DPOLLIN|POLLPRI}]=
, 2, 4037) =3D 1 ([{fd=3D6, revents=3DPOLLIN}])


From failing build:
sendmsg(6, {msg_name(16)=3D{sa_family=3DAF_INET, sin_port=3Dhtons(33497), s=
in_addr=3Dinet_addr("62.82.17.220")}, msg_iov(1)=3D[{">]\253^\16\330\226\20=
2\3\350\31\31tC\247\352\244\10\0-                                  (\363\37=
7\364\2077\360h\215\333\216{"..., 124}], msg_controllen=3D28, {cmsg_len=3D6=
62516248, cmsg_level=3DSOL_IP, cmsg_type=3D, ...}, msg_flags=3D0}, 0) =3D -=
1 EINVAL (Invalid argument)
recvmsg(6, 0x7fff5686b060, MSG_ERRQUEUE) =3D -1 EAGAIN (Resource temporaril=
y unavailable)

Seems like "cmsg_len" went nuts...

Again, only happens with multihome, if that helps...



--=20
Alberto Gonzalez Iniesta    | Formaci=F3n, consultor=EDa y soporte t=E9cnico
agi@(inittab.org|debian.org)| en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.com

Key fingerprint =3D 5347 CBD8 3E30 A9EB 4D7D  4BF2 009B 3375 6B9A AA55

