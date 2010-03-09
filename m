Date: Tue, 09 Mar 2010 09:49:11 -0600
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <20100309064736.18556.qmail@...1287...> (from peter@...1287... on
	Tue Mar  9 00:47:36 2010)
Message-Id: <1268149751.24740.1@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Supporting "route-gateway dhcp" on non-Windows
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
To: Peter Stuge <peter@...1287...>
Cc: openvpn-devel@lists.sourceforge.net

On 03/09/2010 12:47:36 AM, Peter Stuge wrote:
> Karl O. Pinc wrote:
> > The boot order that makes sense to me is:
> >=20
> > bring the interfaces up
> > start dhcp client (if not triggered directly from the interfaces)
> > start openvpn
> >=20
> > The problem is that if the dhcp client is started before openvpn
> > and openvpn is creating the tap interface then it's too late
>=20
> At least some distributions work more like this:
>=20
> foreach interface:
>   set link up
>   possibly start openvpn
>   address add

Ok.  So this then relies on openVPN retries to get the connection
open, because when openvpn starts it's not got addresses
in place to reach the other endpoint.  The only downside
is that the startup is not really synchronous so that if
later portions of the boot process are relying on having
the VPN available they'd better be able to retry too.

In this case it should "just work" on those distros, at least so
long as the "address add" part is configured to use dhcp.  Yes?

Anyone know if it does work?

Which distros work like that?  I'm most familiar with
Debian and RedHat, although I've not looked at openvpn
on RedHat in a while.  I seem to recall on these
that the sysV init stuff starts openvpn last.




Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


