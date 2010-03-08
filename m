Date: Mon, 08 Mar 2010 15:19:50 -0600
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <20100308202613.22343.qmail@...1287...> (from peter@...1287... on
	Mon Mar  8 14:26:13 2010)
Message-Id: <1268083190.11342.0@...1207...>
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

On 03/08/2010 02:26:13 PM, Peter Stuge wrote:
> Karl O. Pinc wrote:
> > > I know of at least four DHCP clients and I avoid dhclient as much
> as
> > > possible. It would be a tremendous mistake to tie OpenVPN to any
> one
> > > DHCP client IMO.
> >=20
> > Only D is tied to dhclient.  A, B, and C, work fine with any dhcp
> > client daemon.  (Or A does anyway, B and C require configuration
> file
> > support for the interface.  I assume this is a common property of
> > dhcp clients.)
>=20
> Actually no, neither dhcpcd nor pump nor udhcpc uses one.

dhcpd needs one if you're going to have different interfaces
that need different dhcp options.

>=20
>=20
> > It would be nice not to force use of a particular client.
>=20
> I think it's neccessary.

Ok.  Agreed.

>=20
>=20
> > Given that.  Why not just use -up and --down to do what's
> > needed?  Avoid changing the code and write documentation.
>=20
> Agree completely. This is how I've been using OpenVPN for years
> already.

Do you have a particular config known to work with
"route-gateway dhcp"?

Do you think the distros are different enough that
separate sample config files should be supplied for each?

If documentation is all that's required perhaps the user
list should be queried to see who's already doing what
and if anybody has a starting point.


Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


