Date: Wed, 7 May 2025 08:45:47 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <aBsBm7IRQYGr8aKm@...1296...>
References: <20250506210853.10585-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="k9c+ovK4cxzQIaBQ"
Content-Disposition: inline
In-Reply-To: <20250506210853.10585-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH ovpn-net-next] ovpn: set skb->ignore_df
 = 1 before sending IPv6 packets out
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@...515...>, sd@...2891..., Gert Doering <gert@...1296...>

--k9c+ovK4cxzQIaBQ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, May 06, 2025 at 11:08:53PM +0200, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@...515...>
>=20
> IPv6 user packets (sent over the tunnel) may be larger than
> the outgoing interface MTU after encapsulation.
> When this happens ovpn should allow the kernel to fragment
> them because they are "locally generated".
>=20
> To achieve the above, we must set skb->ignore_df =3D 1
> so that ip6_fragment() can be made aware of this decision.
>=20
> Failing to do so will result in ip6_fragment() dropping
> the packet thinking it was "routed".
>=20
> Reported-by: Gert Doering <gert@...1296...>
> Signed-off-by: Antonio Quartulli <antonio@...515...>

Not sure what the protocol is on this - but I can confirm that this
fixes the problems I've observed (t_client, IPv6 UDP transport,
tun mtu 1500, ping with 3000 byte packets =3D inside *and* outside
fragmentation needed).

Details are in https://github.com/OpenVPN/ovpn-net-next/issues/3.

so:

Tested-By: Gert Doering <gert@...1296...>
Acked-By: Gert Doering <gert@...1296...>

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--k9c+ovK4cxzQIaBQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJoGwGbAAoJEB2Cnv7KVigSyFAL/i9eObfQHU60vxcpeqiC5ZuR
d7hdWSri7C2BxuyEYuy6ps1ojKbC4iTcHw6UU+Y3pq8iC9G1o5GYK8X+wckW0tCU
DdtGfETWuQ+6lphELZQfgjSl4aUP2C4HUnaUFrjTIkKqqjX4J5TivkYL1AgaxmkT
qxkhRQ0ZiHTY3gXOG5fmQMk7migK/vf8EbX4+GbCYZvcTu0WE9LaLsuJTz3loyWn
7qa9GCPfKk8de1Et82fTS4ocKoTfy506GdIFOt7MHmW0WqXIT+UTxPwpTZCpRIQe
L8+fLguB2okccqRLWiSUc/iGcVL2U7+PpEBiWBlchmUtMeTtU+BZTwsxaPlu6Ler
MBufOr55iP+hgYiWNYfS2bqWJqc4UKAqtOFBtN4p9qA4LE19swaQBdiRGvSgSkvn
APxLK7FvvNZTua4jVUu4ebybcPmiBof8Gw2C+wbCfXjAMkTo6YI6XwHjO2bSJ/0q
yEhXe0fGcrrjuLc26IXmxRIuJuOObi7loGNfLaDGmA==
=MIOU
-----END PGP SIGNATURE-----

--k9c+ovK4cxzQIaBQ--

