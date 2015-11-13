Date: Fri, 13 Nov 2015 08:38:02 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151113073802.GK24952@...1296...>
References: <1447382487-26031-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Tln/wzp9jsNjmSUr"
Content-Disposition: inline
In-Reply-To: <1447382487-26031-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Do not hard-code windows systemroot in
 env_block
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--Tln/wzp9jsNjmSUr
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Nov 12, 2015 at 09:41:27PM -0500, Selva Nair wrote:
> FWIW, fixes trac #500
>=20
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  src/openvpn/win32.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
> index 7c89a5a..d06b41f 100644
> --- a/src/openvpn/win32.c
> +++ b/src/openvpn/win32.c
> @@ -763,7 +763,12 @@ win_safe_filename (const char *fn)
>  static char *
>  env_block (const struct env_set *es)
>  {
> -  char * force_path =3D "PATH=3DC:\\Windows\\System32;C:\\WINDOWS;C:\\WI=
NDOWS\\System32\\Wbem";
> +  char force_path[256];
> +  char *sysroot =3D get_win_sys_path();
> +
> +  if (!openvpn_snprintf(force_path, sizeof(force_path), "PATH=3D%s\\Syst=
em32;%s;%s\\System32\\Wbem",
> +                        sysroot, sysroot, sysroot))
> +    msg(M_WARN, "env_block: default path truncated to %s", force_path);

Cool :-)

This bug was nagging me since quite a while, but I did not know how
to read the "correct" windows path - and didn't know about get_win_sys_path=
().

OTOH, I'm not sure if this is going to work - win_sys_path is (unless
set from options.c) initialized via=20

  GetEnvironmentVariable (SYS_PATH_ENV_VAR_NAME, buf, sizeof(buf)
  set_win_sys_path (buf, es);

... and that is likely to contain more than "c:\windows", but "a number
of path elements"...  so it's not really "sysroot".

What am I missing?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Tln/wzp9jsNjmSUr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVkWTWqkuBuNlUUl1AQL8MAP8C9qsp9PTBE5wnQbB3L/Ut9pyO9NPm0r+
Ug1UsC4tpOowBFbl6E+xTxOGhZ+4WICsY6ZV6xlsoDhXU7EuJNy7fQe1KfNmbMaa
N+KLgvghwFXXPw50AcaluZo9OpABXKmQYtLq4Fg6Z2/axqFBVDHbFUzjghN8BcGQ
YSNiFc8YSgY=
=n+hj
-----END PGP SIGNATURE-----

--Tln/wzp9jsNjmSUr--

