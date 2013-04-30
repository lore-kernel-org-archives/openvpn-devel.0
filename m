Message-ID: <518009BA.4010407@...1114...>
Date: Tue, 30 Apr 2013 20:13:14 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1367006045-13576-1-git-send-email-arne@...1227...>
	<1367006372-14815-1-git-send-email-arne@...1227...>
In-Reply-To: <1367006372-14815-1-git-send-email-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2LIIFEOXSWBQESGDPNNSU"
Subject: Re: [Openvpn-devel] [[Patch v3] 4/4] Emulate persist-tun on Android
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2LIIFEOXSWBQESGDPNNSU
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 26/04/13 21:59, Arne Schwabe wrote:
> On Android changing the configuration of tun is not possible. So instead =
of reconfiguring the tun device, open a new tun device and close the old on=
e if needed
> ---
>  src/openvpn/init.c |   18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>=20
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index f08583b..9ff6600 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -1402,8 +1402,19 @@ do_open_tun (struct context *c)
>    c->c2.ipv4_tun =3D (!c->options.tun_ipv6
>  		    && is_dev_type (c->options.dev, c->options.dev_type, "tun"));
>=20=20
> +#ifndef TARGET_ANDROID
>    if (!c->c1.tuntap)
>      {
> +#endif
> +=20=20=20=20=20=20
> +#ifdef TARGET_ANDROID
> +      /* If we emulate persist-tun on android we still have to open a ne=
w tun and
> +         then close the old */
> +      int oldtunfd=3D-1;
> +      if(c->c1.tuntap)
> +          oldtunfd =3D c->c1.tuntap->fd;
> +#endif
> +=20=20=20=20=20=20=20=20
>        /* initialize (but do not open) tun/tap object */
>        do_init_tun (c);
>=20=20
> @@ -1439,7 +1450,10 @@ do_open_tun (struct context *c)
>        /* open the tun device */
>        open_tun (c->options.dev, c->options.dev_type, c->options.dev_node,
>  		c->c1.tuntap);
> -
> +#ifdef TARGET_ANDROID
> +      if(oldtunfd>=3D0)
> +        close(oldtunfd);
> +#endif
>        /* set the hardware address */
>        if (c->options.lladdr)
>  	  set_lladdr(c->c1.tuntap->actual_name, c->options.lladdr, c->c2.es);
> @@ -1481,6 +1495,7 @@ do_open_tun (struct context *c)
>=20=20
>        ret =3D true;
>        static_context =3D c;
> +#ifndef TARGET_ANDROID
>      }
>    else
>      {
> @@ -1503,6 +1518,7 @@ do_open_tun (struct context *c)
>  		     "up",
>  		     c->c2.es);
>      }
> +#endif
>    gc_free (&gc);
>    return ret;
>  }


There are a few stylish details I could nit-pick on, such as

    if(bool) -> if (bool)

but that's so minor I don't even convinced this makes sense to fix up
before applying.

So, looks good, code wise.  Not compile tested, only patch review.


--=20
kind regards,

David Sommerseth


------enig2LIIFEOXSWBQESGDPNNSU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGACboACgkQDC186MBRfrrhaQCgoCoVj3KtM0dbY8fEcqJ49S19
rBoAoIw7VS17xs64Yqr84WWiZGRVNOJJ
=6QLr
-----END PGP SIGNATURE-----

------enig2LIIFEOXSWBQESGDPNNSU--

