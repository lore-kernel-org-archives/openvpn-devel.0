Date: Sun, 10 Jun 2012 17:45:14 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120610154514.GB1059@...1296...>
References: <1314694036-3749-1-git-send-email-s@...1497...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HLsZ5Z1opAQvdr2J"
Content-Disposition: inline
In-Reply-To: <1314694036-3749-1-git-send-email-s@...1497...>
Subject: Re: [Openvpn-devel] [PATCH] Add IPv6 gateway support for Linux,
	FreeBSD, and Darwin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Scott Zeid <s@...1497...>
Cc: openvpn-devel@lists.sourceforge.net

--HLsZ5Z1opAQvdr2J
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

sorry for never replying to your mail.  It was on my TODO list, and
David regularily reminded me that it was there, but well...

On Tue, Aug 30, 2011 at 03:47:16AM -0500, Scott Zeid wrote:
> This patch adds IPv6 gateway configuration for Linux, FreeBSD, and Darwin.
> Apparently this functionality already exists on Win32, Solaris, OpenBSD, =
and
> NetBSD.
>=20
> This patch does not implement the --route-ipv6-gateway option; it only
> implements adding the gateway in add_route_ipv6().
>=20
> I am only able to test this patch on Linux; the FreeBSD and Darwin code w=
as
> guessed by reading the respective route(8) man pages.

I have now solved the underlying issue in a slightly different way - only
add the gateway spec if needed (aka: tap interface and not directly connect=
ed
network).  Patch has been sent to the just just now.
=20
The BSD code didn't work the way you had it, because their route tool
is a bit weird - "-iface dev" must not be combined with a gateway spec=20
- if you do that, you end up with completely weird entries in the routing
table that do not work at all.  So the code now does either-or, depending
on interface type.

> (Thoughts:  Some platforms do not specify the TUN/TAP interface in the ro=
ute
> commands.  Is this intentional?)

This is more "lamentable" than intentional - it's because I could not find
a way to actually specify the TUN interface for the route, or because the
documented way did not work.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--HLsZ5Z1opAQvdr2J
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBT9TBCqkuBuNlUUl1AQJDIwQAm4GL5F6DmfBahpLwdrMcn8pG15IVtids
6dcn7K90u3WBSk0a+y7IZEqj+zhLdbn1CELoNLgfF2kw1Ui6NtmYymTFhBUg0+6Q
i9vJpkZdyhwHDv28krKqCcPSc0AB0+9l5e8P9x6m5vDQccixVXMbl8un/QZqaBNi
VOpRbqgiDmY=
=yJis
-----END PGP SIGNATURE-----

--HLsZ5Z1opAQvdr2J--

