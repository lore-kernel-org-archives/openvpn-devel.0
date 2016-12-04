Date: Sun, 4 Dec 2016 12:51:43 +0800
From: Antonio Quartulli <a@...2181...>
Message-ID: <20161204045143.GF32580@...2182...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
Subject: [Openvpn-devel] #636: IPv6 subnets support in PF component
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dear all,

as a "learning exercise" I started working on #636 over the weekend in the
attempt of digging deeper into the openvpn codebase.

As of now I managed to make the v6 filtering work.
Most of the changes are in pf.c (but also mroute.c and other files required
their small dose of tweaking).

Now that v6 PF is working as expected, I stepped over a more "conceptual"
problem. Here it is:

in IPv4 we have ARP that takes care of providing the underlying
information to make IP work.

In IPv6, ARP (and other basic functionalities) has been substituted by a se=
t of
multicast protocols, operating on IPv6 itself.

This means that, if we keep PF unaware of these protocols, the user is supp=
osed
to whitelist all those IPv6 subnets that are needed to make NDP and other
protocols work.

I haven't spent time digging into NDP yet, but an easy way to make everythi=
ng
work is to always allow "ff00::/8". This way NDP and other protocols will w=
ork
just fine and then other rules can be used to accept/drop other traffic.

What should the default behaviour of PF be, in your opinion?

IMHO, it should allow basic functionalities like NDP by default, but should=
 not
permit any other multicast traffic, unless explicitly allowed by the user.

If you guys also think this is the way to go, does anybody know how to
translate this "make NDP work" into a whitelist rule? "+ff00::/8" is too br=
oad.


Cheers,

--=20
Antonio Quartulli

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYQ6DcAAoJEJ6F1zG2JyOs0eoP/0rJAaxAjaCh7PQAsuIDSJ3j
kZFxOEPD/XHjRh/q7sbqejPqbaKP+Xmu3hGqISnlwnzILFWsiN1CJhpShyNSsiua
nk5lBZ0Ri0knrQyAMvVkDNoZOQM/KWQrv3D+02AYrdX3/6+qJ2t0L8KQD5MH8dTh
PKc4/dO3npJ5Pe0wW0H8F1HicUiOe0qk8FrQ2YvQtF9FA12jOTXDrsCpjDs73DbK
SFeRr/eIysAxC1HmxUf3y/8me1SR9M8Tx3QvPn7kXGtXUWzSoP+5WrCx7wmaT1fI
OY93tMOWBfN8rywTi0pcQrWDwvS5daZRyCBz+j3v3Ruq0BG16rSDoeHHycMoEb3Q
f9uA4zAitnsXQFYMOfIGKNJrzEEtKXStupdhfryf6U/InXpfkl5wQwNHFTZidCYw
IEdRlW48T58Kh53A2OW+oGzEI2Tj6jLiGejJwk5FkgPYIskSPxhYgMddbAznh0YY
kMJ9XVn2pmJ8vZDhLxa5yq3PexhDez4PkgxXAhBZs3q8ihaOCoZ7YH8BFP2ddjFQ
CfRMDffA7YvpuesXOK15XKktDFd6c7uVjBpgsCKuYRavmF5uIpsqCTMFe9fAu5l7
cF5K6SF+fqmsXreohK0DvEErsSnY3h2IAEhCtzjrwmuvF0rhp/1/kCZ2XpcwfD6r
KSthknQz3xdWf4HfC5Ji
=qWFh
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--

