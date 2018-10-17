Reply-To: openvpn-devel@lists.sourceforge.net
References: <1515482173-29447-1-git-send-email-eyal.birger@...277...>
 <CAKuzo_hN5A=LB7sp7m3REEpMsePSm-8dpXQUNtbQJz6y8w7zOw@...278...>
 <CAKuzo_iyBEgd0hUyFgQGm3cU+g9O7oCxs+=x_iDcHaxY5n-5Sg@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <748ea9af-4bb8-2f8d-51af-945f70679762@...2080...>
Date: Wed, 17 Oct 2018 12:42:55 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_iyBEgd0hUyFgQGm3cU+g9O7oCxs+=x_iDcHaxY5n-5Sg@...278...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ILISg5MYLF0mnWYswCs3NqMkaSUDr6p9C"
Subject: Re: [Openvpn-devel] [PATCH] Windows: Set interface IPv6 prefix
 length when configuring address
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ILISg5MYLF0mnWYswCs3NqMkaSUDr6p9C
Content-Type: multipart/mixed; boundary="PQ9YxjdR89qV9l9256ZMJ3Cicajl7LDTz";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Selva Nair <selva.nair@...277...>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <748ea9af-4bb8-2f8d-51af-945f70679762@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Windows: Set interface IPv6 prefix length
 when configuring address
References: <1515482173-29447-1-git-send-email-eyal.birger@...277...>
 <CAKuzo_hN5A=LB7sp7m3REEpMsePSm-8dpXQUNtbQJz6y8w7zOw@...278...>
 <CAKuzo_iyBEgd0hUyFgQGm3cU+g9O7oCxs+=x_iDcHaxY5n-5Sg@...278...>
In-Reply-To: <CAKuzo_iyBEgd0hUyFgQGm3cU+g9O7oCxs+=x_iDcHaxY5n-5Sg@...278...>

--PQ9YxjdR89qV9l9256ZMJ3Cicajl7LDTz
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 16/10/18 23:48, Selva Nair wrote:
> Hi,
>=20
> Going through patchworks noticed this.
>=20
> Thankfully this never got committed so here goes a retraction.
>=20
> On Sun, Jan 21, 2018 at 1:45 PM Selva Nair <selva.nair@...277...
> <mailto:selva.nair@...277...>> wrote:
>=20
>     Hi,
>=20
>     I'm on a reviewing spree (doing my penance), so here goes..
>=20
>     Thanks for the patch
>=20
>     On Tue, Jan 9, 2018 at 2:16 AM, Eyal Birger <eyal.birger@...277...
>     <mailto:eyal.birger@...277...>> wrote:
>     > Address prefix length defaults to /64 on Windows. This change allow=
s using
>     > Windows clients in setups that use a different prefix length.
>     >
>     > Note: the ability to set the prefix length is documented in the net=
sh
>     > 'add address' command, but works on the 'set address' command as we=
ll.
>=20
>     Aside:
>     If interactive service is in use, the ip helper API is used and setti=
ng
>     prefix already works.=C2=A0 Ideally I would like to see openvpn on Wi=
ndows
>     used only with the interactive service, but we are not there yet --
>     instances started by the automatic service does not use it and there
>     are some users still running the GUI as admin for some inexplicable
>     reasons.
>=20
>     So we need to continue supporting these code paths.
>=20
>     >
>     > Signed-off-by: Eyal Birger <eyal.birger@...277...
>     <mailto:eyal.birger@...277...>>
>     > ---
>     >=C2=A0 src/openvpn/tun.c | 7 ++++---
>     >=C2=A0 1 file changed, 4 insertions(+), 3 deletions(-)
>     >
>     > diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
>     > index 25831ce..b2b4795 100644
>     > --- a/src/openvpn/tun.c
>     > +++ b/src/openvpn/tun.c
>     > @@ -1561,15 +1561,16 @@ do_ifconfig(struct tuntap *tt,
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {
>     > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* example=
: netsh interface ipv6 set address
>     interface=3D42 2001:608:8003::d store=3Dactive */
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* example=
: netsh interface ipv6 set address
>     interface=3D42 2001:608:8003::d/64 store=3Dactive */
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char =
iface[64];
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 openv=
pn_snprintf(iface, sizeof(iface), "interface=3D%lu",
>     tt->adapter_index );
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argv_=
printf(&argv,
>     > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "%s%sc interface ipv6 set address %s %s
>     store=3Dactive",
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "%s%sc interface ipv6 set address %s %s/%d
>     store=3Dactive",
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_win_sys_path(),
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NETSH_PATH_SUFFIX,
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iface,
>     > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ifconfig_ipv6_local );
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ifconfig_ipv6_local,
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tt->netbits_ipv6);
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 netsh=
_command(&argv, 4, M_FATAL);
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* se=
t ipv6 dns servers if any are specified */
>     >=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 netsh=
_set_dns6_servers(tt->options.dns6,
>     tt->options.dns6_len, actual);
>=20
>     Works as expected and the code is good.
>=20
>     Currently, on setting the address, a default route gets set with
>     prefix /64 with gateway as OnLink (does not happen when iphelper api
>     is used). Although our explicit route to fe80::8 may override it, it
>     looks better to set the correct prefix in the address. So:
>=20
>     Acked-by: Selva Nair <selva.nair@...277... <mailto:selva.nair@...1354...=
..>>
>=20
>=20
> Though this works in my tests I want to retract this ACK.
>=20
> Apart from possible issues due to the appearance of the onlink route in s=
ome
> cases, I think the correct approach going forward is to stop using netsh =
and
> use the IP helper API for such tasks. And do it in the same way as done u=
sing
> the service.
>=20
> Un-Acked-by: Selva Nair <selva.nair@...277... <mailto:selva.nair@...1663...=
.>> :)

