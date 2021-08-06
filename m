Date: Fri, 6 Aug 2021 11:20:08 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YQz+yKSrysYMoxwS@...1296...>
References: <cc7faf4a-5c6e-fe03-01c3-8446faddf4a9@...2318...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="pu7fZseA411u161s"
Content-Disposition: inline
In-Reply-To: <cc7faf4a-5c6e-fe03-01c3-8446faddf4a9@...2318...>
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
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--pu7fZseA411u161s
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Aug 06, 2021 at 10:38:36AM +0200, Fran=E7ois Kooman wrote:
> However, it does not explain how it exactly would rewrite --server-ipv6=20
> fd42::/112 to those three statements.
>=20
> --ifconfig-ipv6 fd42::1/112 <????>
> --ifconfig-ipv6-pool fd42::1000/112
> --push "tun-ipv6"

This should work.  And you can leave off the "push" bit :-)

> What would the second parameter to --ifconfig-ipv6 be in this case?=20

A random IP in that subnet, like "fd42::1/112 fd42::2" - this is a
somewhat unlucky artefact of the implementation of --ifconfig-ipv6,
which insists on having a "remote" even if that is not used in=20
many cases.

It is required in tap mode, to have "something to point route-ipv6
routes to" - default setting for --route-gateway-ipv6 - but since tun
does not use next-hop IP addresses anyway, this is just stupid code.

> 2021-08-06 10:21:30 us=3D717994   ifconfig_ipv6_netbits =3D 112
> 2021-08-06 10:21:30 us=3D718149   ifconfig_ipv6_remote =3D 'fd42::2'

That should work :-)

[..]
> Would this mean the --server-ivp6 fd42::/112 expands to this?
>=20
> OpenVPN 2.4:
>=20
> --ifconfig-ipv6 fd42::1/112 fd42::2
> --ifconfig-ipv6-pool fd42::1000/112
> --push "tun-ipv6"
>=20
> OpenVPN 2.5:
>=20
> --ifconfig-ipv6 fd42::1/112 fd42::2
> --ifconfig-ipv6-pool fd42::2/112
> --push "tun-ipv6"

Without having tested it, I would agree that this is what it is.

(The reason it was changed from :1000 to ::2 is "small pool size" -=20
if you have only a /112 or smaller, starting from :1000 reduces the pool=20
size significantly.  If you use a /111 or bigger, it will actually stick
to the old behaviour - see helper.c, around line 200)


> it does not seem to work (no traffic over VPN), and the output of the log:

The log snippet is too short to give meaningful advice.  Please show=20
the "ifconfig" or "ip address" statements, and what (if anything) is
pushed to clients.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--pu7fZseA411u161s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhDP7IAAoJEB2Cnv7KVigSCRAL/0NBoH5uKbktXQJ3ytODMcIE
kB8tMFC8JYYy49Q+HMDGEHidAmfTEUz9cnGP4DLtp+GkWAAbuOhDR8LhHp/QaUU4
+tn1K3lxU9GoYVE0CTkgS2UkV7pnqM9mQyvq4KQD/IaWhPi8eJcFxVrePZNvhT0b
BdAhufJ/tSBJj0CbOejuRE+1LW9fwxthnL/PPhODDNBPrAHURZDz+TL/ba+6szGs
44V4pbGLOKEX2LSNM/3uWpydk5+dHXmBorf5gRx+8V69ABLtXik4KvDt0A29sIaB
X43bcOoCiJtK8HCMBwSfqwT0Bw/7brOZT6MlHz05v12af5OeZ6B/t5wZzY5AuGRH
voWpWyKvI2mvd1jOV2ZS1W6YI61XcOYRV/SKqByIqyGC1U19jQJNZq/tb5pVMaW0
8m6AogcJQEF/EekeOO24OH2Mg15LL/vbNfnO1w/5kqiNdIKR07i+glH++cg9DpQ/
xruvdFerbTrR5ms7RkbUYtZrYbvIG8LHMRk+kqpsEw==
=ssdu
-----END PGP SIGNATURE-----

--pu7fZseA411u161s--

