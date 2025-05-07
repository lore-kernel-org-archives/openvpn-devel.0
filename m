Date: Wed, 7 May 2025 08:44:50 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <aBsBYosdJtExivSG@...1296...>
References: <20250506210853.10585-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="65wJkWAuH9CaSrti"
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
Cc: openvpn-devel@lists.sourceforge.net, Gert Doering <gert@...1296...>, Antonio Quartulli <antonio@...515...>

--65wJkWAuH9CaSrti
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

--65wJkWAuH9CaSrti
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJoGwFiAAoJEB2Cnv7KVigSgwYMAKRuKhcGpC/7duuY81OK5zI2
9pv7GF2rsf/K2vJBlkfM189S54SrkbB4pYWbdnikZDUqh1L0JA+YaxLkgKiDu/AG
ZVu0kRvvsYpqXs4JYyMSEXoUGUPzwTSG+IYZYr3ztWr89UVXkYth8i6+VRyR0GWq
JQ07tC4yJcShr8bUEIzmD79QeCAgr9fE+7F/nTsqo2PGvmgKl5b8zc8iqv4G3MTJ
dUw+j+VjC0eS6DjZALb2LNdfO+1mUWXazx9hblnqA4KhtrOJyqp3sGRxbRT6Wyhs
4HWs3D1DTRmobHJ59DXOU964vD3UGkk0IIhq4nq4a/bIPoNQSxKnPKwxwtwHKdHF
f7nWLhubB6QKLoIxXzu1xap74TRj9ETCw88QTq3qOIB2rh8N+WcuHm+AzRALap+c
zI7xCayeOg8psZnZmhvNw7xLdfOLyqonZe+aSqFIXls3fIYkZrBj1ouigoY71p2b
oqYT1Iq7F6uSsjfAIvQrYG3l0wumaW/bxvOaXTrl/Q==
=gc3x
-----END PGP SIGNATURE-----

--65wJkWAuH9CaSrti--

