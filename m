Date: Sun, 4 Dec 2016 21:54:53 +0800
From: Antonio Quartulli <a@...2181...>
Message-ID: <20161204135453.GG32580@...2182...>
References: <20161204045143.GF32580@...2182...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline
In-Reply-To: <20161204045143.GF32580@...2182...>
Subject: Re: [Openvpn-devel] #636: IPv6 subnets support in PF component
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--WhfpMioaduB5tiZL
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dear all,

by following the suggestion received by cron2 on IRC, I decided to
whitelist all those ICMPv6 packet sub-types that are strictly
required to let an IPv6 host join a network.

Such packets are described in RFC4890[0], sec. 4.4.1 (thanks cron2 for
the pointer!), in the "Address Configuration and Router Selection messages"
list.

PF by default will always allow ICMPv6 packets having one of those
packet types.


** TESTERS WANTED **

A working implementation of this change can be found on github at [1].
This branch is based on the current master (+ a style change) and
is ready for testing.

So far I managed to test this feature only on Linux, but it would
be nice if anybody with a Windows server might test it as well.
(I could only compile for Windows, but nothing more)

The syntax of the PF v6 subnets is just "as expected". You can mix
IPv6 subnets in the same block as IPv4 ones, like:

[SUBNETS DROP]
+10.0.0.0/24
+2001:ffff:aaaa::/48

Now you can also list a host without writing the netmask, i.e:

[SUBNETS ACCEPT]
-8.8.8.8
-2001:dead:cafe::12

PF will assume that /32 or /128 is the wanted netmask.


Any feedback is welcome!

Cheers,

[0] https://www.ietf.org/rfc/rfc4890.txt
[1] https://github.com/ordex/openvpn/tree/ipv6pf

On Sun, Dec 04, 2016 at 12:51:43PM +0800, Antonio Quartulli wrote:
> Dear all,
>=20
> as a "learning exercise" I started working on #636 over the weekend in the
> attempt of digging deeper into the openvpn codebase.
>=20
> As of now I managed to make the v6 filtering work.
> Most of the changes are in pf.c (but also mroute.c and other files requir=
ed
> their small dose of tweaking).
>=20
> Now that v6 PF is working as expected, I stepped over a more "conceptual"
> problem. Here it is:
>=20
> in IPv4 we have ARP that takes care of providing the underlying
> information to make IP work.
>=20
> In IPv6, ARP (and other basic functionalities) has been substituted by a =
set of
> multicast protocols, operating on IPv6 itself.
>=20
> This means that, if we keep PF unaware of these protocols, the user is su=
pposed
> to whitelist all those IPv6 subnets that are needed to make NDP and other
> protocols work.
>=20
> I haven't spent time digging into NDP yet, but an easy way to make everyt=
hing
> work is to always allow "ff00::/8". This way NDP and other protocols will=
 work
> just fine and then other rules can be used to accept/drop other traffic.
>=20
> What should the default behaviour of PF be, in your opinion?
>=20
> IMHO, it should allow basic functionalities like NDP by default, but shou=
ld not
> permit any other multicast traffic, unless explicitly allowed by the user.
>=20
> If you guys also think this is the way to go, does anybody know how to
> translate this "make NDP work" into a whitelist rule? "+ff00::/8" is too =
broad.
>=20
>=20
> Cheers,
>=20
> --=20
> Antonio Quartulli



> -------------------------------------------------------------------------=
-----
> Check out the vibrant tech community on one of the world's most=20
> engaging tech sites, SlashDot.org! http://sdm.link/slashdot

> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--=20
Antonio Quartulli

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYRCApAAoJEJ6F1zG2JyOscEkP/AtUfVD5UffPDX0wdJ8sKJMU
qKl0+wn5VOv+yEtMLQK7BTuroDBnvODlNdTZdL9Q7yiDf4+iF9UvInOCEXXiF4Wh
r8u7Xky32JFUIUzNbiGk5BduCWzziUBuKahZAoWBXTGFu/naPfRR0KomJppy9xAm
EIkj5PIUNdk4k50L6C3aDPipkY+5Iex0OpaTd6UsoAT82z96aTohWu3zN1Er15Bk
ELBhEUITtdnoS5tkMQCAPf8VP40xS9md+dD5GcXHbYLf45XZ3ghD7QT8md+lcaHZ
Y//+Utseg7gOwD2pVe2083zp3P7yZGTDfoHKbmwbxeTgYxAyIqzapQNLhxslMwtX
rC+kKmKIMzgURMjB7g3brtrHw1ljJPNfZU6wL/UemSzjMuvEqUr/s/vsUIIUbgMg
xLjfBa6meVt5U1unBqTr+Wz5RVsNumT6scmgiMXy7Eu9dyAgRkpsFPlsktMcSfqW
ttc0M8hAyLI53mA/bai5Yg+gNIrKLIHelD++pGGqcZO7mjZbssRDGLSn8b7gbAcc
z1P1HOpKmjxihP/I4iMCSfq4r+m2UDBzGyJWuH8/DHde2TgSD8vnk+9o3Wkr/uUC
S8HImaZ98nAtdK7L7Ciyjj3NKrX5V35+/0k2BVOLz9ieDjiGZSNTUZkJvBMWu7Zz
+8VaWAeSPQXHZdX0K4Tb
=2M9B
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--

