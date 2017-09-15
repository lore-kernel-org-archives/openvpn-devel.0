References: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>
 <1505424872-27434-2-git-send-email-steffan.karger@...1435...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <c39d1e54-04f8-8ca3-34dc-5d023078286a@...2181...>
Date: Fri, 15 Sep 2017 11:14:19 +0800
MIME-Version: 1.0
In-Reply-To: <1505424872-27434-2-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cF6cHR50BJMPSL4trCBOP3P4WS6eea1kq"
Subject: Re: [Openvpn-devel] [PATCH 2/2] pf: clean up temporary files if
 plugin init fails
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
--cF6cHR50BJMPSL4trCBOP3P4WS6eea1kq
Content-Type: multipart/mixed; boundary="I6BPLQ6hFXswKBUdjtSqlIN1w4l9aG42H";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan.karger@...1435...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <c39d1e54-04f8-8ca3-34dc-5d023078286a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] pf: clean up temporary files if
 plugin init fails
References: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>
 <1505424872-27434-2-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1505424872-27434-2-git-send-email-steffan.karger@...1435...>

--I6BPLQ6hFXswKBUdjtSqlIN1w4l9aG42H
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 15/09/17 05:34, Steffan Karger wrote:
> close_instance() tries to remove the file in c2.pf.filename, but that only
> works if we actually set that if we fail.  So, set that filename as soon
> as we know we've created the file.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
>  src/openvpn/pf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
> index 5fe1734..3faaebd 100644
> --- a/src/openvpn/pf.c
> +++ b/src/openvpn/pf.c
> @@ -625,12 +625,12 @@ pf_init_context(struct context *c)
>          const char *pf_file =3D create_temp_file(c->options.tmp_dir, "pf=
", &gc);

what prevents us from calling create_temp_file() directly with
c->c2.pf.filename and &c->c2.gc as arguments?

Cheers,

>          if (pf_file)
>          {
> +            c->c2.pf.filename =3D string_alloc(pf_file, &c->c2.gc);
>              setenv_str(c->c2.es, "pf_file", pf_file);
>=20=20
>              if (plugin_call(c->plugins, OPENVPN_PLUGIN_ENABLE_PF, NULL, =
NULL, c->c2.es) =3D=3D OPENVPN_PLUGIN_FUNC_SUCCESS)
>              {
>                  event_timeout_init(&c->c2.pf.reload, 1, now);
> -                c->c2.pf.filename =3D string_alloc(pf_file, &c->c2.gc);
>                  c->c2.pf.enabled =3D true;
>  #ifdef ENABLE_DEBUG
>                  if (check_debug_level(D_PF_DEBUG))
>=20

--=20
Antonio Quartulli


--I6BPLQ6hFXswKBUdjtSqlIN1w4l9aG42H--

--cF6cHR50BJMPSL4trCBOP3P4WS6eea1kq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAlm7RYsACgkQ0+HICM1s
oFAEUA/+JjzXxFJsrjl9dfZiCvclqqWjKQA4adYotUe3eS58dN/jaISBLrJ1+FgK
7Qrks5l+9mfnB63lYPaXuIn0GivUYJ6i4gi7Q46rsD4p164A6PdwCP76WnSOMsu1
AU17YA3dCjuupUFzGcQTdMm/yY40BSO1fPEgR/Zx5SzZHGD0Is+PgyCJ67E48JRG
aMedhVZ7/LRcrrGXaxxCQlXH1LOE5IILvUJwFR3o76hvF18ei0QTFOQoHurpcBpN
grDdsVAIkixzjOSJK74OJfqn2sJbeMRXhVFxCbLwCa/QmjyDQxLogwRFjYeh0Xa6
s9cK+TR3inQ7jqICd3jPTR1qlerfzc5vC+fBB9JitxtuAMDKLaVC41XP8DxE8oDm
ghHnGWiHmSPjVHFkEnSfG9T1n5ZEhVHjPmX9kr6VeO2G8pzgWPAYHS4lrZOS00bm
vdmeqLGdJqY8csSa83v3/l+kpsTKLe3DB8IDBMJezLVNQ0iyJhUQ34m5dUEWV/2c
44cb+0Jh+JfIXYnpkYhpV3LC0Vm+E0Ha14RkkGuIyBY4Msm9UARXpCqxITyB/Bfj
9QGNx4IjQteUb18Q4QkNYD6vUE15IGpCHwVj1/93FDfFmP9uZDy4YaUEIKEg0JS7
j0OvUpFIs6uNvsF5NUhbSXZXci7EI3l40Q73Xku60kAYpeF9yus=
=dLOo
-----END PGP SIGNATURE-----

--cF6cHR50BJMPSL4trCBOP3P4WS6eea1kq--

