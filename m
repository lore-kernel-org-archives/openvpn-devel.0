Date: Thu, 18 Aug 2022 16:06:47 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yv5HdwmRA6b6PWmw@...1296...>
References: <20220808112738.1908633-1-gert@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="6Lm4jmLpWFcjeXO4"
Content-Disposition: inline
In-Reply-To: <20220808112738.1908633-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Ensure outer IPv6 (proto udp6) packets
 can be fragmitted on sending.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--6Lm4jmLpWFcjeXO4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Aug 08, 2022 at 01:27:38PM +0200, Gert Doering wrote:
> If the inside packet is fragmented already, Linux kernel hands us
> packets with skb->ignore_df=3D0.  Since this is applied to the encapsulat=
ed
> packet, the kernel will then refuse to fragment the resulting UDP/IPv6
> packet (for IPv4, it seems to look at the actual DF bit, which does
> not exist for IPv6).
>=20
> Always set ignore_df=3D1 in the udp6 output path.
>=20
> Fixes t_client tests with "ping -s 3000" across UDP6 tunnels.

For the sake of the archives, this made it in into the ovpn-dco repo
in slightly modified form, as=20

commit 3ba6c07ababd4d491c77f5327f8105bead6ddccc (HEAD -> master, origin/mas=
ter, origin/HEAD)
Author: Gert Doering <gert@...1296...>
Date:   Mon Aug 8 13:27:38 2022 +0200

    ovpn-dco: ensure outer IPv6 (proto udp6) packets can be fragmitted on s=
ending

so, closing on patchwork.

Thanks, Antonio.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--6Lm4jmLpWFcjeXO4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi/kd3AAoJEB2Cnv7KVigS0OIL/3iADVwoU6Ph0gE312u7/1N/
OjTQOwVWN9n55u4SEA2UHcLCrzUre6+fCyGVV/jXDuS/5p0K+syQpJaoA7RO7gg+
JdU3JmAg1waRR9kC2NBTsJoGpO2IFGAd4N4a41a4jNPYeI7VDRsZAsqN1JZ15WqB
EogAi5Ek+iABpeshY9IIWRMvhpmIYZ5sMUEqlauX2tuLBtkd8sqIhgiLbgQrC+4x
3RaeTIZTsQ+slbCq4cUdbBveLomX0V9K8vZvJwJDKJl0/hQWaNpJAiUENCSyMHlD
RB4EpOFaVbX6XR/65RcB5TlI9VDJQP093dhnBScS+WFqnolpg/c1pH/yKtWfolA6
cM1Th0W2MHcaCr9J1RhvXIViQE4+rbVomV9zfc+W++ZAjQPgAFBNNDNZBDPaWXp/
1/wCx0nkikhecLmGYZ4evKUPd31FcZ1Hh6ScAmOO9NP9JmlRMaZ8WR3jlDKXjxON
+zir+Y90Bs/YODd4rSPjE9+rxZadVWLfuwm8PE3/MA==
=pQva
-----END PGP SIGNATURE-----

--6Lm4jmLpWFcjeXO4--

