Date: Tue, 5 Jun 2018 21:59:35 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180605195935.GU57262@...1296...>
References: <20180605090421.9746-1-a@...2181...>
 <20180605090421.9746-2-a@...2181...>
 <20180605143603.GL57262@...1296...>
 <CAKuzo_i5wMwqSKjH-ohK8ujSApthxNrHsbFw2k5U9q_YKb_YqA@...278...>
 <9319a55d-c27e-aa07-749d-9c998271a5c4@...2181...>
 <CAKuzo_gfgG=6LxX-s0aPReZeaXDwEBM0zfrtWxZR9JzNvkraOA@...278...>
 <20180605185352.GR57262@...1296...>
 <CAKuzo_gaiCL1Y_zbHUBjaQwxtU2WYzg5Z4zv9tDUS-J4oeoLVg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="citGix+cyBYE+lqp"
Content-Disposition: inline
In-Reply-To: <CAKuzo_gaiCL1Y_zbHUBjaQwxtU2WYzg5Z4zv9tDUS-J4oeoLVg@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/5] tun: ensure interface can be
 configured with IPv6 only
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, Antonio Quartulli <a@...2181...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--citGix+cyBYE+lqp
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 05, 2018 at 03:38:44PM -0400, Selva Nair wrote:
> FWIW, I did a quick test --- looking into tap-windows sources it seems
> the address is used only for ARP so passing some random address to the
> ioctl looks ok (?).

Not sure about that.  For ARP spoofing, it should use the route-gateway=20
address - the "ifconfig" address is likely to end up in the DHCP-server
code.  Haven't checked yet (busy repairing my own test right which
deteriorated a bit...).

[..]
> There is a less than ideal log message which could be improved:
>=20
> "Set TAP-Windows TUN subnet mode network/local/netmask =3D
> 0.0.0.0/0.0.0.0/0.0.0.0 [SUCCEEDED]"

Indeed :-)

> However, even with !ipv4, redirect-gateway ipv6 appears to error out
> -- it fails with
>=20
> "TEST ROUTES: 0/2 succeeded len=3D1 ret=3D0 a=3D0 u/d=3Dup
> Route: Waiting for TUN/TAP interface to come up..."

Interesting.  This is route.c, test_routes(), using test_route_helper()
-> test_route(), which basically tries to find the adapter index where
a given (route)->gateway is configured on.  Since it cannot find anything,
it assumes "tun interface is stuck in DHCP" and is unhappy.

This shouldn't actually try to do anything in the first place - it
looks at "struct route_list *rl", which should not be populated if
we have no v4 address to point the routes to.  (Or maybe it should,
but only for "non-tun/tap routes").


> A couple of other random things I noticed
>=20
> If a v4 address is not being set:
>=20
> - some management messages could be bypassed as Gert had guessed --
> eg., ASSIGN_IP which includes the v4 and v6 address.
> The GUI takes the address from the final CONNECTED,SUCCESS message but
> other clients may parse this message.

What does our GUI display here?  "0.0.0.0" or "<blank>"?

> - setting of mtu may get skipped in some systems at least
>=20
> Here is the diff of what I did for the Windows build run:
>=20
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 2e33880..75336a9 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -5824,9 +5824,9 @@ open_tun(const char *dev, const char *dev_type,
> const char *dev_node, struct tun
>=20
>      if (tt->type =3D=3D DEV_TYPE_TUN)
>      {
> -        if (!tt->did_ifconfig_setup)
> +        if (!tt->did_ifconfig_setup && !tt->did_ifconfig_ipv6_setup)
>          {
> -            msg(M_FATAL, "ERROR: --dev tun also requires --ifconfig");
> +            msg(M_WARN|M_INFO, "WARNING: neither ifconfig nor
> ifconfig-ipv6 specified");
>          }

Thanks.  This is easy enough to integrate...  Antonio, are you listening? ;=
-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--citGix+cyBYE+lqp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbFuumAAoJEB2Cnv7KVigSQtYL/ij/Wezdw34sTzo5FpPvQgWb
NQiawabYLUEBs7YTEWTCrzrAGErlMfjjtpPrhIMeItixYADMewTHXGgVHKM6J4oc
5f7OvTomHfACeCyvtH7kb9h/PtlnHvbuMxJUt/rc2lwvYSDKLonLnZxzbJHQS6F1
1XJVdSEIQ36PDf2AYQWUvNRZjD9UcBJ2v43qUSNKqaUgnsZlM4CyoxQHXa9b/5XX
mjxMEOYgZe8NfUispCjYCQ59Ywa3aQuXgzOW5DYnqwWmCzrTHXu9D9jC4F8fJiTb
cKTGJQ/TOrnpFzhkWQfd/VHplBoz2cmEFJ6BXl2WPzW0fWfh/0EkKbaf0e6btjDg
/oFeHAMIMlYHo+d/6zlJf1yirRMo4MQBjUk0FXFZpm8hV1vHShRX1OWT7kyBO9YJ
Iax5yjPXzm/gK9GjZsv9au+uTenX4sNtZJ1CSUJWdRxdJGAbGL3OzgovBmBHqemO
6L91/Wqj9VExeB2AarhaqWwyhKGQDDFVVempAzRg8Q==
=CmTb
-----END PGP SIGNATURE-----

--citGix+cyBYE+lqp--

