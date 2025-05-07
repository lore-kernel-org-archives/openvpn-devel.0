Date: Wed, 7 May 2025 16:02:54 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <aBtoDrb9Fjflq52y@...1296...>
References: <20250507124439.28161-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="rln4JEdHVfVIfqYe"
Content-Disposition: inline
In-Reply-To: <20250507124439.28161-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH ovpn-net-next] ovpn: fix ndo_start_xmit
 return value on error
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@...515...>, sd@...2891...

--rln4JEdHVfVIfqYe
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, May 07, 2025 at 02:44:39PM +0200, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@...515...>
>=20
> ndo_start_xmit is basically expected to always return NETDEV_TX_OK.
> However, in case of error, it was currently returning NET_XMIT_DROP,
> which is not a valid netdev_tx_t return value, leading to
> misinterpretation.
>=20
> Change ndo_start_xmit to always return NETDEV_TX_OK to signal back
> to the caller that the packet was handled (even if dropped).
>=20
> Effects of this bug can be seen when sending IPv6 packets having
> no peer to forward them to:
>=20
>   $ ip netns exec ovpn-server oping -c20 fd00:abcd:220:201::1
>   PING fd00:abcd:220:201::1 (fd00:abcd:220:201::1) 56 bytes of data.00:ab=
cd:220:201 :1
>   ping_send failed: No buffer space available
>   ping_sendto: No buffer space available
>   ping_send failed: No buffer space available
>   ping_sendto: No buffer space available
>   ...
>=20
> Fixes: c2d950c4672a ("ovpn: add basic interface creation/destruction/mana=
gement routines")
> Signed-off-by: Antonio Quartulli <antonio@...515...>
> ---
>  drivers/net/ovpn/io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
> index dd8a8055d967..03728ce733a9 100644
> --- a/drivers/net/ovpn/io.c
> +++ b/drivers/net/ovpn/io.c
> @@ -408,7 +408,7 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct=
 net_device *dev)
>  	dev_dstats_tx_dropped(ovpn->dev);
>  	skb_tx_error(skb);
>  	kfree_skb_list(skb);
> -	return NET_XMIT_DROP;
> +	return NETDEV_TX_OK;
>  }

Tested, works :-) - so the previous behaviour was "oping was hanging
due to 'out of buffer space' error not being counted as 'packet sent'"
and now it's behaving as any regular network interface when there
is no ARP/IPv6 ND for that neighbour.  Explanation makes sense, too :-)

So

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

--rln4JEdHVfVIfqYe
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJoG2gOAAoJEB2Cnv7KVigSKDkL/3TthNMbQS79Qh2bm1HCioDL
A07NaSvZLKNSgjpz5rhZHAJS1gZZfG4ICaBG7CPLbHuQ2x5thNg6DW2oJFIdQ9xL
GkQQvLZ0HT6ye9u0Bd3iPAu1es1aa353Rui/GsSDcejFpfQrBaj2Un4vfnWvjedG
Ylvxlw18mol7cLIdBMDdqW7+keSi563cKXPEKUfdDopIqAFulP9MLuLLC/fM4bh7
nlTZq0ephJpHdE38ntc7Xm4pBynUyfGa1Qp1a8SF+Z29cdv7lnHP/j0VYkTgiHqo
bGMI0EOrRUq+6NHSxZfKmU0c3mvU9zz3PDrL9QoRzsV1nUq91U39HjLgUIqRSiND
mrCKs1b3wP2DJcKpcQ4lsS/EqrrabCZU6vTj5f/nYBhA3LovuJXKwJqSFPccL1s7
uJLRxv6LKrwIZJNshZTFCe/fHhHyaT5l5F0BG5SDjmZ7XIvIxsddY8JNahsXFL8i
4rdi6yI5GVy7s+ONbR5nxRSoTNRHHOCmXMKg2Rh5Rw==
=zc0o
-----END PGP SIGNATURE-----

--rln4JEdHVfVIfqYe--

