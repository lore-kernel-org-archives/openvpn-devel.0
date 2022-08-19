Date: Fri, 19 Aug 2022 12:01:23 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Yv9fczYCUEM3i6V4@...1296...>
References: <20220813204224.22576-1-a@...2181...>
 <20220813204224.22576-3-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="wwly2nQZWz6qzHK5"
Content-Disposition: inline
In-Reply-To: <20220813204224.22576-3-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v101 3/7] dco-win: implement ovpn-dco
 support in P2P Windows code path
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

--wwly2nQZWz6qzHK5
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Aug 13, 2022 at 10:42:20PM +0200, Antonio Quartulli wrote:
> With this change it is possible to use ovpn-dco-win when running OpenVPN
> in client or P2P mode.
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> Signed-off-by: Lev Stipakov <lev@...515...>
> Signed-off-by: Antonio Quartulli <a@...2181...>

All the prerequisites for this have now been merged.  So if someone=20
could *test* that "master + 3/7" actually works, we could proceed with
merging it...

I do have a few code nags that I hope will find agreement.

> @@ -1810,9 +1811,12 @@ do_open_tun(struct context *c)
>              ovpn_dco_init(c->mode, &c->c1.tuntap->dco);
>          }
>=20=20
> -        /* open the tun device */
> -        open_tun(c->options.dev, c->options.dev_type, c->options.dev_nod=
e,
> -                 c->c1.tuntap, &c->net_ctx);
> +        /* open the tun device (ovpn-dco-win already opened the device f=
or the socket) */
> +        if (!tuntap_is_dco_win(c->c1.tuntap))
> +        {
> +            open_tun(c->options.dev, c->options.dev_type, c->options.dev=
_node,
> +                     c->c1.tuntap, &c->net_ctx);
> +        }

do_open_tun() is one of the already-confusing functions, and this extra
condition isn't helping.

Can we move the extra condition into the *WIN32 specific* open_tun()=20
("/* nothing to do for DCO, return */") and leave init.c alone?

> @@ -3570,6 +3584,15 @@ do_close_free_key_schedule(struct context *c, bool=
 free_ssl_ctx)
>  static void
>  do_close_link_socket(struct context *c)
>  {
> +    /* in dco-win case, link socket is a tun handle which is
> +     * closed in do_close_tun(). Set it to UNDEFINED so
> +     * we won't use WinSock API to close it. */
> +    if (tuntap_is_dco_win(c->c1.tuntap) && c->c2.link_socket
> +        && c->c2.link_socket->info.dco_installed)
> +    {
> +        c->c2.link_socket->sd =3D SOCKET_UNDEFINED;
> +    }
> +

Overloading the link socket with a tun handle and then having=20
special cases all around is not exactly easy to understand or=20
maintainable code.  I have no good suggestion how to make this
nicer, but this is going to come back and haunt us.

(We still do not have automated windows testing, with all 3 driver
types...)

> @@ -3439,10 +3441,12 @@ options_postprocess_setdefault_ncpciphers(struct =
options *o)
>          /* custom --data-ciphers set, keep list */
>          return;
>      }
> +#if !defined(_WIN32)
>      else if (cipher_valid("CHACHA20-POLY1305"))
>      {
>          o->ncp_ciphers =3D "AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305";
>      }
> +#endif

Not sure I understand this exclusion.  It's the *default* ciphers,=20
and we know that Windows can do CHACHA20-POLY1305 - *DCO* on Windows
might not be able to use this, but this disables using CHACHA-Poly=20
in the default config for all windows builds.

Maybe just query the DCO cipher list here, if DCO is enabled?

So=20

     ...
     else if (dco_enabled())
     {
         o->ncp_ciphers =3D dco_get_supported_ciphers()
     }
     else if (cipher_valid("CHACHA20-POLY1305"))
     {
         o->ncp_ciphers =3D "AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305";
     }
...

> diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
> index b4c20f69..db73b35d 100644
> --- a/src/openvpn/socket.c
> +++ b/src/openvpn/socket.c
> @@ -2162,7 +2197,24 @@ link_socket_init_phase2(struct context *c)
>      /* If a valid remote has been found, create the socket with its addr=
info */
>      if (sock->info.lsa->current_remote)
>      {
> -        create_socket(sock, sock->info.lsa->current_remote);
> +#if defined(_WIN32)
> +        if (dco_enabled(&c->options))
> +        {
> +            create_socket_dco_win(c, sock, &sig_info->signal_received);
> +            if (sig_info->signal_received)
> +            {
> +                goto done;
> +            }
> +
> +            linksock_print_addr(sock);
> +            goto done;
> +        }
> +        else

I understand that we need to use a different create_socket_dco_win()
function here, but all the *other* lines of code are just "huh, wat".

Why not move the linksock_print_addr(sock); *into* create_socket_dco_win(),
and then this would collaps to a much more compact

> +#if defined(_WIN32)
> +        if (dco_enabled(&c->options))
> +        {
> +            create_socket_dco_win(c, sock, &sig_info->signal_received);
> +            goto done;
> +        }
> +        else
> +#endif

(still quite ugly)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--wwly2nQZWz6qzHK5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi/19zAAoJEB2Cnv7KVigS3SIL/3YLn+GPP/x8seNmibIlMUgh
WMwzZtfn84KNEqOrYdwWN5PwgmMJVLNv2jK+7bFzpwaYPJjEX9F502tSwAO6suLM
IEVaz/gr01tTw2CoXjAQpL7bwsxkH7zwzmndHDqVzA+zi+WYs4IpyxAG74jUJ/y3
QxV+/D8T44tlAnmQi+CTKbXIh3JSEXyMLcKGY1AVf3hoBhszBPtUsLltjGDpIaGL
OdR+ZmlSD0XTloJfVv+2QQTB0tHqbDb7BQ6m58PnR8bHMEBb5bVq6c2cmpccknD6
fN1Cpoh8VynrIJ8eJUfA2I4TCEL2R1Dmww0kHXSf7iDlu5ck2M3u/g6d2+p6Gxu6
Wcqv3t7rUk7+CmjD41qJTUzWGp3j3EcNx2aQ1Jdb/rCDjkTW6SKtk/hTwZWFQcyH
PKARm8zSYSyXQjG6nlW/Z4dXTyRulxa5rDRZl9OoZ4/tXj5sYzba8DqI2O+E+4a7
ujf+owbzvneG154QXGM/clJrephOSNU2HYi/POi7ZQ==
=TP80
-----END PGP SIGNATURE-----

--wwly2nQZWz6qzHK5--

