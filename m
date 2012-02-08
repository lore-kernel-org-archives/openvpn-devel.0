Date: Wed, 8 Feb 2012 19:21:52 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120208182152.GA13929@...1296...>
References: <CA+3tv22Xq447J_EXKM4SYP-45V7LN0NJfH6o9skUNPPij3PDuQ@...278...>
	<1CED409804E2164C8104F9E623B08B90129328AD5E@...1436...>
	<20120208080953.GS13929@...1296...>
	<CA+3tv2064zxi_v1hJPWaF+bd5FUrXYm+h+qYDnorHz8OrpxyGQ@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BVQ1RKc6+nLPB5pT"
Content-Disposition: inline
In-Reply-To: <CA+3tv2064zxi_v1hJPWaF+bd5FUrXYm+h+qYDnorHz8OrpxyGQ@...278...>
Subject: Re: [Openvpn-devel] OpenVPN and Android 4.0 VPN API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Ring <sjr@...1546...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--BVQ1RKc6+nLPB5pT
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Feb 08, 2012 at 04:16:20AM -0800, James Ring wrote:
> Looks like you need to pass a native fd. OpenVPN would not be able to
> open the device itself. There looks to be a chicken and egg problem
> here though: the fd is returned by the VpnService.Builder.establish()
> method
>=20
> http://developer.android.com/reference/android/net/VpnService.Builder.htm=
l#establish()
>=20
> This needs to happen after a bunch of parameters are already known.
> Since OpenVPN would normally take care of negotiating these with the
> other end, it would seem that the tunnel fd is not available to
> OpenVPN in time to do this. Perhaps the user would have to configure
> the route, search domain, IP address and other parameters in advance
> of starting the VPN connection. That would suck.

You only need the *tunnel* FD to forward packets to the android networking
stack.  To connect to the OpenVPN server, you use a normal socket, which
would have to be opened by OpenVPN - but that's a standard network operation
which doesn't need special privileges.

Right now, passing in the tun device file handle from an external source
isn't something directly supported, but the open_tun() method is very
platform specific anyway, so it's not unsolvable.

[..]
> > ... and for the rest, well, we'd need a volunteer that wants to *work* =
on
> > this, not just ask for it... =A0I don't have an Android device (and no
> > time) so it wouldn't be me.
>=20
> I'm raising my hand. This path sounds better than what I thought would
> be necessary (writing OpenVPN client implementation in Java). I'm also
> asking around here at Google to see if somebody with more experience
> with Android is interested in helping out. I'm sure there is
> sufficient interest on both sides (Android and OpenVPN) to get
> something working. This would make a niche segment of Android users
> very happy I'm sure.

This would be extremely cool!

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--BVQ1RKc6+nLPB5pT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTzK9QKkuBuNlUUl1AQIijgP/ROy5OYmVUDXCAeSldAu2sGfED63E4w7W
9AXkhl8Tv8zataxqzGfOWOkfeeuAcWsryHD1FzD59BF4TMKgv+fF330Lszfq7Rq3
/oQKNzk3a6AanxPmcdfAePsKjxaQJreMmckYQa8NHHbCdAcaQY3cfxYsSymh3GRw
5szjpfbdykw=
=urtU
-----END PGP SIGNATURE-----

--BVQ1RKc6+nLPB5pT--