That was close .... I looked at this yesterday, but since the contributor w=
as
a new person and changing details in code paths I'm not that deep into, I
wanted to have a much closer look before applying it - luckily I didn't have
enough brainpower yesterday to dive into this one.  And since you had ACKed
it, I considered it generally being safe enough for further processing.

So thanks for having a closer look again and notify us instantly :)

I'll ensure this patch is tagged as rejected in patchwork.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--PQ9YxjdR89qV9l9256ZMJ3Cicajl7LDTz--

--ILISg5MYLF0mnWYswCs3NqMkaSUDr6p9C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJbxxI1AAoJEIbPlEyWcf3yNSYQAKjoW95TIryHaFATunHwUz8M
H9ts4JMRRdCTC5So7FTSEWIqPW/zwkfQD+iyIxmf2D9W//Yj+/wdzuPm2UQDW0I9
NVxGkGBZf2hH/IUyEfJuSZ2QKKDL3+GLXMY0QJ127gJ3HLxb5uQIxwZWmbQo5u3w
9CHcGmxjZIdLuvANLGzoTjVwdBNz+29itzaHyOd6r0Jdqux7Bu8GLEceLjhXle40
5XRDErnOCX+GLvdF+eeP6mdf6bOHqa9GsgXTsA+HLQVFnZXYhix+IFeQHWn2/JrJ
cdYX4Nv8y0WmdGAOYXsgGHEghFmUwlK3B7gGsDCxuxnR/LZNshaALyLHXqWslNr0
Pl26t8E9k/0ZXbWkh0VY3dDubHyXmR09vXusA4lfNlwTJy42q5KQOHSXkyDKh970
Mwp8JqGOAEH6f4tvVwg5C3ZcImGhHTOS6UglBRwxxxKCMX04yr85oekZS0pQXVy/
plGsJwa5YiStxSczFJhHh0D9mjl+q622E2uAcoxHO5fUIfhSe8bCW/AapHhaFmHf
uE1SSct7zXv5JVyOHBBNSgjTYnRI4pBxKqxaKYw1VPjbtVMywzi7FUvsePHu7XlS
kVratluKa+47g51orpZ0Jzlt5TwgDwxdv16l2pD8pIymwpcFQh1kAP/NStI+pNQN
yNOqXsmXgplHJXNhG4JM
=uErs
-----END PGP SIGNATURE-----

--ILISg5MYLF0mnWYswCs3NqMkaSUDr6p9C--

