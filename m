Date: Thu, 13 Apr 2023 16:12:32 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ZDgN0EzH2JSbWknT@...1296...>
References: <20230403131750.4730-1-gianmarco@...2726...>
 <20230404083226.18751-1-gianmarco@...2726...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="wFGy1QOmbS363i3Z"
Content-Disposition: inline
In-Reply-To: <20230404083226.18751-1-gianmarco@...2726...>
Subject: Re: [Openvpn-devel] [PATCH v3] Route: add support for user defined
 routing table
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gianmarco De Gregori <gianmarco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

--wFGy1QOmbS363i3Z
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Apr 04, 2023 at 10:32:26AM +0200, Gianmarco De Gregori wrote:
> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
> index 3798bc65..00419dce 100644
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -325,7 +325,6 @@ init_route(struct route_ipv4 *r,
>=20=20
>      CLEAR(*r);
>      r->option =3D ro;
> -
>      /* network */
>=20=20
>      if (!is_route_parm_defined(ro->network))
> @@ -437,6 +436,27 @@ init_route(struct route_ipv4 *r,
>=20=20
>      r->flags |=3D RT_DEFINED;
>=20=20
> +    /* routing table id */
> +
> +    r->table_id =3D 0;
> +    if (ro->table_id)
> +    {
> +        r->table_id =3D atoi(ro->table_id);
> +        if (r->table_id < 0)
> +        {
> +            msg(M_WARN, PACKAGE_NAME "ROUTE: routing table id for networ=
k %s (%s) must be >=3D 0",

Frank's comments alerted me to this, and this certainly is not the way
to approach it.  Syntax checking of the routing table ID must happen during
option parsing (options.c), not in init_route() - so, this function
should be able to rely on ro->table_id being an *int*, and properly
sanitized - "if set, the content is valid".

Same for IPv6, of course.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--wFGy1QOmbS363i3Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJkOA3QAAoJEB2Cnv7KVigSTOkMALA7Z7TtHoa1l33l8OxKshRu
D9cDAX0MT3R+mKxQO0Mjlo1CXapv7UCdhrZ76fB8qQz2GrFGwHl9WbmCaw6LofTq
kRIVt6d7co3cqB1SKcZxRakGB2B1peP0lgjTp0WPsTHhCT/juba8UOltwGBdEnWt
vxpioVr+S9+PSK9sjE6X3DY6mYYkNb7TXRqtDtOzYXi+NR0/vCQkPYzc/bTQb8k6
ZpBuNoca5vLHJqD2yYWTtbD4uWtwLE3iuEyqMRlf66ZkdA04urs21k6yBWL0AWvk
YRXXpoNfFGuEK+aK9IBO/C4iY3YGyeUQ2oMFEB1I23RN9/OLc9yt6fNsqdbJyVTR
So3IouKM7hpqGZKn8LquOCapIIuBtlXdM/PdDcT5Rq2vamK1UOWrcjrJuV0tAOUL
q/O3YLZQ1nPNtg7vMxaHZSaAYsE0m2wl2NuVB8ktL2U9rqHWEG1sg1lpc5yOveCu
lGx5s/iDfM3w2yKo0uGHuUTqzgEQ1XunWRx9jiGZcg==
=sjlF
-----END PGP SIGNATURE-----

--wFGy1QOmbS363i3Z--

