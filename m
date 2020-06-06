Date: Sat, 6 Jun 2020 17:26:43 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200606152643.GA1431@...1296...>
References: <20200530000600.1680-1-a@...2181...>
 <20200530000600.1680-5-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="fTRfx/eO6wEPA8kv"
Content-Disposition: inline
In-Reply-To: <20200530000600.1680-5-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v4 4/7] pool: add support for
 ifconfig-pool-persist with IPv6 only
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

--fTRfx/eO6wEPA8kv
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

HI,

On Sat, May 30, 2020 at 02:05:57AM +0200, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@...515...>
>=20
> Without altering the pool logic, this patch enables using
> a persistent IP pool also when the server is configured
> with IPv6 only.
>=20
> Trac: #208
> Signed-off-by: Antonio Quartulli <antonio@...515...>

NAK, as discussed on IRC, because this breaks (surprisingly) persistent
pools for IPv4-only pools.

(An ipp.txt entry of just "CN,IPv4" will not pass the 3rd buf_parse()
call, and thus be ignored as "malformed" - so pool assignments are lost
at every server restart)

The rest of the code looks good, and it seems to work correctly on the
t_server setup.


While at it, one cosmetic change:

> @@ -459,23 +525,26 @@ ifconfig_pool_list(const struct ifconfig_pool *pool=
, struct status_output *out)
>          for (i =3D 0; i < pool_size; ++i)
>          {
>              const struct ifconfig_pool_entry *e =3D &pool->list[i];
> +            struct in6_addr ip6;
> +            in_addr_t ip;

I find these two declarations a bit awkward - they are "in a block",
but it's not "the block where they are needed"... the old code had
on-the-fly declarations

> -                const in_addr_t ip =3D ifconfig_pool_handle_to_ip_base(p=
ool, i);
...
> -                    struct in6_addr ip6 =3D ifconfig_pool_handle_to_ipv6=
_base(pool, i);

which, I assume, you removed due to line length considerations?


This is not a reason for NAKing, though.  Just something I found surprising.

thanks :)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--fTRfx/eO6wEPA8kv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe27WyAAoJEB2Cnv7KVigS3fIL/jPCs/sRPVkfknBpgbXdREVK
JYs/CpMC5Q4oOE/RPkt7gKXx/ofwv3CmDAOjVXifnvqOW2JDQnKGuz4fDt2UcA6L
IQJ5zdDfz4rqK1wkVDA0R6Crnzkha4D9KxXw2pvY4MZJpEa3ccPwcQB5OV4QB6YD
G5KuizA+bgNtKFFhvgGyWIjjfg7TbJ2kEsLOrUkRqvbiTCE/Yj1q9bGIUUeebMjw
YF4HFnIdD3LTqLpDF0CxsHevRyUN7QQ5BqvAbCMl/uYvXzEVXZ3kh0HsrazirPhA
0BZIee+gbf1KykUxVZhyhbMAuMOcxNXZ9FTD320HdLpWXz+cDPIK7Fi+An7poDxM
v5EkeYybMUwz14aNhruWmpe/8lOQPhFq/ilUFhjCJtQM+shr2WPMDZqPKbe5hrZa
QWqq6DKsdpWTnPWM+iKJxcXz+Pe6D45qNdiZcTKGHptP82h0jcQpYgkCCnJhVvdA
b+BzK8vrX4T2nMAUQZ0mzzvkywPx1/EHcyhoQ2AFqg==
=axID
-----END PGP SIGNATURE-----

--fTRfx/eO6wEPA8kv--

