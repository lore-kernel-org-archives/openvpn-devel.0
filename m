Date: Fri, 05 Mar 2010 10:52:53 -0600
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <20100305163926.GM25238@...1296...> (from
	gert@...1296... on Fri Mar  5 10:39:26 2010)
Message-Id: <1267807973.14083.0@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] special-case code for OpenBSD - advice needed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On 03/05/2010 10:39:26 AM, Gert Doering wrote:
> Hi,
>=20
> On Fri, Mar 05, 2010 at 11:44:28AM +0100, Heiko Hund wrote:
> > On Friday 05 March 2010 10:11:51 Gert Doering wrote:
> > > What happened exactly?  Could you ask your colleague for a log
> file?
> >=20
> > Well, he couldn't ping any remote host. Nothing special in the log,
> really. If=20
> > it isn't misleading it's quite obvious that the ordering is wrong:
> >=20
> >   TUN/TAP device /dev/tun1 opened
> >   /sbin/ifconfig tun1 destroy
> >   /sbin/ifconfig tun1 create
> >   NOTE: Tried to delete pre-existing tun/tap instance --No Problem
> if failure
> >   /sbin/ifconfig tun1 10.1.1.18 10.1.1.17 mtu 1500 netmask
> 255.255.255.255 up
>=20
> Well, this is exactly what the current code for NetBSD does... (and
> how
> this thread got started).  On NetBSD, it works.
>=20
> The problem is that if you do it the other way round, you have a big
> fat
> race condition here - between "I assume that my tun device will be
> tun1,
> so I do 'ifconfig tun1 destroy' now" and actually opening /dev/tun1,=20
> some other process might grab this tun device.
>=20
> open() first will exclusively lock it for you...
