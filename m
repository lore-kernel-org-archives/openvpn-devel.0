Date: Wed, 23 Sep 2020 13:12:42 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200923111242.GH976@...1296...>
References: <20200820134946.10573-1-jan.seeger@...2574...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="4IFtMBbmeqbTM/ox"
Content-Disposition: inline
In-Reply-To: <20200820134946.10573-1-jan.seeger@...2574...>
Subject: Re: [Openvpn-devel] [PATCH] Added environment variable for IPv6
 route metric.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Seeger <jan.seeger@...2574...>
Cc: openvpn-devel@lists.sourceforge.net

--4IFtMBbmeqbTM/ox
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Aug 20, 2020 at 03:49:46PM +0200, Jan Seeger wrote:
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -1463,6 +1463,7 @@ setenv_route_ipv6(struct env_set *es, const struct =
route_ipv6 *r6, int i)
>          struct buffer name1 =3D alloc_buf_gc( 256, &gc );
>          struct buffer val =3D alloc_buf_gc( 256, &gc );
>          struct buffer name2 =3D alloc_buf_gc( 256, &gc );
> +        struct buffer name3 =3D alloc_buf_gc( 256, &gc );
>=20=20
>          buf_printf( &name1, "route_ipv6_network_%d", i );
>          buf_printf( &val, "%s/%d", print_in6_addr( r6->network, 0, &gc ),
> @@ -1471,6 +1472,11 @@ setenv_route_ipv6(struct env_set *es, const struct=
 route_ipv6 *r6, int i)
>=20=20
>          buf_printf( &name2, "route_ipv6_gateway_%d", i );
>          setenv_str( es, BSTR(&name2), print_in6_addr( r6->gateway, 0, &g=
c ));
> +
> +        if (r6->flags & RT_METRIC_DEFINED) {
> +            buf_printf( &name3, "route_ipv6_metric_%d", i) ;
> +            setenv_int( es, BSTR(&name3), r6->metric);
> +        }

style guide demands "{" on a separate line, so

           if (r6->flags & RT_METRIC_DEFINED)
           {

also, I'd move the allocation of "name3" into this block.

           if (r6->flags & RT_METRIC_DEFINED)
           {
               struct buffer name3 =3D alloc_buf_gc( 256, &gc );
               ...

(no need to allocate memory if this is never used - also, with our
move towards C99, new code is encouraged to declare variables where
first needed, not "at the top of the function")

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--4IFtMBbmeqbTM/ox
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfay2pAAoJEB2Cnv7KVigSsKwL/2que0JNd4jTGM4RcJCrLWCU
BNPd0XeSeP0e7uWHngqjV6CyuwyhZegtgtEJokSRYFg8fDvWuZDNNeyblHUfnxvt
659/FusKMhw+1klTLafFqT35MJ+p8ppJuKSH9Nzgw/Ekxzlb7I0y2KWkFGRUnLny
oopKSsrK/AD++/OmLVAXPIjasI0wYie7rBfSMitr4WeE9wVEpQShiwZfGteBLlsz
4rKOnZ0cb5p4F3QTQqGYRfNQoRMVG6/g5wOdEr11AOKJ8XXQB6GGe8mJcQrPntAI
iNCVO0nsnHs5yR3d0X4TJ7SlJ+IYMtaqfhUb4nX35iuhBC3iNkf/G0HPDDduVXxW
zIHaa/TVdRFQuv8hqz55Ia37Xd2IWoiLVTxY7HPd9ErbU75qM+Kh90JbgPcD8Ag4
ggyS3Iz2FreSevqoRS4QYoFoRQ4yspGhF8A+iMSRrJ0dI53wocKLJVyW3rFzP65m
o8T4UUzifpJNxOUsFOJLbkhclLJNhL+iN4ujt9Pq5w==
=H9Xi
-----END PGP SIGNATURE-----

--4IFtMBbmeqbTM/ox--

