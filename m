Date: Mon, 1 Jun 2020 12:40:48 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200601104048.GJ1431@...1296...>
References: <20200530000600.1680-1-a@...2181...>
 <20200530000600.1680-3-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/JSPCXnUaGdgtX+H"
Content-Disposition: inline
In-Reply-To: <20200530000600.1680-3-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v4 2/7] pool: allow to configure an
 IPv6-only ifconfig-pool
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@...515...>

--/JSPCXnUaGdgtX+H
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, May 30, 2020 at 02:05:55AM +0200, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@...515...>
>=20
> With this change a server is allowed to allocate an
> IPv6-only pool. This is required to make it capable
> of managing an IPv6-only tunnel.
>=20
> Trac: #208
> Signed-off-by: Antonio Quartulli <antonio@...515...>
>=20
> ---
> Changes from v3:
> - properly compute pool size taking into account the actual base address

Alas, we need a v5 of this patch.

One part is purely cosmetic...

> +        msg(D_IFCONFIG_POOL, "IFCONFIG POOL: base=3D%s size=3D%d",
> +            print_in_addr_t(pool->ipv4.base, 0, &gc), pool->ipv4.size);

I think it should print "IFCONFIG POOL IPv4: ..." here, to make it
symmetric with IPv6.  Which is what we want, two equally-well supported
protocols, not "the primary" and "IPv6" :-)


The other part is bigger, unfortunately...


Mon Jun  1 12:18:05 2020 us=3D584985 194.97.140.21:32015 [cron2-freebsd-tc-=
amd64] Peer Connection Initiated with [AF_INET6]::ffff:194.97.140.21:32015

Program received signal SIGSEGV, Segmentation fault.
ifconfig_pool_release (pool=3D0x0, hand=3D-1, hard=3Dhard@...1851...=3Dfals=
e) at pool.c:361
361         int pool_size =3D ifconfig_pool_size(pool);


if you have a server that has *no* pools configured, no v4 and no v6=20
pool (because address management is done outside openvpn) it will crash
the first time a given client reconnects.

GDB backtrace:

(gdb) where
#0  ifconfig_pool_release (pool=3D0x0, hand=3D-1, hard=3Dhard@...1851...=3D=
false)
    at pool.c:361
#1  0x000055555558cc20 in multi_close_instance (m=3D0x7fffffffc520,=20
    mi=3D0x55555567d9a0, shutdown=3D<optimized out>) at multi.c:667
#2  0x000055555558e852 in multi_delete_dup (new_mi=3D0x5555556bf620,=20
    m=3D0x7fffffffc520) at multi.c:1382
#3  multi_connection_established (m=3Dm@...1851...=3D0x7fffffffc520,=20
    mi=3Dmi@...1851...=3D0x5555556bf620) at multi.c:1820
#4  0x000055555558fccd in multi_process_post (m=3Dm@...1851...=3D0x7fffffff=
c520,=20
    mi=3D0x5555556bf620, flags=3Dflags@...1851...=3D5) at multi.c:2404
#5  0x00005555555901d2 in multi_process_incoming_link (
    m=3Dm@...1851...=3D0x7fffffffc520, instance=3Dinstance@...1851...=3D0x0=
,=20
    mpp_flags=3Dmpp_flags@...1851...=3D5) at multi.c:2768
#6  0x000055555558a3dc in multi_process_io_udp (m=3D0x7fffffffc520) at mudp=
.c:231
#7  tunnel_server_udp_single_threaded (top=3D0x7fffffffd580) at mudp.c:356
#8  0x0000555555594fc9 in openvpn_main (argc=3D2, argv=3D0x7fffffffe588)
    at openvpn.c:309
#9  0x00007ffff7a86deb in __libc_start_main () from /lib64/libc.so.6
#10 0x000055555555e86a in _start () at mudp.c:63


Not sure what is happening here - that part of the code hasn't been=20
touched.  Still, a "master" server with the same config (no pools,
client ifconfig by means of ccd/ files) does not crash.


The ccd file looks like this:

--------------------------------------
vlan-pvid 200

# braucht explizites ifconfig*push wegen "kein pool"
ifconfig-push 10.204.4.10 255.255.255.0
ifconfig-ipv6-push fd00:abcd:204:4::a:10/64 fd00:abcd:204:4::1

# for 2.3
push "tun-ipv6"
--------------------------------------


Interesting enough, if I run "master" with the same config and do the
same things, with a breakpoint set on ifconfig_pool_release(), I get
a call that looks just the same:

Breakpoint 1, ifconfig_pool_release (pool=3D0x0, hand=3D-1, hard=3Dhard@...493...=
1851...=3Dfalse)
    at pool.c:277

... but continue'ing will just do that, not crash.



Ah. So trivial...

ifconfig_pool_release(struct ifconfig_pool *pool, ifconfig_pool_handle hand=
, con
...
    int pool_size =3D ifconfig_pool_size(pool);

    if (pool && hand >=3D 0 && hand < pool_size)


...
ifconfig_pool_size(const struct ifconfig_pool *pool)
...
    if (!pool->ipv4.enabled && !pool->ipv6.enabled)
    {
        return 0;
    }


... but if *neither* is enabled, "pool" actually is NULL...  so this
needs to become something like this

    if (pool =3D=3D NULL
        || (!pool->ipv4.enabled && !pool->ipv6.enabled) )
    {
        return 0;
    }


... which fixes the crash for good (all callers will verify that=20
"hand < size" etc.).

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--/JSPCXnUaGdgtX+H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe1NsvAAoJEB2Cnv7KVigSVM8L/0RC50TrIpQ0QQBNkiTqkeXG
McRip9JasGKLPBPiavd1yWHlyxWHfx9tb+lm3bUfc6hFzTYDZK+tXLLP8ALLKf7p
cm9jQh3WCGqGLdmyD2R6JIDzwLq5rVSPNXtjg1y1jyejDBAm3Fml4IblMUsx1bLQ
SOCjtPOBY+wSFb/g75e3juOX/cEOY61vpT1ry/0mQwyxf54QUwM61IobfpHzNZaF
5KW+vjJ0j0g4WxUSlgATgV/RfSW3ciUE9xM26j+qhckudBTKV3P77uylmXDRmfs5
a594NactvMGPT8QH743Njp39ZHrFiO8bNyKwPuvv01csbGb7ZbpcFT3nto/FrLPP
rMrOZy7CU1QrhKedUJKQo9SjFlTuxRa60v8gzepZZgaiYuw5V2AWKCSXDZDDxIUa
dK+VwdO0haBPWIhWZIoFyxJBg+e/E2Jz5sL0RbbljFdnSwoet3xKC5E6KQE10cHe
W5RDYtBvHm1wx9/s3oTKIZf7KDLghzBDDNcK8ffCSw==
=J74L
-----END PGP SIGNATURE-----

--/JSPCXnUaGdgtX+H--

