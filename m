Date: Fri, 16 Aug 2013 23:24:39 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130816212439.GX16543@...1296...>
References: <kt8j7m$c5m$1@...1062...> <20130730145731.GW13127@...1152...>
	<20130730151406.GQ16543@...1296...>
	<51FA324F.1090108@...1147...>
	<20130801143058.GM16543@...1296...>
	<51FA79C6.1020405@...1147...> <51FEA1BF.9000905@...515...>
	<A3805A26-5FA4-461D-88C3-45E018208FD7@...277...>
	<5200C76B.5030008@...1114...>
	<CAOAgVpw-4=V1QoogxkTfnvqx3LVDwp8GUo5d8g05QqjZ_NhM8A@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jyWdsH1tvGESd50Z"
Content-Disposition: inline
In-Reply-To: <CAOAgVpw-4=V1QoogxkTfnvqx3LVDwp8GUo5d8g05QqjZ_NhM8A@...278...>
Subject: Re: [Openvpn-devel] [Openvpn-users] why doesn't openvpn negotiate
	settings?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Les Mikesell <lesmikesell@...277...>
Cc: openvpn-devel@lists.sourceforge.net, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

--jyWdsH1tvGESd50Z
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 06, 2013 at 10:08:03AM -0500, Les Mikesell wrote:
> On Tue, Aug 6, 2013 at 4:52 AM, David Sommerseth
> <openvpn.list@...1114...> wrote:
> >
> > * Learn about TCP/IP networking, read especially chapter 3.1 in this
> > book: <http://www.redbooks.ibm.com/redbooks/pdfs/gg243376.pdf>.  I'll
> > repeat: You MUST know how network traffic travels between hosts and rou=
ters.
>=20
> Maybe, maybe not...   Lots of people would be perfectly happy with a
> bridged configuration - which isn't recommended because of performance
> issues on large scales.=20=20=20

Which mostly isn't recommended because it's no easier than routed, it
just pretends to.  After setting "basic bridged", people usually ask how
to connect another network behind the "bridged client" node, and then
you're fully back into routing land...

> And at least an equal number would be happy
> with the openvpn host doing NAT on its LAN interface.=20=20

Now that is why OpenVPN AS exists :-) - it does exactly this.  Default
network is assigned to the tun interface (can be changed, but default
works), iptables NAT rules added automatically (can be turned off, but
on-by-default), stuff just works.  Choices answered for you.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--jyWdsH1tvGESd50Z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUg6Yl6kuBuNlUUl1AQKxGQP/ZG8Pc4868DtFba2BvGvytCBqMgL6EDt+
povZrQCPiTQUglT5/Dsw0hUw1oeygZAk8pGuFfjBBQ758FicKfXQojlDr4OyNLxf
kSYRydSetvP9ziVflfHS+1GrAdLY1e+xOTp6cNHYqeNjiahESEi/VwRSB3fqpNkU
mP0T7hJfjn0=
=aEaf
-----END PGP SIGNATURE-----

--jyWdsH1tvGESd50Z--

