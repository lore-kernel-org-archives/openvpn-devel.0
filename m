Date: Sun, 3 Jun 2012 12:11:27 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120603101127.GL400@...1296...>
References: <1338642223-20324-1-git-send-email-arne@...1227...>
	<1338642223-20324-7-git-send-email-arne@...1227...>
	<4FCA40E3.8000205@...1114...> <4FCA433B.4070502@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xs+9IvWevLaxKUtW"
Content-Disposition: inline
In-Reply-To: <4FCA433B.4070502@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 6/8] Allow routes to be set before
	opening tun, similar to ifconfig before opening tun
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--xs+9IvWevLaxKUtW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jun 02, 2012 at 06:45:47PM +0200, Arne Schwabe wrote:
> > returning a macro value, instead of just redefine the
> > ROUTE_ORDER_DEFAULT macro for those platforms who need ROUTE_AFTER_TUN
> > and use the ROUTE_ORDER_DEFAULT macro directly where needed?
> >
> > And for type-safety, would it be better to use an typedef enum instead?
> I just followed the IFCONFIG_AFTER_TUN/BEFORE_TUN which already is in
> place. Just using the defines is fine for me too but it should be
> consistend for both options.

I've always wondered why IFCONFIG_AFTER_TUN has been done that way, as
it seemed confusing - it sort of looks like it was done with the option
to change it at run-time later, but I don't really see where this would
make sense.  Today all unix platforms have one variant, Windows has the=20
other one, and reversing order for either isn't going to work...

So I would opt for "no function for ROUTE_ORDER_DEFAULT", and put=20
cleaning up the IFCONFIG_AFTER_TUN stuff on someones TODO list :-) - but
we could check that one with James...

(JFTR, OpenBSD used to have IFCONFIG_BEFORE_TUN as the single exception
besides Windows - but that looked like "the one who did the port not=20
understanding how tun(4) works on OpenBSD" - I changed it to=20
IFCONFIG_AFTER_TUN and that cleaned up quite a bit of special cases=20
in the code, and it works better than ever before :-) )


What I'm also not really happy in the current implementation of both
options is that all order variants get compiled-in, instead of just
having what the platform in question needs.  But that's more intrustive
surgery...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--xs+9IvWevLaxKUtW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBT8s4T6kuBuNlUUl1AQJDYwP+Irp5GL9ZEvXQT4wptwsnE1qLgP8KTgMy
L58SX8s0QACAwe7ZOVqKsesM5732CoqLXdSLL2CycKlTje0MrdrdrL8tHeTJCXG3
MaEPm73KrjefHx8p5nJsdYNGqCmsddlEqSmyqi0nRrozC/SkUNUL4Q9e8TYm6ya6
a3jPIvJTA2M=
=Vn3V
-----END PGP SIGNATURE-----

--xs+9IvWevLaxKUtW--

