Date: Sat, 25 May 2013 13:58:19 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130525115819.GS20843@...1296...>
References: <20130524215902.GM5874@...1818...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TOkWJigZa0YodlBE"
Content-Disposition: inline
In-Reply-To: <20130524215902.GM5874@...1818...>
Subject: Re: [Openvpn-devel] [PATCH] openvpn ipv6 pool env variables
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuel Thibault <samuel.thibault@...1817...>, openvpn-devel@lists.sourceforge.net

--TOkWJigZa0YodlBE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, May 24, 2013 at 11:59:03PM +0200, Samuel Thibault wrote:
> Hello,
>=20
> To make it short: yes, the ipv6 pool environment variables are useful,
> for user-defined scripts to be run at connection for instance to
> propagate routes, do accounting, etc.  The patch below adds them.

You keep claiming that "yes it's useful".  The lack of feedback on the
list is partly due to the "To make it short" part of your mail...

I'm a bit reluctant to add more code until I can see a clear use case
which can't be answered by the plethora of existing environment variables.

Specifically, "ifconfig_ipv6_local" and "ifconfig_ipv6_netbits" already exi=
st,
and the pool will never produce any other netbit length, nor will the
server ever reconfigure it's ipv6_local address in response to whatever
is pushed to clients.  So the only thing that I couldn't see right away
in the environment is "what IPv6 address did the remote receive?" and
that one *is* available as parameter to the "learn-address" script already
today...

(It brings up an interesting question, though.  Should we issue a warning
if an "ifconfig-ipv6-push" is used that uses a different network or=20
netbits length than the ipv6 transfer net configured on the server?  What
do we expect to happen if this is configured?)


Looking at the code:

> +      if (tunnel_type =3D=3D DEV_TYPE_TAP || (tunnel_type =3D=3D DEV_TYP=
E_TUN && tunnel_topology =3D=3D TOP_SUBNET))
> +	{
> +	  setenv_int (mi->context.c2.es,
> +			    "ifconfig_ipv6_pool_netbits",
> +			    mi->context.c2.push_ifconfig_ipv6_netbits);
> +	}
> +      else if (tunnel_type =3D=3D DEV_TYPE_TUN)
> +	{
> +	  setenv_in6_addr_t (mi->context.c2.es,
> +			    "ifconfig_ipv6_pool_local_ip",
> +			    &mi->context.c2.push_ifconfig_ipv6_remote,
> +			    SA_SET_IF_NONZERO);
> +	}

This whole bit is overly complicated.  Unlike IPv4, there is no "this
could be a remote or a netmask" distinction, and both netbits and=20
context.c2.push_ifconfig_ipv6_remote are always defined, no matter=20
what sort of tunnel type or topology.  So if you wanted to set these
variables at all, you could do unconditionally - but then, I can't see
any added value to "ifconfig_ipv6_netbits" and "ifconfig_ipv6_local", as
said before...

Blindly copying the way something is done for IPv4 doesn't make it=20
"right" for IPv6.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--TOkWJigZa0YodlBE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUaCnW6kuBuNlUUl1AQJ1zAP9HnrhyRPLlJXfwMTlD4WGbwaaMIifRBtQ
g1I+iC/QEywSXxA2DSXrRcWz+6VhO+T8jM+Ume7qu/8peweEFKJyATAq6zIRRngi
MDHfOrZgiXAdHlOItkTR8MGv4Z7FSj0vDu49+LdFsjqsILQmGgI7rSZvzJIZ0gFo
Sj/bJ9O3cqM=
=jnri
-----END PGP SIGNATURE-----

--TOkWJigZa0YodlBE--

