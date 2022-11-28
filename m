Date: Mon, 28 Nov 2022 16:55:07 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y4TZ20w4YFI4e16k@...1296...>
References: <20221012133457.1927871-1-arne@...1227...>
 <20221012133457.1927871-3-arne@...1227...>
 <Y4S3B/u3W8MO5Wbc@...1296...> <Y4S5HE0L3ZvtqsTz@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/jIu29tLyjPcn+Bn"
Content-Disposition: inline
In-Reply-To: <Y4S5HE0L3ZvtqsTz@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] Call dco_p2p_add_new_peer again if
 the peer id changes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--/jIu29tLyjPcn+Bn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 28, 2022 at 02:35:24PM +0100, Gert Doering wrote:
> Now testing the actual patch.

Doesn't work...

without 3/3, I have the

  ubuntu2004 kernel: [22034799.495703] ovpn_udp_encap_recv: received data f=
rom unknown peer (id: 1114473)

on reconnect, but at least TLS handshake succeeds.

*With* 3/3, I am back to "after half the handshake, UDP packets are
sent to the *old* peer IP+port"

2022-11-28 16:51:27 us=3D427942 Control Channel: TLSv1.3, cipher TLSv1.3 TL=
S_AES_256_GCM_SHA384, peer certificate: 2048 bit RSA, signature: RSA-SHA256
2022-11-28 16:54:06 us=3D24986 TLS: new session incoming connection from [A=
F_INET6]::ffff:194.97.140.5:43940
2022-11-28 16:54:06 us=3D26336 read UDPv6 [ECONNREFUSED]: Connection refuse=
d (fd=3D4,code=3D111)
2022-11-28 16:54:08 us=3D115117 read UDPv6 [ECONNREFUSED]: Connection refus=
ed (fd=3D4,code=3D111)
2022-11-28 16:54:08 us=3D379075 read UDPv6 [ECONNREFUSED]: Connection refus=
ed (fd=3D4,code=3D111)

and in tcpdump...

client -> server

16:54:37.726666 IP 194.97.140.5.43940 > 195.30.8.84.51201: UDP, length 14

server -> client

16:54:37.728030 IP6 2001:608:1:995a:250:56ff:febb:2084.51201 > 2001:608:0:8=
14::fb00:14.14151: UDP, length 22
16:54:37.728081 IP6 2001:608:0:814::fb00:14 > 2001:608:1:995a:250:56ff:febb=
:2084: ICMP6, destination unreachable, unreachable port, 2001:608:0:814::fb=
00:14 udp port 14151, length 78


meh.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--/jIu29tLyjPcn+Bn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjhNnbAAoJEB2Cnv7KVigS42oL/1agBtNBS6G4PG4IPH1alRkn
vHE5NPqwkJZQxVXbVQ0MOMYQWHBnY5dgTU6QlKFnSTf+G3eOEWIH72g3o3A5N/XR
6FxRzKbKe4x6SVjzG+6B/jQFtCuzLPs+sgY2PdqKxmsWuXviXDmD9EEYva/PpCYb
oBZCfbp+yWV4QkPLln+QKUxvtN+Mq+mSdfPz1uiVVfCpV3P+3fApHMhGepKBR//T
CJEjULWgkr9PxuT3nQXkUlZwRXx+oiHFuk4qJ2/77buskUk11l+NpmiVhKPI5uhc
Ea9I5VLFJZiK2qIhQkQ7Q2eRsLqGTeOTxQUarbxSEJC42bf2kM85wI1QwW+vJCFl
GUGe8iSCe0oud+cRk72B3ew2ratUjbdzewsUvs4yohwyprjrwsU267/lLc1cpKp/
PDw1+qavVBI88qr3O8pt19g1DnB/R7TP+D3P4bMeIIFU8+68Ghy/obFM8T4E/+uw
njqvl+/6kZpqwYXp6wguoCA+ds0wBVFcOLmDfUNQhA==
=SG+x
-----END PGP SIGNATURE-----

--/jIu29tLyjPcn+Bn--

