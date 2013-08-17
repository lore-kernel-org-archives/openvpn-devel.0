Message-ID: <520F7801.7030705@...68...>
Date: Sat, 17 Aug 2013 15:17:53 +0200
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <20130817103007.GA16543@...1296...>
In-Reply-To: <20130817103007.GA16543@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig250ECFDD30D9597AFBB2192C"
Subject: Re: [Openvpn-devel] RFD - block-ipv6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig250ECFDD30D9597AFBB2192C
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Am 17.08.2013 12:30, schrieb Gert Doering:

> So, what I'm hoping to hear from you...
>=20
>  - should we include this in 2.3.3?
>     - if yes, are changes needed?

Well, it would take huge warning banners because it might disrupt
existing setups (which would be insecure through the "connect around
tunnel" behaviour), so I'd prefer "2.4" with a sooner 2.4 release.

>  - should we try to implement something for 2.4/master that will work=20
>    by pointing the IPv6 routes into the tunnel, and then synthesize the
>    IPv6 ICMP errors inside OpenVPN?  That would work on Android and iOS
>    as well, and remove the extra per-platform logic for the "reject" rout=
es

Absolutely, on both accounts, if technically feasible.  You may need to
synthesize RST for stale TCP sockets, and ICMP for UDP, too.

>  - any clever ideas how to achieve "full" IPv6 blocking (right now, it on=
ly
>    kills the default route, but all more specific routes continue working=
 -
>    this is by design to keep the implementation simple, and was considered
>    "good enough" by the end customer asking for it)

End users may also have requirements to override certain more specific
routes to bypass the tunnel.  I can fancy only few things that are
worse than flipping global connection status "with/without VPN" every
few minutes if you need host and "home" resources at the same time.

Use case is for guests in a "host" LAN that need the VPN for the default
route and "home" networks, but need to access local organizer (host)
information, too. And very common during symposiums, conferences, and
thereabouts.

Like: you visit another place, and you need access to the journals of
your home university, but at the same time the organizer uploaded
documents for collaborative work or you need local public transport
schedules.

I found myself using the "permit local specific routes" switch quite
often to avoid dis-/reconnecting all the time.  That was with "all
IPv4", however.



--------------enig250ECFDD30D9597AFBB2192C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlIPeAEACgkQvmGDOQUufZVnCgCeKjB0QW4EgjtiK1s9+IGa/Mfl
BRcAoIJzieiHP7Fd2qqbKhF+yVOjeoml
=uTDp
-----END PGP SIGNATURE-----

--------------enig250ECFDD30D9597AFBB2192C--

