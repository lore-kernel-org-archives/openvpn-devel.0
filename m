References: <20200821062443.69245-1-eric@...1918...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <bd154015-3f5f-6035-c4ff-fae5abc7857c@...1227...>
Date: Sat, 22 Aug 2020 11:12:21 +0200
MIME-Version: 1.0
In-Reply-To: <20200821062443.69245-1-eric@...1918...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ms9QrMxWE8Wjl0pgBV028YjawNljaNnvd"
Subject: Re: [Openvpn-devel] [PATCH] Adds client-auth-pending-extra
 management functionality.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Eric Thorpe <eric@...1918...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ms9QrMxWE8Wjl0pgBV028YjawNljaNnvd
Content-Type: multipart/mixed; boundary="VRnseTvNEwTDf5QAwF40p3rCENoGYjhdD"

--VRnseTvNEwTDf5QAwF40p3rCENoGYjhdD
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 21.08.20 um 08:24 schrieb Eric Thorpe:
> This allows extra INFO_PRE mesasges to be sent to a client during an
> authentication stage. This may be required to send additional challenges,
> or allow longer messages to be sent by breaking them up and sending in pa=
rts.

Could you describe for what feature you need this? If we are extending
the protocol for some multiline AUTH_PENDING feature, we should document
how this works etc...

Arne


--VRnseTvNEwTDf5QAwF40p3rCENoGYjhdD--

--ms9QrMxWE8Wjl0pgBV028YjawNljaNnvd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl9A4XUACgkQFRhsZwKx
RFS0IQ//ak3jSnvnTJda0cSPmux7VuNJAB0hsKLc5DShgT+becZz42LZ8BMsL8no
NWZLXRyfEQGZv6j7tKLKXxCN19Ty882qZRMkvV05j7dPPfs2iCg8OLblBOvUwLI9
O32jx3vbPQV31IcO5JNpdog8nee4iWkakfkaiJKpRtV54kqx0inHC42A2ZC8aM3s
2Od3wBaDwmNaO2FU04jD4j8FctOdr7sokFKX89s+f0Dbcu4eNY5aFSozqIYAt9uH
OrvM05yKhJYDK9YcZlCKFdiTFFe1fuN+uAcTulURfk9CKkffprhfBrNc17JnIJrQ
Ag81qqoHJLW908FlbXligJVxB7xJ82MnTzreVIpwdknVjUPWNGTAfMiX5QHjn1/k
RkS4pThoGP5djGhf5lnDkaxf3YS+Mk/kTsvsSn2UtzJzQLk1EaLZfx6Br2I9gNcx
VJAaRdFX4SLjmpHnVp6kBjBJL7Aw8ThfOOoz+F0zIWoGE7s4exxpKvcaSfn6YLKk
eQrxrOqrc7jcO/OQc6VroBRvgN41GmMQsZ2V06BN4+xevN5F/arjlAmEiKz4UPee
G5HJUQEROsnR9uX7VIeI4yWku7cEAB0NDH4kH/wYf5PpVtykyp+880d5bb1yVgeT
5Ebuan+pgbesodh3z17Arf6dbtvjykb50wXa9ldKggi9lABXgE0=
=FUl1
-----END PGP SIGNATURE-----

--ms9QrMxWE8Wjl0pgBV028YjawNljaNnvd--

