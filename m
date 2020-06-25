Date: Thu, 25 Jun 2020 10:54:28 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200625085428.GR1431@...1296...>
References: <20200401193258.GY1431@...1296...>
 <20200625083745.211-1-lstipakov@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="karoFps2WPV81jqn"
Content-Disposition: inline
In-Reply-To: <20200625083745.211-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] msvc: fix various level2 warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--karoFps2WPV81jqn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jun 25, 2020 at 11:37:45AM +0300, Lev Stipakov wrote:
> @@ -315,7 +315,7 @@ show_available_ciphers(void)
>          }
>      }
>=20=20
> -    qsort(cipher_list, num_ciphers, sizeof(*cipher_list), cipher_name_cm=
p);
> +    qsort((void *)cipher_list, num_ciphers, sizeof(*cipher_list), cipher=
_name_cmp);

I find this one questionable.  Qsort wants a void *, but every pointer type
should be convertible to void *, without a warning?

(Adding casts for things that are explicitly always allowed and well-define=
d=20
is something I do not like very much - it just makes "more code to read")


> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 2c8db68d..107bb4c9 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -1812,7 +1812,7 @@ do_open_tun(struct context *c)
>  #ifdef _WIN32
>      /* store (hide) interactive service handle in tuntap_options */
>      c->c1.tuntap->options.msg_channel =3D c->options.msg_channel;
> -    msg(D_ROUTE, "interactive service msg_channel=3D%u", (unsigned int) =
c->options.msg_channel);
> +    msg(D_ROUTE, "interactive service msg_channel=3D%u", (unsigned long =
long) c->options.msg_channel);

This gets a NAK.  "%u" is "unsigned int", not (never!) (unsigned long long)=
 -
if you want that, because the data type is so big, use %llu or %I64u
(Windows special, according to common.h).


> index 04868cd6..8178ff06 100644
> --- a/src/openvpn/mtu.c
> +++ b/src/openvpn/mtu.c
> @@ -175,7 +175,7 @@ set_mtu_discover_type(int sd, int mtu_type, sa_family=
_t proto_af)
>  #if defined(HAVE_SETSOCKOPT) && defined(IP_MTU_DISCOVER)
>              case AF_INET:
>                  if (setsockopt
> -                        (sd, IPPROTO_IP, IP_MTU_DISCOVER, &mtu_type, siz=
eof(mtu_type)))
> +                        (sd, IPPROTO_IP, IP_MTU_DISCOVER, (const char *)=
&mtu_type, sizeof(mtu_type)))

I find this questionable as well.  Setsockopt() on Unix wants a=20
"void *", not a "const char *" - and this cast suggest to the reader
that we're dealing with "something character based", which it is not.

>  #if defined(HAVE_SETSOCKOPT) && defined(IPV6_MTU_DISCOVER)
>              case AF_INET6:
>                  if (setsockopt
> -                        (sd, IPPROTO_IPV6, IPV6_MTU_DISCOVER, &mtu_type,=
 sizeof(mtu_type)))
> +                        (sd, IPPROTO_IPV6, IPV6_MTU_DISCOVER, (const cha=
r *)&mtu_type, sizeof(mtu_type)))

Same here.

>  show_available_tls_ciphers_list(const char *cipher_list,
>                                  const char *tls_cert_profile,
> -                                bool tls13);
> +                                const bool tls13);

I'm not sure why this is needed or beneficial?  This const stuff is
good for pointers ("do not modify the pointed-to area") but for
call-by-value arguments, the compiler can figure this out itself.

> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -233,10 +233,11 @@ do_set_mtu_service(const struct tuntap *tt, const s=
hort family, const int mtu)
>              sizeof(set_mtu_message_t),
>              0
>          },
> -        .iface =3D {.index =3D tt->adapter_index,.name =3D tt->actual_na=
me },
> +        .iface =3D {.index =3D tt->adapter_index},

Sure of that?  As in "are you sure the service does not need the name,
never"?

>          .mtu =3D mtu,
>          .family =3D family
>      };
> +    strncpynt(mtu_msg.iface.name, tt->actual_name, sizeof(mtu_msg.iface.=
name));

Well spotted.  This is interesting, the assignment ".name =3D tt->actual_na=
me"
shouldn't be legal (as it's basically a hidden strcpy(), not a integral
type or structure assignment), but mingw is not complaining and the=20
resulting binary works.  But this definitely is a necessary bugfix.


>      if (!send_msg_iservice(pipe, &mtu_msg, sizeof(mtu_msg), &ack, "Set_m=
tu"))
>      {
> @@ -889,7 +890,7 @@ add_route_connected_v6_net(struct tuntap *tt,
>  }
>=20=20
>  void
> -delete_route_connected_v6_net(struct tuntap *tt,
> +delete_route_connected_v6_net(const struct tuntap *tt,
>                                const struct env_set *es)

I might be convinced that this is a useful change, but if it's needed(!)
for delete_route_connected_v6_net(), the "cost" should be added to=20
add_route_connected_v6_net() as well.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--karoFps2WPV81jqn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe9GZEAAoJEB2Cnv7KVigSyU4MAIv1jL3gxSORzZbOnJLPBzWb
wFG3npwBVPAULtCqwo6gZ9bKLeqLsKT6TsImr87XhaiCk7aSS8k27YsoahPswllZ
Xd5J/44PGzjVeqhvxYri5x8aOoBEGSigL8sreM3yOmXcFsYGo7T3HuH4XYLiD9LB
agUHRE2Ad08p3AKjhL67/1jG9YsE/EmaM6OOTJC2BW/XO/qUaMngqtZx0d4MOopa
h4H+OW8dmZfPoCtizpavhnl++kcBOi8AncpWExckUF4D4KJko+TZbEVDAPMPu17Q
PLCFIA5Azy+11K6fZDnSRPLDdsMC5uQQ4nH4XNs15eiIGI911KoI3LHXPPwN+PXw
uCNhQ8h2rjS+WzrVNmh4sxoKeEmQoxjisKvbQVkSB2Nec4I1vFqk+YuHpb8RD2lk
SK+V4tLVZG9ZRIJneiAjFXM5+Ubl/zjLoW6qX14lGcUTSDltXgI/WGvbvIjD2x0W
f5jBQkyMcKeAabKlV7V7FAvjPwmBl47rIra6WoGHgw==
=Ej8i
-----END PGP SIGNATURE-----

--karoFps2WPV81jqn--

