Message-ID: <485E5E7D.2030201@...1085...>
Date: Sun, 22 Jun 2008 09:15:25 -0500
From: Josh Cepek <josh.cepek@...1085...>
MIME-Version: 1.0
References: <44e5dffd0806200615r65f02642hc7fd04d35d2b2a89@...278...>
In-Reply-To: <44e5dffd0806200615r65f02642hc7fd04d35d2b2a89@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigCACE9FFAE0077FEA99CCF8EC"
Subject: Re: [Openvpn-devel] Subnet size limit hardcoded - why?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: R Mullen <rm@...1108...>, openvpn-devel@lists.sourceforge.net
Cc: skaelin@...1109...

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigCACE9FFAE0077FEA99CCF8EC
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable

R Mullen wrote:
> Hello,
>
> There's a hardcoded size limit in pool.h when assigning the netmask to
> your VPN. It only allows you to have /16 networks or smaller, and I
> think this should be increased to /8 so that you can use the whole
> 10.0.0.0/8 subnet as described by RFC 1918 concerning dedicated
> private subnets. Naturally, there's no reason anyone would have a
> network that size (that's a lot of hosts!)  on a VPN because it's
> completely asinine to think that your hardware could support a network
> like that running on a single daemon. However, if you are assigning
> static IP addresses per host and you have a good reason to want to put
> specific hosts on their own smaller /24 subnets, those might add up if
> you don't want more than a handful of machines on each /24 net.
>=20=20=20

What you describe doesn't require a larger ifconfig-pool size.  Static=20
addresses assigned via ccd or client-connect scripts should never use=20
the same range from an ifconfig-pool directive because the IP may have=20
been previously assigned from the pool.  In this case you would choose a=20
range of addresses to hand out dynamically through the ifconfig-pool=20
option and set static addresses for clients that needed them.  As you=20
point out, there is no need to actually connect more than a /16 worth of=20
VPN clients, which means there's no reason to allow an IP range larger=20
than this to be used in ifconfig-pool.

This does *not* mean that you are prevented from using networks of any=20
size with your VPN or pushing large routes.  Normally you would never=20
use the entire 10/8 network solely for the VPN network, but you could if=20
you wanted to.  In this case you couldn't use the "server"=20
helper-directive since its expansion includes an ifconfig-pool directive=20
that exceeds the maximum ifconfig-pool value.  There's no logical reason=20
to increase this value within the source, so if you really want to do=20
this you should expand the "server" helper-directive yourself and set a=20
more sane ifconfig-pool value.

Even in this case, what you probably want is to allocate a fairly small=20
subnet within the 10/8 network for your VPN clients and push routes for=20
the remainder of the network.  You can certainly push networks of any=20
size you want, including the 10/8 network.

> I acknowledge the fact that a large network like this is not actually
> possible in implementation, but I'm not aware of a good reason why
> this hardcoded limit is in place. I've attached a patch created
> against version 2.1_rc7, but it should also apply against all versions
> in subversion as of today. If  someone knows why this hardcoded limit
> is in place, I'd like to know if it's unsafe to run OpenVPN with my
> patch applied.
>
> Thanks, and great product!

--=20
Josh



--------------enigCACE9FFAE0077FEA99CCF8EC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkheXoIACgkQHSSgJy5aUSePLQCfSMF4QzQjweKG8+T1ibf6uGS2
7hMAn3zRY6DfxrCZe8njDVpPhFp/wAGk
=4ovT
-----END PGP SIGNATURE-----

--------------enigCACE9FFAE0077FEA99CCF8EC--


