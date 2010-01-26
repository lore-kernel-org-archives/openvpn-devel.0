Date: Tue, 26 Jan 2010 17:51:36 +0200
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@...124...>
Message-ID: <20100126155136.GN2861@...1281...>
References: <20091210121501.GN16033@...1281...>
	<20091216084830.GY16033@...1281...>
MIME-Version: 1.0
In-Reply-To: <20091216084830.GY16033@...1281...>
Subject: Re: [Openvpn-devel] OpenVPN default gateway problems on
	Windows	after resume from hibernation
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

On Wed, Dec 16, 2009 at 10:48:30AM +0200, Pasi K=E4rkk=E4inen wrote:
> On Thu, Dec 10, 2009 at 02:15:01PM +0200, Pasi K=E4rkk=E4inen wrote:
> > Hello,
> >=20
> > I'm having some problems with OpenVPN (2.1rc20) on Windows Vista.=20
> > Yeah I know, vista is crap, but I had to play with it a bit.
> >=20
>=20
> I upgraded to OpenVPN 2.1.1 and the problem still happens..
>=20

This problem seems to also happen on Windows 7, not just Windows Vista.

-- Pasi

>=20
> > I've seen a couple of different problems:
> >=20
> > 1) I start the openvpn connection, and it works OK. Default gateway is
> > through the openvpn connection. Then I suspend (hibernate) the laptop,
> > and after a while when I resume from hibernation, openvpn re-connects t=
he vpn
> > successfully (openvpn gui icon goes green), but sometimes the default g=
ateway=20
> > is wrong, making the connection non-functional.
> >=20
> > OpenVPN related parts of "route print" when the openvpn connection work=
s properly:
> >=20
> > IPv4 Route Table
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > Active Routes:
> > Network Destination        Netmask          Gateway       Interface  Me=
tric
> >           0.0.0.0          0.0.0.0        10.0.0.5        10.0.0.6     =
 5
> >           10.0.0.1  255.255.255.255       10.0.0.5	  10.0.0.6      5
> >=20
> > Default route points to the OpenVPN interface correctly and the connect=
ions works OK.
> >=20
> > Now, after hibernate+resume, _sometimes_ (not always) the routing table
> > looks like this, and the connection doesn't work:
> >=20
> > IPv4 Route Table
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > Active Routes:
> > Network Destination        Netmask          Gateway       Interface  Me=
tric
> >           0.0.0.0          0.0.0.0        10.0.0.5               18    =
  5
> >           10.0.0.1  255.255.255.255       10.0.0.5               18    =
  5
> >=20
> > Which is a bit weird.. Interface is just a number? anyway, the next var=
iation=20
> > happens more often:
> >=20
> > IPv4 Route Table
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > Active Routes:
> > Network Destination        Netmask          Gateway       Interface  Me=
tric
> >           0.0.0.0          0.0.0.0        10.0.0.5  169.254.108.226    =
  5
> >           10.0.0.1  255.255.255.255       10.0.0.5  169.254.108.226    =
  5
> >=20
> >=20
> > So that looks like it fails to get an IP with DHCP.=20
> > "ipconfig /all" show this:
> >=20
> > Ethernet adapter Local Area Connection 3:
> >=20
> >    Connection-specific DNS Suffix  . :
> >    Description . . . . . . . . . . . : TAP-Win32 Adapter V9
> >    Physical Address. . . . . . . . . : 00-FF-82-51-06-E2
> >    DHCP Enabled. . . . . . . . . . . : Yes
> >    Autoconfiguration Enabled . . . . : Yes
> >    Autoconfiguration IPv4 Address. . : 169.254.108.226(Preferred)
> >    Subnet Mask . . . . . . . . . . . : 255.255.0.0
> >    Default Gateway . . . . . . . . . : 10.0.0.5
> >    NetBIOS over Tcpip. . . . . . . . : Enabled
> >=20
> > So yeah.. it failed to obtain an IP with DHCP.=20
> > I saw some DHCP related fixes in the latest rc versions.. related possi=
bly?
> >
>=20
> So it was not this, since I have the same problems with version 2.1.1.
>=20
> -- Pasi
>=20
> > Weird that the OpenVPN gui icon is still green, when obviously the open=
vpn=20
> > connection is broken.
> >=20
> >=20
> > 2) OpenVPN and other nics/connections. I had to change the OpenVPN Wind=
ows
> > TAP network adapter interface metric to 5 manually, to make it be the
> > preferred connection always. Otherwise for example the WLAN took over
> > the default gateway sometimes.
> >=20
> > Is there some way to specify the interface metric in openvpn
> > configuration?=20
> >=20
> > Thanks!
> >=20
> > -- Pasi
> >=20
> >=20
>=20
>=20
> -------------------------------------------------------------------------=
-----
> This SF.Net email is sponsored by the Verizon Developer Community
> Take advantage of Verizon's best-in-class app development support
> A streamlined, 14 day to market process makes app distribution fast and e=
asy
> Join now and get one step closer to millions of Verizon customers
> http://p.sf.net/sfu/verizon-dev2dev=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

