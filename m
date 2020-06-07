Date: Sun, 7 Jun 2020 12:59:39 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200607105939.GF1431@...1296...>
References: <20200530000600.1680-1-a@...2181...>
 <20200530000600.1680-8-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="s7TqmVsSjvGp/sBI"
Content-Disposition: inline
In-Reply-To: <20200530000600.1680-8-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v4 7/7] ipv6-pool: get rid of size
 constraint
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--s7TqmVsSjvGp/sBI
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, May 30, 2020 at 02:06:00AM +0200, Antonio Quartulli wrote:
>          o->ifconfig_ipv6_pool_defined =3D true;
> -        o->ifconfig_ipv6_pool_base =3D
> -            add_in6_addr( o->server_network_ipv6, 0x1000 );
> +        o->ifconfig_ipv6_pool_base =3D add_in6_addr(o->server_network_ip=
v6, 2);
>          o->ifconfig_ipv6_pool_netbits =3D o->server_netbits_ipv6;

Thinking more about this, I'm not totally happy with this particular
change.

Yes, it makes sense for smallish pools (/112 to /124) because there we
do not have room for "wasting addresses".

OTOH, changing this for an existing /64 pool - or anything "large enough
that 0x1000 addresses will not matter" - would change behaviour in existing=
=20
setups - that's one of the feedbacks I already received via Twitter on the
patchset

  https://twitter.com/tschaeferm/status/1266822120497188876


One of the notable things that it would break is our buildbot t_client
test environment - all clients would receive new v6 addresses, and since
one of the tests is "have I received what I expect?" this would cause
a buildbot explosion.


My idea would be to make this conditional on the pool size - if the size
is /64.../111, make it +0x1000 ("keep existing behaviour for large-enough
pools"), if it's /112.../124, make it +2

Thoughts?

gert

PS: the rest of the patch is fine
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--s7TqmVsSjvGp/sBI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe3MiaAAoJEB2Cnv7KVigS9YYL/R4i+pyyJKnvTsjbTAR3phH0
BgWScRBRCc++b5SSSJId6g9uDjtbz2Oiu3J/0dfTSZCEvUP/xkodElPnI1cAzzsY
JfKPrLtqHm8isma6k+jAxP3ASsIpUMGdTewUFNHlnTkJVtIfBZY91yZQrEbNS0D1
0L/2M2hsqA6Fn7ZltnbVZK8L0HHkMq+vJ1haeAD3q4I3NsomDdGq1zWun7KehoWM
NQ1NQoxOCfcASwIZkP6gmPLrlYh5u0Pl0JD9mHxT9vmpnC9PPkPNHmh/SdfVaWZ8
EsH1YWIS6933AJhUlbUgCEehlOE7RoKEL1s6RMXy4mGK6v50NIy3HS+0HQHYrVF4
OZNqXXJUZXn3/gIjQL0CGNwiiht8cylcGAYy+zM0qGtSBRV6fH6BZfMrKsoj4HCN
YRBY+R0aZNSDPpvFm1zdQ2KUbzUV69il7XLe8zPsG5jgqC8DTQ0J6ATGLREKg52G
bpVqXw0wanHBHquPlk10fz5IrJMLDYOQuWQ5H4zAMg==
=V4ho
-----END PGP SIGNATURE-----

--s7TqmVsSjvGp/sBI--

