Date: Fri, 10 Jun 2011 12:11:41 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110610101141.GD8496@...1296...>
References: <4DF0FEC8.4040105@...1465...> <20110609174852.GZ8496@...1296...>
	<4DF1E1F8.6080701@...1465...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Z7anUBlSj09l+zDK"
Content-Disposition: inline
In-Reply-To: <4DF1E1F8.6080701@...1465...>
Subject: Re: [Openvpn-devel] Why no ipv6 support for tap?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Sergey Matveychuk <sem@...1465...>
Cc: openvpn-devel@lists.sourceforge.net

--Z7anUBlSj09l+zDK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 10, 2011 at 01:20:56PM +0400, Sergey Matveychuk wrote:
> >On Thu, Jun 09, 2011 at 09:11:36PM +0400, Sergey Matveychuk wrote:
> >>It's really weird that I can't set up IPv6 address for tap interface.
> >
> >You can, but you need the "top of the tree" code, not 2.2 release.
> Of course, I use it.
>=20
> >>server-ipv6 turns a tun mode,
> >
> >Actually, it doesn't.  server-ipv6 will use whatever is configured as
> >"device" (device tun / device tap).
>=20
> From a man page:
> --server-ipv6 ipv6addr/bits
>        convenience-function to enable a number of IPv6 related  options
>        at  once,  namely  --ifconfig-ipv6, --ifconfig-ipv6-pool, --tun-
>        ipv6 and --push tun-ipv6 Is only accepted if  ``--mode  server''
>        or ``--server'' is set.
>=20
> It turns --tun-ipv6 and --push tun-ipv6. It's not exactly I want.=20

"tun-ipv6" does not turn the device to "tun" mode.  It just turns on IPv6
on whatever device you are using.

> And it require --server option, I can't understand why.

Because there's assumptions in the code that will not be true if=20
--server is not set.  (--server itself is just a helper macro).

If you don't want --server and --server-ipv6, just set all the options
yourself.

If you want the server to manage the IPv6 stuff for you, that is, run
the "ifconfig" commands, push addresses to the client, etc., you MUST
enable "--tun-ipv6".  If you want to configure everything manually,
tou can leave all that off.

> >>ifconfig-ipv6 suppose p2p interface and
> >
> >No.  It will work in p2p and p2pm mode.
>=20
> --ifconfig-ipv6 ipv6addr/bits ipv6remote
>        configure IPv6 address ipv6addr/bits on the ``tun'' device.  The
>        second parameter is used as route target for --route-ipv6 if  no
>        gateway is specified.
>=20
> I have no idea what is ipv6remote for tap interface.=20

As I said, pushing routes on TAP is not working yet.  But if it were workin=
g,
that would be the gateway to be used (in a bridged setup, the gateway
address does not have to be the OpenVPN server, it could be something
else in the server side LAN).

> Moreover it=20
> "configure IPv6 address ipv6addr/bits on the *``tun'' device*".

Don't get so hung up on individual words in the docs.  When I implemented
this, we only had "tun".  Now we have some support for "tap", so I need
to update the docs (thanks for pointing this out, put on my TODO).


> >>even 'push route-ipv6' misticaly discards because of some flag
> >>(tt->ipv6) has been unset.
> >
> >push route-ipv6 will fail if you have no ifconfig-ipv6 on the interface
> >(because then it would not work anyway).
> >
> >First get the ifconfig right, then worry about the routes.
>=20
> I see not any IPv6 address on tap interface after --ifconfig-ipv6. Here=20
> is my config line:
> ifconfig-ipv6 xxx:yyy:z:21f::/64 xxx:yyy:z:21f::2

You NEED to set tun-ipv6.  Otherwise all the rest will be ignored.

[..]
> IPv6 payload passed through tap interface with any version of openvpn.=20

I'm aware of that :-)

> I'm telling about working with IPv6 addresses.=20

It should do that nicely if you set --tun-ipv6.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Z7anUBlSj09l+zDK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTfHt3akuBuNlUUl1AQJlngP+NtvjR8DroVLrKrEOFU93oenUH5mCY5E/
cCV3gABnOSmhAkse66Q2o2IQpJcM8xoO59czerCzy4lxvPqqt6Y89WvC+m2UNqqQ
ddFMXJHUcZk9Y62ptjsYSuYSpOKheyFWyhl9FccVv0sGIqkHR7+LwgZR1cWo5D2u
6VjnFoyZH7Y=
=aiBS
-----END PGP SIGNATURE-----

--Z7anUBlSj09l+zDK--

