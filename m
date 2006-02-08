Message-ID: <43EA8D94.8010208@...411...>
From: Giancarlo Razzolini <linux-fan@...411...>
Reply-To: linux-fan@...411...
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Feature request : connect to non-SSL HTTP proxy
References: <loom.20060208T222649-976@...171...>
In-Reply-To: <loom.20060208T222649-976@...171...>
Content-Type: multipart/signed; micalg=pgp-ripemd160;
 protocol="application/pgp-signature";
 boundary="------------enig42B8DEA4DB400E7049E64FCD"
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Feb  8 16:36:23 2006
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig42B8DEA4DB400E7049E64FCD
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Philippe Lemesle wrote:
> Hello, all.
>=20
> At work, the admins are so paranoid that the policy is to block all inter=
net=20
> access to ensure security.=20
> The only way to go to the Internet is by the way of an HTTP-proxy which o=
ffers=20
> SSL functionnality.
> The admins are aware the some employees use VPN over SSL. In fact, they a=
re=20
> currently studying the option of cutting down SSL functionnality of the H=
TTP-
> proxy.
> So it's possible that in the near future I won't be able to use OpenVPN a=
nymore.
>=20
> I've studied alternative solutions and found a software called HTTHost (c=
oupled=20
> with HTTPort for the client part).=20
> HTTHost is able to pass plain non-SSL HTTP-proxy via an option called "re=
mote=20
> host".
> But it's less flexible than OpenVPN because it only tunnels TCP connectio=
ns and=20
> doesn't offer true VPN functionnality.
>=20
> So, it would be really nice if someone could add a functionality to the -=
-http-
> proxy command so that we can connect to remote host through an non-SSL HT=
TP=20
> proxy.
>=20

AFAIK, the so called ssl functionality you are talking about uses the
HTTP CONNECT method. Unless your network admin doesn't want to allow
your users to access any https site, it should be enabled in the network
proxy. Normally it only is enabled on TCP port 443, which is luckily
open in almost any ISP in the world. So i use it to make an OpenVPN
connection as normal. Using the method described in the HTTPort page is
horrible because your latency increases dramatically and you need a "man
in the middle" doing the dirty job. I belive that, it would be
impossible to implement this feature in OpenVPN, without putting aside
the whole security model it is built around (SSL/TLS, they require a
"real" TCP or UDP connection to work). And even if it is implemented, in
a similar way that HTTPort does, it would loose almost of it's VPN
functionality. So i don't believe it would or should be implemented. I
can break through firewalls using many different ways, but i almost
never saw only one proxy that had the method CONNECT disabled. I believe
that if you are in a very restrict network, and it is in your enterprise
 policy that you shouldn't do this kind of connection, then you are
risking your job, even if the traffic is encrypted. I only do this kind
of break through in my university, and even there, i managed to ask if
it was a break in the network usage policy.

My 6 cents,

--=20
Giancarlo Razzolini
Linux User 172199
Moleque Sem Conteudo Numero #002
Slackware Current
Snike Tecnologia em Inform=E1tica
4386 2A6F FFD4 4D5F 5842  6EA0 7ABE BBAB 9C0E 6B85


--------------enig42B8DEA4DB400E7049E64FCD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFD6o2Zer67q5wOa4URAz9BAKCkymf1wh6dXAd+Vxv6rQTRi1ArsACfQHbk
1Cq03lZGoZDoExDx8PrFwg0=
=GyhF
-----END PGP SIGNATURE-----

--------------enig42B8DEA4DB400E7049E64FCD--

