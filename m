References: <c0a7b735-640b-23e3-c39f-96e8961fd25c@...2181...>
 <20170929161025.13654-1-steffan@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <7dab664f-db8a-ee66-3391-f88a04b9350e@...2181...>
Date: Sat, 30 Sep 2017 08:48:58 +0800
MIME-Version: 1.0
In-Reply-To: <20170929161025.13654-1-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pv4akjPTGvfx5DSrT2A928EE0XjqcGwg5"
Subject: Re: [Openvpn-devel] [PATCH v2] create_temp_file/gen_path: prevent
 memory leak if gc == NULL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pv4akjPTGvfx5DSrT2A928EE0XjqcGwg5
Content-Type: multipart/mixed; boundary="RxtPUS322NKtHqXQkD7n2auxDednxpAq3";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <7dab664f-db8a-ee66-3391-f88a04b9350e@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2] create_temp_file/gen_path: prevent
 memory leak if gc == NULL
References: <c0a7b735-640b-23e3-c39f-96e8961fd25c@...2181...>
 <20170929161025.13654-1-steffan@...1856...>
In-Reply-To: <20170929161025.13654-1-steffan@...1856...>

--RxtPUS322NKtHqXQkD7n2auxDednxpAq3
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 30/09/17 00:10, Steffan Karger wrote:
> If gc =3D=3D NULL, the data allocated in the alloc_gc_buf() call in
> create_temp_file or the string_mod_const call in gen_path would never
> be free'd.
>=20
> These functions are currently never called that way, but let's prevent
> future problems.
>=20
> While touching create_temp_file, also remove the counter variable, which =
is
> never read.
>=20
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
> v2:
>  - change create_temp_file to avoid using a struct buffer (simpler)
>  - add gc !=3D NULL check for gen_path (avoid similar memleak pitfall)
>=20
>  src/openvpn/misc.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>=20
> diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
> index 90632706..b6f92526 100644
> --- a/src/openvpn/misc.c
> +++ b/src/openvpn/misc.c
> @@ -723,21 +723,20 @@ test_file(const char *filename)
>  const char *
>  create_temp_file(const char *directory, const char *prefix, struct gc_ar=
ena *gc)
>  {
> -    static unsigned int counter;
> -    struct buffer fname =3D alloc_buf_gc(256, gc);
>      int fd;
>      const char *retfname =3D NULL;
>      unsigned int attempts =3D 0;
> +    char fname[256] =3D { 0 };
>=20=20
>      do
>      {
>          ++attempts;
> -        ++counter;
>=20=20
> -        buf_printf(&fname, PACKAGE "_%s_%08lx%08lx.tmp", prefix,
> -                   (unsigned long) get_random(), (unsigned long) get_ran=
dom());
> +        openvpn_snprintf(fname, sizeof(fname), PACKAGE "_%s_%08lx%08lx.t=
mp",
> +                         prefix, (unsigned long) get_random(),
> +                         (unsigned long) get_random());

Minor thought: do we want to check if the return value of snprintf is >=3D
sizeof(fname)? That would tell us if the string did not entirely fit in
the buffer so that we can abort the whole file creation.

Cheers,

>=20=20
> -        retfname =3D gen_path(directory, BSTR(&fname), gc);
> +        retfname =3D gen_path(directory, fname, gc);
>          if (!retfname)
>          {
>              msg(M_WARN, "Failed to create temporary filename and path");
> @@ -812,6 +811,12 @@ gen_path(const char *directory, const char *filename=
, struct gc_arena *gc)
>  #else
>      const int CC_PATH_RESERVED =3D CC_SLASH;
>  #endif
> +
> +    if (!gc)
> +    {
> +        return NULL; /* Would leak memory otherwise */
> +    }
> +
>      const char *safe_filename =3D string_mod_const(filename, CC_PRINT, C=
C_PATH_RESERVED, '_', gc);
>=20=20
>      if (safe_filename
>=20

--=20
Antonio Quartulli


--RxtPUS322NKtHqXQkD7n2auxDednxpAq3--

--pv4akjPTGvfx5DSrT2A928EE0XjqcGwg5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlnO6f0ACgkQB6U8WA7y
zXSoww//clr02K5WDJcn5k/QvFKMP8twJVg1/tL46Akz8ylIC+FtAy+iCTIWHRyc
kG238TZRffhsYEngTQwR/K0YeloHAHZ0PHYjS3kC8sXTOJfP3inkUfLbxradig/d
EeXF6PGfnbqwgVwOgFMmHH5bUunzj9Zk7GQv32eemLepO2PIfqTKLi6aVw+h3RhX
ZI27CMiWt+cUhBr0HANIqzxyQPp1C6eGHfcvI7djzpUJHH1PD1Z/WjL4fLfWs96r
Sm4yOo4S3HZ3gjQYEul1JBV4KW3qxMJvRw1Btm3vK1y7U2d1aOs3nstDsBSH+hGS
x9HOilHs2LG2JSePMZqKvvx+kFl4tX3zMqU4+7hcm0ZvJBlnljVPfae3K+VMHtA4
8LJWazkHHdiCAztZ46UmHIGCC5IqFeyqJRVmPyJuFRfNOii6A2BS+FqNWDDIluiW
5mW80/Prdv5vtU6TPnW7g+NxegdfvzyLgYJ5xWO4zlNpoHARVJqNyzkwTWSR8Z+x
VLL1Dk4WRgTsj3HjqqYphYUDQ51fz/BN5EJN9WN8XIkyFhdg43jV4Av+4zZx35FO
tSM5abv6U8chXTzCF0W7Rz/V9MuGVRMUxoLh2nqbDHhlgA3wNIsrZtojDyBNspY8
QkBAdHzBJYUdXokqzXyAo7v6+12S4xaqnaLxYF/Dhvs0KZ2C87U=
=7Vpe
-----END PGP SIGNATURE-----

--pv4akjPTGvfx5DSrT2A928EE0XjqcGwg5--

