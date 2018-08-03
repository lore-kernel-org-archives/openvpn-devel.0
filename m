References: <e5bcbb69-2b69-4f57-c541-35dd403f6199@...1435...>
 <1533224779-13216-1-git-send-email-steffan.karger@...1435...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <4ff9b515-b65c-ddb4-30e5-03660cd9f245@...2181...>
Date: Fri, 3 Aug 2018 17:49:53 +0800
MIME-Version: 1.0
In-Reply-To: <1533224779-13216-1-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eaS30C6RD2kgqQZWhzQr24HOPBRdv3w0Y"
Subject: Re: [Openvpn-devel] [PATCH v4 1/7] Introduce buffer_write_file()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eaS30C6RD2kgqQZWhzQr24HOPBRdv3w0Y
Content-Type: multipart/mixed; boundary="vLQdO5uFfORRYBElp8gI4W7xWiIeR0ADE";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan.karger@...1435...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <4ff9b515-b65c-ddb4-30e5-03660cd9f245@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v4 1/7] Introduce buffer_write_file()
References: <e5bcbb69-2b69-4f57-c541-35dd403f6199@...1435...>
 <1533224779-13216-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1533224779-13216-1-git-send-email-steffan.karger@...1435...>

--vLQdO5uFfORRYBElp8gI4W7xWiIeR0ADE
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 02/08/18 23:46, Steffan Karger wrote:
> Rewrite buf_write_string_file to buffer_write_file, which is simpler to
> use and can deal with not-null-terminated strings.  Mostly implemented so
> this can be easily reused for tls-crypt-v2 (client) key files.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
> v3: split change out of "generate client key", reuse in write_key_file()
> v4: improve doxygen and error handling
>=20
>  src/openvpn/buffer.c | 31 ++++++++++++++++++++++++-------
>  src/openvpn/buffer.h | 12 ++++++++----
>  src/openvpn/crypto.c | 33 ++++++---------------------------
>  src/openvpn/crypto.h |  5 +++++
>  src/openvpn/init.c   |  4 ++++
>  5 files changed, 47 insertions(+), 38 deletions(-)
>=20
> diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
> index 0972139..7f540d7 100644
> --- a/src/openvpn/buffer.c
> +++ b/src/openvpn/buffer.c
> @@ -343,16 +343,33 @@ convert_to_one_line(struct buffer *buf)
>      }
>  }
>=20=20
> -/* NOTE: requires that string be null terminated */
> -void
> -buf_write_string_file(const struct buffer *buf, const char *filename, in=
t fd)
> +bool
> +buffer_write_file(const char *filename, const struct buffer *buf)
>  {
> -    const int len =3D strlen((char *) BPTR(buf));
> -    const int size =3D write(fd, BPTR(buf), len);
> -    if (size !=3D len)
> +    bool ret =3D false;
> +    int fd =3D platform_open(filename, O_CREAT | O_TRUNC | O_WRONLY,
> +                           S_IRUSR | S_IWUSR);
> +    if (fd =3D=3D -1)
> +    {
> +        msg(M_ERRNO, "Cannot open file '%s' for write", filename);
> +        goto cleanup;

While running some tests I realized that a failure in open() will cause
a double error because close() is performed with fd =3D -1. The result is:

$ ./src/openvpn/openvpn --genkey --secret /root/test.key
Fri Aug  3 17:35:46 2018 Cannot open file '/root/test.key' for write:
Permission denied (errno=3D13)
Fri Aug  3 17:35:46 2018 Close error on file /root/test.key: Bad file
descriptor (errno=3D9)
Fri Aug  3 17:35:46 2018 Failed to write key file
Fri Aug  3 17:35:46 2018 Exiting due to fatal error

As you can see we have two distinct errors, with the second being caused
by the first one.

I think this is one of those cases where in case of failure you just
return false rather than jumping to cleanup, because nothing has been
initialized yet.

The double error is harmless, but not very clean, especially because, no
matter why open() failed, errno will always be changed to EBADF.

(I think this also means that you can get rid of the label at all and
slightly restyle the code)


Cheers,


--=20
Antonio Quartulli


--vLQdO5uFfORRYBElp8gI4W7xWiIeR0ADE--

--eaS30C6RD2kgqQZWhzQr24HOPBRdv3w0Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAltkJUEACgkQB6U8WA7y
zXTafRAAuwZ+Z8DKAm+h8E5Ep2XncyZecLUPbiAp3XgH91CeU8wfbV20NJn2gXij
LmMI/DnFVQcPu5V8nXElmK6yq8lnIXDFB064xCLcxGPReT8+MPm7b1ypY2QN7KMD
DXRNxTfSUfKQh3+7v7IEiuL2xLQV71kYGJX/jQKaVsNDuLinxr7WxBYTE9fW8LWs
vnhzh0cixMXAUYJnM1K4X1VrlTeEvXGewB6yUrnt7/d4bhbgUPYp0oXiIaktqbDa
HO+mlMoiCXGq/RKluIw8nxuO8lJUpYJ6Alfn8q8SmaOXn9zyHY2hf0iARuUtW38Z
t7zLxrunNZ+vSbnRbAN0PyY+JVgZ0zK0RsHzaQZCbJiye7Ob84TSldeR4IPGOZmL
AqKtaDLcxJRDwq92GsortqR7nvsV8LDdAXhXNDyVWoIuFmRXRlqDRy9qDG6gZJ6x
+ahuyAokFnaFA1ldEYXomtWq34FajEmWfd4yQwKqez96LRTaUcmwJUBQQc3O5Uf3
1JuOvllnKqRXeESt0HSgb7JhAlv7eAbs7n2ofih/1D9BQ+yHPK/o2pDkcbtP5yLF
ym+hEgLn9sAZFUbjScZp7zK8PoHm+irlZ6HfZcb6njsWnyUyoZzrVPR1FYLyni9d
5nDwLEENdyZb1R726IKBrJFSPyNDw/DX4jI3vWybSj6WqIptpq8=
=r+tm
-----END PGP SIGNATURE-----

--eaS30C6RD2kgqQZWhzQr24HOPBRdv3w0Y--

