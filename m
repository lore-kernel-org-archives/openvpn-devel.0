Date: Sun, 13 Sep 2015 14:42:13 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150913124213.GK34798@...1296...>
References: <1441985627-14822-1-git-send-email-gert@...1296...>
	<1441985627-14822-8-git-send-email-gert@...1296...>
	<55F53DD4.9070000@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ISA6zNVXmTIvvkD5"
Content-Disposition: inline
In-Reply-To: <55F53DD4.9070000@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 07/10] Implement '--redirect-gateway
	ipv6'
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

--ISA6zNVXmTIvvkD5
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Sep 13, 2015 at 11:11:48AM +0200, Arne Schwabe wrote:
> Am 11.09.15 um 17:33 schrieb Gert Doering:
> > Add "ipv6" and "!ipv4" sub-options to "--redirect-gateway" option.
> >=20
> > This is done in the same way as in the OpenVPN 3 code base, so
> > "--redirect-gateway ipv6" will redirect both IPv4 and IPv6 - if you
> > want v6-only, use "--redirect-gateway ipv6 !ipv4".
>=20
> Current 2.3 code will exit with an error on seeing the ipv6 keyword.

True.  This inconsistency has been there since 3 introduced the keyword...

> Reading the source code this is  equivalent to
>=20
> redirect-gateway
> route-ipv6 ::/3
> route-ipv6 2000::/4
> route-ipv6 3000::/4
> route-ipv6 fc00::/7
>=20
> which also works in 2.3. What do we offer as config advice for users?

Right now, pushing "route-ipv6 2000::/3" or the equivalent of the above.

What about adding this part of the patch set to 2.3?  It does not need
the "discover and redirect gateway for IPv6" infrastructure - as it=20
basically is just a macro anyway..

> (It is good that this works otherwise my code will break configs that
> use a remote ipv6-enabled-server)
>=20
> Also the documentation is slightly wrong.

What's wrong?

> Sidenote: What about IPv6 multicast?

Right now, our IPv6 multicast support is pretty much non-existing, both
link-local or "routed wide area".  I have not personally run into any
issues that needed IPv6 multicast support, and can't remember any open
trac tickets, so I'm not sure what we'd need...

(Our IPv4 multicast support is also fairly limited - if a packet hits
the p2mp server, it is replicated to all clients, and that's it.  No=20
IGMP, PIM, or anything more smart... for IPv4, there *is* a trac ticket,
but is classified as "wish list")

Extra Side-Note: link-local address support is also not there today.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ISA6zNVXmTIvvkD5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVfVvJKkuBuNlUUl1AQI9IgP+LfXU9Qxq7MLEymqN10EmqkBgFpR6Zn3I
I4+BNyFc1+DyBFP3fysl0eVgSihS2drk7ff94dsGP766oMZYCtC+ZX9vreH6pbOH
lTM8j6DNiIO66rg3ssiRt+wzWRHTDgUFalxXsY3kjeVd3BzqhRsOFbzCRkFXpE2B
u1n/yTGKAIk=
=tOik
-----END PGP SIGNATURE-----

--ISA6zNVXmTIvvkD5--

