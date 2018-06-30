References: <20180629174529.19915-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <023bf67a-02c2-93ca-7c97-3219b24d3411@...2181...>
Date: Sat, 30 Jun 2018 21:02:06 +0800
MIME-Version: 1.0
In-Reply-To: <20180629174529.19915-1-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AhaqxZ5Re3x6YhfiSTp8QzTxhluuIVTJm"
Subject: Re: [Openvpn-devel] [PATCH] Extend push-remove to also handle
 'ifconfig'.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AhaqxZ5Re3x6YhfiSTp8QzTxhluuIVTJm
Content-Type: multipart/mixed; boundary="eDzE26W7pCIa4z6rnRl0EtQ2bDIn83GS8";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net
Message-ID: <023bf67a-02c2-93ca-7c97-3219b24d3411@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Extend push-remove to also handle
 'ifconfig'.
References: <20180629174529.19915-1-gert@...1296...>
In-Reply-To: <20180629174529.19915-1-gert@...1296...>

--eDzE26W7pCIa4z6rnRl0EtQ2bDIn83GS8
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

thanks for taking care of this!
IPv4 settings should all be treated like others and never "assumed to be
there all the time" anymore :)

On 30/06/18 01:45, Gert Doering wrote:
> Push-remove (introduced in commit 970312f1850) did not handle "ifconfig"
> yet, as both "ifconfig" and "ifconfig-ipv6" are handled differently from
> all other pushed options.  Since there was no valid use-case to not-push
> "ifconfig" (no support on the client side for running IPv6-only) this
> was not an issue so far - but with the recent commits to enable ipv6-only
> operation it can be a desirable feature.
>=20
> The implementation is similar to "push-remove ifconfig-ipv6" - namely,
> flagging via a new context option (c->options.push_ifconfig_ipv4_blocked)
> and then not creating the push statement in "send_push_reply()".
>=20
> While not truly elegant, it's much less invasive than the alternatives
> (storing the list of "push-remove" statements somewhere and then checking
> in push_option_ex())
>=20
> Trac: #1072
>=20
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/options.h |  1 +
>  src/openvpn/push.c    | 10 +++++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index f7d0145..3a6c33f 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -425,6 +425,7 @@ struct options
>      bool push_ifconfig_constraint_defined;
>      in_addr_t push_ifconfig_constraint_network;
>      in_addr_t push_ifconfig_constraint_netmask;
> +    bool push_ifconfig_ipv4_blocked;                    /* IPv4 */
>      bool push_ifconfig_ipv6_defined;                    /* IPv6 */
>      struct in6_addr push_ifconfig_ipv6_local;           /* IPv6 */
>      int push_ifconfig_ipv6_netbits;                     /* IPv6 */
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index 6a30e47..86ec7ea 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -342,7 +342,8 @@ prepare_push_reply(struct context *c, struct gc_arena=
 *gc,
>=20=20
>      /* ipv4 */
>      if (c->c2.push_ifconfig_defined && c->c2.push_ifconfig_local
> -        && c->c2.push_ifconfig_remote_netmask)
> +        && c->c2.push_ifconfig_remote_netmask &&

wrong style: && should go on the next line (unless you can put also the
following condition on the same line).

> +        !o->push_ifconfig_ipv4_blocked)
>      {
>          in_addr_t ifconfig_local =3D c->c2.push_ifconfig_local;
>          if (c->c2.push_ifconfig_local_alias)
> @@ -602,6 +603,13 @@ push_remove_option(struct options *o, const char *p)
>  {
>      msg(D_PUSH_DEBUG, "PUSH_REMOVE searching for: '%s'", p);
>=20=20
> +    /* ifconfig is special, as not part of the push list */
> +    if (streq( p, "ifconfig" ))

I know you have simply copy/pasted the code from below, but since at it,
please use the right style and remove useless spaces after of before the
parentheses.

> +    {
> +        o->push_ifconfig_ipv4_blocked =3D true;
> +        return;
> +    }
> +
>      /* ifconfig-ipv6 is special, as not part of the push list */
>      if (streq( p, "ifconfig-ipv6" ))
>      {
>=20


Once the small style glitches above, I can give this patch my ACK.

I tested with my small environment and it does what it says without
breaking other features.


While, I think it is ok to take this patch as it is, as a follow up it
would probably make sense to treat ifconfig and ifconfig-ipv6 like the
other push-remove directives and allow for partial matching. This would
make it identical to pull-filter (I think).


Cheers,



--=20
Antonio Quartulli


--eDzE26W7pCIa4z6rnRl0EtQ2bDIn83GS8--

--AhaqxZ5Re3x6YhfiSTp8QzTxhluuIVTJm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAls3f04ACgkQB6U8WA7y
zXSZLw/+OZ0uenioUg+/4J+NF50MIPF3Xqllc6oOrRiz/8Q6D4+cXgDwyVrOaLgb
zXcjNT6ky7GEmMt7JqM/TM1JgYIhuoZj75S/kJn2rllW8YRwaHROUMrkiLqRs5m3
5BPFqSnIC3w8iJaBRrww4iU6aSmU2L19sIaVA9HnNRU4Xa2rqsfr+lJdeEq/29D4
+PshNUmEp0KdpXfsFnQsApwqG1khZtHU8TzKwoPyjQfVEpcsxHaXk2aMB1jlqso/
So9FwMFE/Do550Oh8CJ1vzcXdtqmikIyDc0RnCjKT9CTuibAOl088UIpMfoE94Bm
rS3Psupys3Uc4SwnuZibWBhPVuk7Qf7gOH16rNhBtrXITvzh1ZEtTzk4QT5qCDnJ
/b2L8ujWura2W0H/17vh4xBJ/gPppp7fYqFF5qf9BRTft4AltVRhHcYYfC9wtGTE
3+OEd59Zx/HHLrcbIZo1ytNpCNCk11meHgnRXBiLItypvdvJ2WwyD7iwMvXQZBsP
bHKW53s1fE7kgvbWdHvY1y/uK6Cx3IgcnegJNcMA4WcshNmKAVfjLov3byDAD4Da
2wtBLCspIZ15uk2d2JP5zOeeNas5aAh3iD/Lydrurp2qaeUm6CVBvxA9xGHi9xjh
l3yp/4CUf5/nxbpsJeAYKme484/7evu0akoKQDSpNhceq1bNLnU=
=ibp3
-----END PGP SIGNATURE-----

--AhaqxZ5Re3x6YhfiSTp8QzTxhluuIVTJm--

