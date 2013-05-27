Date: Mon, 27 May 2013 09:25:12 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130527072512.GY20843@...1296...>
References: <20130524215902.GM5874@...1818...>
	<20130525115819.GS20843@...1296...>
	<20130526223639.GK26337@...1818...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BtLKhN9XZDT5rY4E"
Content-Disposition: inline
In-Reply-To: <20130526223639.GK26337@...1818...>
Subject: Re: [Openvpn-devel] [PATCH] openvpn ipv6 pool env variables
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuel Thibault <samuel.thibault@...1817...>, Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--BtLKhN9XZDT5rY4E
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, May 27, 2013 at 12:36:39AM +0200, Samuel Thibault wrote:
> Gert Doering, le Sat 25 May 2013 13:58:19 +0200, a =E9crit :
> > > To make it short: yes, the ipv6 pool environment variables are useful,
> > > for user-defined scripts to be run at connection for instance to
> > > propagate routes, do accounting, etc.  The patch below adds them.
> >=20
> > You keep claiming that "yes it's useful".  The lack of feedback on the
> > list is partly due to the "To make it short" part of your mail...
>=20
> Ok. I was simply wondering whether it had perhaps got somehow dropped
> without reason.
>=20
> As I mentioned too briefly, the reason we need it is the same as for the
> IPv4 case: to announce the route to our bird daemon on connection, and
> drop it on disconnection.

Mmmmh.  Trying to understand this: so you're not using a common /64 for
the tun addresses (=3D the ifconfig-ipv6-pool), but each client gets some
other address, which is then announced on-demand by bird?

I can see that this is useful, but the naming of the environment variables
in this case is more confusing, as it's not really related to the *pool*.

Have you looked at the learn-address script?  I use something similar
at a customer (adding and removing proxy-arp entries on client connect)
and learn-address does all I need just fine...


> > So the only thing that I couldn't see right away
> > in the environment is "what IPv6 address did the remote receive?" and
> > that one *is* available as parameter to the "learn-address" script alre=
ady
> > today...
>=20
> But we need it from the disconnect script too, to remove the route
> announcement. It is available for IPv4, I don't see why things should
> be different between IPv6 and IPv4 here. It would make our script way
> more obscure for sure (having to record the route somewhere, re-read on
> disconnect).

Well, learn-address is run on disconnect, but not "right away" - true,
so having it in disconnect is useful.

I wonder whether we should also export iroute-ipv6 settings, as that would
enable on-demand routing of more than a single IPv6 address.

... need to think more about this.=20=20

But thanks anyway for explaining your use case.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--BtLKhN9XZDT5rY4E
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUaMKWKkuBuNlUUl1AQJFbwQAvqD8o9ISRjZUZ04gtMAOGxp2tx0mygm6
5Ve3pPinVEffqgtgSpfmtKJ+tWsloQqFIG97eCzzGT1d2EQEsJoEoHL8ljuXCciW
EufJI+OTlmCWpzbNU9aA8rPHG2F78dJI5EQayx6jHRyfDS6kVbCHcaFDO9F3CFSs
Sf0BBTZYr6A=
=ktm6
-----END PGP SIGNATURE-----

--BtLKhN9XZDT5rY4E--

