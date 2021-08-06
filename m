Date: Fri, 6 Aug 2021 13:05:21 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YQ0XccVw7HVc48nK@...1296...>
References: <cc7faf4a-5c6e-fe03-01c3-8446faddf4a9@...2318...>
 <YQz+yKSrysYMoxwS@...1296...>
 <d3a27282-083e-d5fc-8866-b92610345125@...2318...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="jST5mSEYh6T5T0fJ"
Content-Disposition: inline
In-Reply-To: <d3a27282-083e-d5fc-8866-b92610345125@...2318...>
Subject: Re: [Openvpn-devel] IPv6 client IP pool configuration issues
 (2.4/2.5)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?iso-8859-1?Q?Fran=E7ois?= Kooman <fkooman@...2318...>
Cc: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--jST5mSEYh6T5T0fJ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Aug 06, 2021 at 12:50:44PM +0200, Fran=E7ois Kooman wrote:
> > On Fri, Aug 06, 2021 at 10:38:36AM +0200, Fran=E7ois Kooman wrote:
> >> However, it does not explain how it exactly would rewrite --server-ipv6
> >> fd42::/112 to those three statements.
> >>
> >> --ifconfig-ipv6 fd42::1/112 <????>
> >> --ifconfig-ipv6-pool fd42::1000/112
> >> --push "tun-ipv6"
> >=20
> > This should work.  And you can leave off the "push" bit :-)
>=20
> Ah right, that is implicit now (OpenVPN >=3D 2.4): "All tun devices on al=
l=20
> platforms are always considered to be IPv6 capable. The --tun-ipv6=20
> option is ignored (behaves like it is always on)."

Yep.  This is a very old option, which we still push in case a very old
client connects.  But it's really obsolete :-)

> > A random IP in that subnet, like "fd42::1/112 fd42::2" - this is a
> > somewhat unlucky artefact of the implementation of --ifconfig-ipv6,
> > which insists on having a "remote" even if that is not used in
> > many cases.
>=20
> Right, I'll set it to the same IP as the tun0 device itself, i.e.=20
> fd42::1 if it can be random anyway ;-)

In tun mode, that is fine.  In TAP mode, you need a gateway for routes,
but on the *server*, this needs a proper gateway address ("this client's
IPv6 address") for routes to actually work, so it won't make a big
difference there either :-)


> > Without having tested it, I would agree that this is what it is.
> Actually I did test it now properly and it does work!

Now that was easy ;-)

And - thanks for prompting me to go look and clean up that code.  I have
sent a patch to the list that removes the requirement for the second
parameter to --ifconfig-ipv6, and "it seems to still work for me".

(So, in tun mode, no visible difference, and in tap mode, it will then
refuse to install IPv6 routes unless --route-ipv6-gateway or a gateway
parameter for --route-ipv6 is set up -> works as designed)

@Antonio: on that one, I would really appreciate if you could do a
"full" review, with all the "route_ipv6_list" etc related code paths,
if I have overlooked a corner case.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--jST5mSEYh6T5T0fJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhDRdxAAoJEB2Cnv7KVigS8ygMAIeDdBA8u7j21JZsvGHyRsAK
tGPDJqBVtmtLgYjn5Ec18uWJKa85OgF6mOdZZfZxp41/Kg149utF0JjCXxRSdPQ4
4kzvZF0c0dnDJZ+cPPsP7bEirJIcT8e4tq5Fu4OFLUBR5/MbAiwA15Jbjkf9SHVj
NWOqjZSV8mZumO9/bJ8l7KYmIZPEORb7j/9iB1c5OsPwe0/OuZFRIkEhO0t9Z33l
NFCwUI1Z3KNQi4QrM63cgTzamJ7CZrS4w/eklfYiPMzbkRcCfaLuEtiR54EK4Qz5
b9673EIIaybc3LUD/1w/QHsLpcGSlEfQ60FuOalrmZ+kuSSNI11mXdTGRvl66NIb
Iv1Xr1skHsRd440TyHEbpNYtqa4xdJqvouYJW217TgJyfKzoOKnT616RBZRuQC3G
2BVSJVBuYwteeLJqlarbr+M8j5K8w7SomZVI6020NSQIMrveHNhDjuI4Ueb6tQkx
9UA85ZI+ajgh6bvn9wGpVhj0mdbutADnJGUtj7apwQ==
=j3m2
-----END PGP SIGNATURE-----

--jST5mSEYh6T5T0fJ--

