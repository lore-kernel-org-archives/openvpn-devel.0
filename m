Date: Mon, 14 Sep 2020 15:55:22 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200914135522.GX75094@...1296...>
References: <20191127134258.9162-1-l@...2534...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="vZg1K/LA5SDz0xp4"
Content-Disposition: inline
In-Reply-To: <20191127134258.9162-1-l@...2534...>
Subject: Re: [Openvpn-devel] [PATCH] Fix IPv6 configuration on Windows using
 netsh
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Laurent Fasnacht <l@...2534...>
Cc: openvpn-devel@lists.sourceforge.net

--vZg1K/LA5SDz0xp4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 27, 2019 at 01:43:38PM +0000, Laurent Fasnacht wrote:
> Apparently, `netsh interface ipv6 set address ...` defaults to using
> a subnet of /64, and therefore adds an onlink route of that size.
>=20
> When using a tun tunnel, the tap adapter only replies to neighbor
> discovery packets for fe80::8. This leads to the unfortunate situation
> where all the hosts in the /64 are not reachable.
>=20
> This patch fixes that situation by specifying a /128 netmask, as the real
> route is added afterwards, via the gateway.

So, coming back to this.

I tried to reproduce this in the context of=20

  https://community.openvpn.net/openvpn/ticket/1054

and actually couldn't.

I tested on Win10, and both on tun and tap mode, the existing code
always configured a "/128" on-link (and then added the /64 route to
what it thought was the right gateway - fe80::8 for tun, its own
address for tap).


I will need to touch the code now anyway, as the behaviour for tap is
*wrong* (for tap, it really needs to have a /64 on-link, and do ND=20
inside the network) - but if I could reproduce the issue you saw=20
for tun, it would make my life easier :-)

Arne: in "dev tun" mode on windows, we can only reach a single gateway
IP (fe80::8) which is the "spoof ND replies!" thing in the tun/tap driver
- everything else only works if sent via fe80::8 -> strip ethernet header
-> send as "tun" packets.  So, /128 is correct for tun.

gert


--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--vZg1K/LA5SDz0xp4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfX3ZJAAoJEB2Cnv7KVigSgnwL/1UG46s9dH0/2vVuYIYhTIhG
4glxXi7T8Zy/AkbMXuq0GiLDf47J3cIyDFEwqS91oeH2XtwJqeuvUY9DXKKi3MIr
9hJUAVrtvcQBq7JuRA1dgFOiJbK0kNNuUH8uLdrPk4AsZ2b0qHsDrCJF/pZDncEu
2owKlCSBvZC1aZZEJhPsZRnJuXbaCKhkf8p9zUaLRZtfkdSaxXIAvuNLNXf4qHHR
31V8JD9ohmAteQs83i0xcQS5LRZBA8ARZ1934rm1KvDYeCFgcCe2ikK+/pF9MkeV
kY2KI1Ow1lfaVnVFymxlalulvreC0moCUiociJYXSRubXxqCGYhOqJmAT3Yx4kBD
qa1Eh4x3+DJTd8IVUFRXVlR3trZPG4r5FxD+wPyz6JWKiZQISXuh14aydUTyGKZG
K9MyX5AeX0nLKjLnen84vs1YFnMS6xvrw7jfm/hsfAlxLRlCCN413k/rpZNZdFKy
+BKOu2KC++m1gnaW9sKSlx+itJpgPzhZ+7b4E560Hg==
=iKWq
-----END PGP SIGNATURE-----

--vZg1K/LA5SDz0xp4--

