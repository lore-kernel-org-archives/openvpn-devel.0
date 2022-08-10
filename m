Date: Wed, 10 Aug 2022 21:12:33 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YvQDITD3EGxTw2e2@...1296...>
References: <20220810094605.123072-1-frank@...2641...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="bHUDy6DoWgl5NbkX"
Content-Disposition: inline
In-Reply-To: <20220810094605.123072-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH] dco_p2p_add_new_peer: do not warn about
 missing default gw
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

--bHUDy6DoWgl5NbkX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Aug 10, 2022 at 11:46:05AM +0200, Frank Lichtenheld wrote:
> diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
> index 4f40255e..8aa7e896 100644
> --- a/src/openvpn/dco.c
> +++ b/src/openvpn/dco.c
> @@ -438,10 +438,6 @@ dco_p2p_add_new_peer(struct context *c)
>          }
>          remote_addr4 =3D &remote_ip4;
>      }
> -    else if (c->options.ifconfig_local)
> -    {
> -        msg(M_INFO, "DCO peer init: Need a peer VPN addresss to setup IP=
v4 (set --route-gateway)");
> -    }

Looking more closely, this is a really nice gem you found here :-)

The kernel should not care at all for remote_addr4 or remote_addr6 in
p2p mode ("it is never used for anything") *but* it does - so, if you
twist openvpn into setting up an ipv4-only tunnel, with topology subnet,
and no --route-gateway in the config (which would trigger the message
above), DCO actually refuses to bring up the interface:

2022-08-10 21:09:31 dco_new_peer: netlink reports error (-7): Invalid input=
 data or parameter
2022-08-10 21:09:31 dco_new_peer: failed to send netlink message: Invalid a=
rgument (-22)
2022-08-10 21:09:31 Cannot add peer to DCO: Invalid argument (-22)

... we did not see this in the t_client tests, as this needs *v4-only*,
and I never tested this ("3a" does now), and the kernel was happy with
"either v4 or v6, as long as I can ignore one of them"...


So, I think that for p2p, the whole remote_addr4/remote_addr6 thing=20
can be removed - more than just the message :-) - but first the kernel
needs to understand this as well.

FreeBSD DCO is happy with v4 and no route-gateway...

gert


PS:

# Test 3a: UDP / p2mp tun, topology subnet, IPv4-only inside, over IPv6
# (no route-gateway, explicit gateway on routes)
#
# triggers (Linux) DCO mishap "needs v4 or v6 remote VPN address even on p2=
p"
#
RUN_TITLE_3a=3D"udp / p2pm / top subnet / IPv4-only, no 'route-gateway'"
OPENVPN_CONF_3a=3D"$OPENVPN_BASE_P2MP --dev tun --proto udp --remote $REMOT=
E --port 51195 --pull-filter ignore ifconfig-ipv6 --pull-filter ignore rout=
e-ipv6 --pull-filter ignore route-gateway --route 10.194.0.0 255.255.0.0 10=
.194.3.1"
EXPECT_IFCONFIG4_3a=3D$EXPECT_IFCONFIG4_3
EXPECT_IFCONFIG6_3a=3D-
PING4_HOSTS_3a=3D"10.194.3.1 10.194.0.1"
PING6_HOSTS_3a=3D

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--bHUDy6DoWgl5NbkX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi9AMhAAoJEB2Cnv7KVigSSo8L/2HugnC9s3ArIu+IYEBvBHER
iyZFkyC45UV/NWtbe8aIK/lll5UKzh00/6Qf/R78/lNYcXgCD4Zi+bjcGQMqdUug
+C54jiIlrfbs+qErTgzp66443Li1bMyNxaedlq2KhXZltrjy2q8Oiw+LnAxX/fuw
6X+Rg8+ALsxQbyTwTfcyTYrdHpvYN0RPauM6h6u2cPFUs6bSmCY6NamNhaUFmG5J
aRWAHy9r648WE52fzug2dbzFTVgYp+vhn+obIVOfoNKNv58U3KnGI+GKVx2GkDTG
iZJCi+sBTNGN2wEt9fCB2gyTx6PjIX1Itsb3QDWytsyenuvp0c612hu0kmZiBbst
Dn8HkUH54JJmn93R2/aQQrniqvF0tyEKCSNYvZu9ldeiKYVCR8pBhl9ysofWC2aj
KaYxGQfO02JU8L2sggHWx7R9yOZdeCmfNOkgw8MHPLWfteMZ2PO5IAAsF8RGGszq
tYiTf8Aih3nTCPRChUE9MIXFBvwrLoDtlHxorpyo1Q==
=omIi
-----END PGP SIGNATURE-----

--bHUDy6DoWgl5NbkX--

