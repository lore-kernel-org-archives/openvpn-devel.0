References: <57ab9396-0960-f915-e1d8-2c4fe0906f2d@...2181...>
 <20170928155446.32382-1-steffan@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <c0a7b735-640b-23e3-c39f-96e8961fd25c@...2181...>
Date: Fri, 29 Sep 2017 10:51:35 +0800
MIME-Version: 1.0
In-Reply-To: <20170928155446.32382-1-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Mjn6xeNaJoHiXDWsx3DiLEPgV0aJeTqSp"
Subject: Re: [Openvpn-devel] [PATCH 3/2] create_temp_file: prevent memory
 leak if gc == NULL
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
--Mjn6xeNaJoHiXDWsx3DiLEPgV0aJeTqSp
Content-Type: multipart/mixed; boundary="7WFSpcgAGlPnp80UUPViNk2BXjQoJ6GJn";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <c0a7b735-640b-23e3-c39f-96e8961fd25c@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 3/2] create_temp_file: prevent memory leak
 if gc == NULL
References: <57ab9396-0960-f915-e1d8-2c4fe0906f2d@...2181...>
 <20170928155446.32382-1-steffan@...1856...>
In-Reply-To: <20170928155446.32382-1-steffan@...1856...>

--7WFSpcgAGlPnp80UUPViNk2BXjQoJ6GJn
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 28/09/17 23:54, Steffan Karger wrote:
> If gc =3D=3D NULL, the data allocated in the alloc_gc_buf() call would ne=
ver
> be free'd.  The function is never called that way, but let's prevent
> future problems.

Same problem exists with the invocation of gen_path() a few lines below:
it invokes string_mod_const() that invokes string_alloc(.., gc).

Would you fix that as well? Under the same umbrella patch maybe?

>=20
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
>  src/openvpn/misc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
> index 90632706..86f80a6a 100644
> --- a/src/openvpn/misc.c
> +++ b/src/openvpn/misc.c
> @@ -724,10 +724,13 @@ const char *
>  create_temp_file(const char *directory, const char *prefix, struct gc_ar=
ena *gc)
>  {
>      static unsigned int counter;
> -    struct buffer fname =3D alloc_buf_gc(256, gc);
>      int fd;
>      const char *retfname =3D NULL;
>      unsigned int attempts =3D 0;
> +    struct buffer fname =3D (struct buffer) { 0 };
> +    char buf_data[256] =3D { 0 };
> +
> +    buf_set_write(&fname, buf_data, sizeof(buf_data));

This buffer is really only used to create a filename and then it's
passed to gen_path().

Is it really worth creating a struct buffer, embedding a string and then
extrapolating the string again to call gen_path()?

How about directly using the string directly?

The only argument against this approach I can see is that buf_printf()
does all the checks for us, while if we switch to a snprintf() we need
to add a one-line-check to ensure the resulting string could fit fname.

What do you think?
I am just trying to simplify the code while at it ..


Cheers,

--=20
Antonio Quartulli


--7WFSpcgAGlPnp80UUPViNk2BXjQoJ6GJn--

--Mjn6xeNaJoHiXDWsx3DiLEPgV0aJeTqSp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlnNtTcACgkQB6U8WA7y
zXToaw/9E+j0RprkDRQGvl2XQZ/7K//2ipTbiColRMW5XtoMPW474KGFVcC0isSI
C/SV46LA88hzl6kZUmo7oUO9JUR5dyac/demlJMdAJRzPQnC2z4Zggde5zOh2azl
/ya4ZRwC7BkTI/+bw9W7OZaT9gn39+P2fKjnubsMlBIPPQBNsD7QiwgAHS+Agki8
KYXkCaDStYcbEnykERlIo629dxIU3RBu2wUsX5vS4CSz4Rm7HlPqXYBpd6VJYmO8
ya9eXg8NBEh8FLRVX28N6YerIWoCxfUc1lfiA6hTmSPRM5uIHlcpOpIPhCKQos5Y
DljnmJH1p7CcGYsv6/DR2fU1g+E+UO0D9o0EpNCKg/8m4qvKsJfNTtBKEhVjwmFf
3MJP0137UA/gZcKJIdwRxeJ1CG2dye+Oxs6IsR3p+V9XE5mv/q+W76U6wpxV5d8L
Ohs1YlVNIqZGyiXVVDzesHy74fJpccojiwX1tiqPWfcCjL6Pyy5Ib1eqbotHilTv
cAYZeDIoL+p58Bfu0nF/pXEkeQCjUontNXPlj+4xWPDfr4g7DTie74/NYXb132vp
npvi6Z2l4RljVEw1dX/4hkqktdO6bkLeX780C5Skk6vXeHgZvziGYvCWG9BXqHGm
APYQesB3ITtKRkKDjeYh1Np22uajreJhtplmkmWtkeWLkph0ws8=
=L3Rk
-----END PGP SIGNATURE-----

--Mjn6xeNaJoHiXDWsx3DiLEPgV0aJeTqSp--

