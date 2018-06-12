Date: Tue, 12 Jun 2018 13:31:11 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180612113111.GC57262@...1296...>
References: <20180608052017.6696-2-a@...2181...>
 <20180612074240.18865-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Tdr039sUWCyRuLRO"
Content-Disposition: inline
In-Reply-To: <20180612074240.18865-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v3] tun: ensure interface can be
 configured with IPv6 only
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Gert Doering <gert@...1296...>, Antonio Quartulli <antonio@...515...>

--Tdr039sUWCyRuLRO
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 12, 2018 at 03:42:40PM +0800, Antonio Quartulli wrote:
> This change ensures that an interface is properly brought
> up even when only IPv6 settings are configured/pushed.

And more review, this time for actual code :-)

> +do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
> +                 const struct env_set *es)
...
> +#elif defined(TARGET_SOLARIS)
...
> +        const char *ifconfig_ipv6_remote =3D print_in6_addr(tt->remote_i=
pv6, 0,
> +                                                          gc);

As discussed on IRC, I find the dangling "gc);" more ugly than the
old variant - so please keep the old formatting for now.

We might revisit this and rename all these long variables towards
"local_ip" and "remote_ip", or ditch all of tun.c in the sitnl-internal-API-
rewrite.  We'll see.  But not today, or this month.

> +#elif defined(TARGET_OPENBSD) || defined(TARGET_NETBSD) \
> +    || defined(TARGET_DARWIN) || defined(TARGET_FREEBSD) \
> +    || defined(TARGET_DRAGONFLY) || defined(TARGET_AIX)

I like the fact that all the BSDs can now be nicely joined into one
common block - but please keep TARGET_AIX separate.

While it uses the same "ifconfig" call as the other 5, joining the
block adds two new #ifdef clauses...

> +#if defined(TARGET_AIX)
> +    /* AIX ifconfig will complain if it can't find ODM path in env */
> +    es =3D env_set_create(NULL);
> +    env_set_add(es, "ODMDIR=3D/etc/objrepos");
>  #endif

... which, I think, warrant a dedicated #elif defined(TARGET_AIX) block
("contain the ugliness").

> +#if !defined(TARGET_FREEBSD) && !defined(TARGET_DRAGONFLY) \
> +    && !defined(TARGET_AIX)
> +    /* and, hooray, we explicitely need to add a route... */
> +    add_route_connected_v6_net(tt, es);
> +#endif

And here, please use positive matching - way easier to see which platform
this applies to than going upwards for the encompassing #if TARGET_*
block and negating parts of them.

If counting right, this would become

> +#if defined(TARGET_NETBSD) || defined(TARGET_OPENBSD) || \
> +    defined(TARGET_DARWIN)

... easier to understand.


> +#elif defined (_WIN32)
[..]
> +    {
> +        /* example: netsh interface ipv6 set address interface=3D42
> +         * 2001:608:8003::d store=3Dactive
> +         */

I can see why you want to wrap the netsh example command, but I find this
not nice to read.  What about:

 +        /* example: netsh interface ipv6 set address interface=3D42
 +         *                  2001:608:8003::d store=3Dactive
 +         */

so it's clear that this is a continuation line?

[..]
> +#else  /* if defined(TARGET_LINUX) */
> +    msg(M_FATAL, "Sorry, but I don't know how to do IPv6 'ifconfig' comm=
ands on this operating system.  You should ifconfig your TUN/TAP device man=
ually or use an --up script.");
> +#endif  /* if defined(TARGET_LINUX) */

These two "defined(TARGET_LINUX)" are not your doing, but I think they
should be removed.  Neither is the "#else" being "the other option to
TARGET_LINUX" nor is the #endif a simple "this is only TARGET_LINUX".


I'd either completely remove the comment or make it something like

#else   /* platforms we have no IPv6 code for */

#endif  /* outer #if defined(TARGET_xxx) conditional */


I think that's all I have to say about v3 so far :-)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--Tdr039sUWCyRuLRO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbH67/AAoJEB2Cnv7KVigSeREL/28d7QAyEzkjMVRhCMzNCx6L
hK4Sq4P/PILAqLRpTU2L8PyYAynLC43xJyiBa1uQhWvL76NrPIN3QKp6MU5pg6Ii
0MI74dci+tcCiE+I1OgXoo4gwwvD/LO6KoMojL/zFEhSXif2eF1aeHTY+oNw/bIV
ZtrtETXOo46KZi4UfOz55uu6nT9WlO4yucRC3bkakRsH1eJkLnUcalQPUOyX5uPT
xEf4TWyc8FDv6wAfxK8m3CIffeoiz7WjpPqe33L7dJkJuNI8b5Lb0ykmMBV+f9MI
2G27I1cpkRkNggktHHaLVtUDUmXRV22kZVIKLyGy3kw3jeXxC21so5/5tW0+9U+K
sV8B8SwKEQvRBl7e2dA6UHKiugrgbQJpA4le0X2zk9TDMklxK2VXYCxOYt4Ld5uO
WA1a9AYGRN4LvBz0qX8IXEMsmS5KznBtcJ1l4WcHO6k19zZzG35rwPgc6C6PFFFR
4fbN+cVrV2aD4wJjiruNgtsrJEswTHbLbLdfp19wGw==
=/6ud
-----END PGP SIGNATURE-----

--Tdr039sUWCyRuLRO--

