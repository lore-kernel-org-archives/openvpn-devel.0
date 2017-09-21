References: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <97d5028c-4861-320b-c5ef-3e09de45e983@...2181...>
Date: Fri, 22 Sep 2017 01:15:35 +0800
MIME-Version: 1.0
In-Reply-To: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sqXuC8BsfdjsuO961uqAqo9HE2i9sE1pw"
Subject: Re: [Openvpn-devel] [PATCH 1/2] Don't throw fatal errors from
 create_temp_file()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sqXuC8BsfdjsuO961uqAqo9HE2i9sE1pw
Content-Type: multipart/mixed; boundary="baq4xU6jAQBVMCSC8mKqGCmhOSw1o7PgC";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <97d5028c-4861-320b-c5ef-3e09de45e983@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Don't throw fatal errors from
 create_temp_file()
References: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>

--baq4xU6jAQBVMCSC8mKqGCmhOSw1o7PgC
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 15/09/17 05:34, Steffan Karger wrote:
> This function is called in response to connecting clients, and can fail
> when I/O fails for some (possibly temporary) reason.  In such cases we
> should not exit the process, but just reject the connecting client.
>=20
> This commit changes the function to actually return NULL on errors, and
> (where needed) changes the callers to check for and handle errors.
>=20
> Note that this changes the behavior for pf plugins: instead of just not
> initializing the firewall rules and happily continuing, this now rejects
> the client in the case of an (unlikely) failure to initialize the pf.
>=20
> Since the tls-crypt-v2 metadata code also calls create_temp_file() when
> clients connect, I consider this a prerequisite for tls-crypt-v2.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
>  src/openvpn/misc.c       |  6 +++---
>  src/openvpn/pf.c         |  8 ++++----
>  src/openvpn/ssl_verify.c | 32 +++++++++++++++++++++-----------
>  3 files changed, 28 insertions(+), 18 deletions(-)
>=20
> diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
> index 8c7f611..25f3800 100644
> --- a/src/openvpn/misc.c
> +++ b/src/openvpn/misc.c
> @@ -740,7 +740,7 @@ create_temp_file(const char *directory, const char *p=
refix, struct gc_arena *gc)
>          retfname =3D gen_path(directory, BSTR(&fname), gc);
>          if (!retfname)
>          {
> -            msg(M_FATAL, "Failed to create temporary filename and path");
> +            msg(M_WARN, "Failed to create temporary filename and path");
>              return NULL;
>          }
>=20=20
> @@ -755,14 +755,14 @@ create_temp_file(const char *directory, const char =
*prefix, struct gc_arena *gc)
>          else if (fd =3D=3D -1 && errno !=3D EEXIST)
>          {
>              /* Something else went wrong, no need to retry.  */
> -            msg(M_FATAL | M_ERRNO, "Could not create temporary file '%s'=
",
> +            msg(M_WARN | M_ERRNO, "Could not create temporary file '%s'",
>                  retfname);
>              return NULL;
>          }
>      }
>      while (attempts < 6);
>=20=20
> -    msg(M_FATAL, "Failed to create temporary file after %i attempts", at=
tempts);
> +    msg(M_WARN, "Failed to create temporary file after %i attempts", att=
empts);
>      return NULL;
>  }
>=20=20
> diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
> index 5cb002b..5fe1734 100644
> --- a/src/openvpn/pf.c
> +++ b/src/openvpn/pf.c
> @@ -639,10 +639,10 @@ pf_init_context(struct context *c)
>                  }
>  #endif
>              }
> -            else
> -            {
> -                msg(M_WARN, "WARNING: OPENVPN_PLUGIN_ENABLE_PF disabled"=
);
> -            }

Why removing this chunk above? Isn't that supposed to be printed when
the init function of the plugin fails?

> +        }
> +        if (!c->c2.pf.enabled)
> +        {
> +            register_signal(c, SIGUSR1, "plugin-pf-init-failed");
>          }

Maybe it's just me missing how the signaling part really works, but what
happens on the server when the SIGUSR1 is delivered? And why registering
the signal when PF is disabled? I am missing something I think...

>      }
>  #endif /* ifdef PLUGIN_PF */
> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index 9cd36d7..df2736c 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
> @@ -547,14 +547,14 @@ verify_cert_export_cert(openvpn_x509_cert_t *peerce=
rt, const char *tmp_dir, stru
>      FILE *peercert_file;
>      const char *peercert_filename =3D "";
>=20=20
> -    if (!tmp_dir)
> +    /* create tmp file to store peer cert */
> +    if (!tmp_dir ||
> +        !(peercert_filename =3D create_temp_file(tmp_dir, "pcf", gc)))

|| at the beginning of the next line (as mentioned in my previous email)

>      {
> +        msg (M_WARN, "Failed to create peer cert file");
>          return NULL;
>      }
>=20=20
> -    /* create tmp file to store peer cert */
> -    peercert_filename =3D create_temp_file(tmp_dir, "pcf", gc);
> -
>      /* write peer-cert in tmp-file */
>      peercert_file =3D fopen(peercert_filename, "w+");
>      if (!peercert_file)
> @@ -589,10 +589,13 @@ verify_cert_call_command(const char *verify_command=
, struct env_set *es,
>=20=20
>      if (verify_export_cert)
>      {
> -        if ((tmp_file =3D verify_cert_export_cert(cert, verify_export_ce=
rt, &gc)))
> +        tmp_file =3D verify_cert_export_cert(cert, verify_export_cert, &=
gc);
> +        if (!tmp_file)
>          {
> -            setenv_str(es, "peer_cert", tmp_file);
> +            ret =3D false;
> +            goto cleanup;
>          }
> +        setenv_str(es, "peer_cert", tmp_file);
>      }
>=20=20
>      argv_parse_cmd(&argv, verify_command);
> @@ -609,6 +612,7 @@ verify_cert_call_command(const char *verify_command, =
struct env_set *es,
>          }
>      }
>=20=20
> +cleanup:
>      gc_free(&gc);
>      argv_reset(&argv);
>=20=20
> @@ -879,21 +883,21 @@ key_state_rm_auth_control_file(struct key_state *ks)
>      }
>  }
>=20=20
> -static void
> +static bool
>  key_state_gen_auth_control_file(struct key_state *ks, const struct tls_o=
ptions *opt)
>  {
>      struct gc_arena gc =3D gc_new();
> -    const char *acf;
>=20=20
>      key_state_rm_auth_control_file(ks);
> -    acf =3D create_temp_file(opt->tmp_dir, "acf", &gc);
> +    const char *acf =3D create_temp_file(opt->tmp_dir, "acf", &gc);
>      if (acf)
>      {
>          ks->auth_control_file =3D string_alloc(acf, NULL);
>          setenv_str(opt->es, "auth_control_file", ks->auth_control_file);
> -    } /* FIXME: Should have better error handling? */
> +    }
>=20=20
>      gc_free(&gc);
> +    return acf;
>  }
>=20=20
>  static unsigned int
> @@ -1184,7 +1188,12 @@ verify_user_pass_plugin(struct tls_session *sessio=
n, const struct user_pass *up,
>=20=20
>  #ifdef PLUGIN_DEF_AUTH
>          /* generate filename for deferred auth control file */
> -        key_state_gen_auth_control_file(ks, session->opt);
> +        if (!key_state_gen_auth_control_file(ks, session->opt))
> +        {
> +            msg (D_TLS_ERRORS, "TLS Auth Error (%s): "
> +                 "could not create deferred auth control file", __func__=
);
> +            goto cleanup;
> +        }
>  #endif
>=20=20
>          /* call command */
> @@ -1209,6 +1218,7 @@ verify_user_pass_plugin(struct tls_session *session=
, const struct user_pass *up,
>          msg(D_TLS_ERRORS, "TLS Auth Error (verify_user_pass_plugin): pee=
r provided a blank username");
>      }
>=20=20
> +cleanup:
>      return retval;
>  }
>=20=20
>=20

The rest looks good to me.

Cheers,


--=20
Antonio Quartulli


--baq4xU6jAQBVMCSC8mKqGCmhOSw1o7PgC--

--sqXuC8BsfdjsuO961uqAqo9HE2i9sE1pw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlnD87cACgkQB6U8WA7y
zXR/Ww//cUEIHTseMLchQXoDtGxZftj9tFIAYOseQu5M8VRQhDluSM0yQdETXCYg
uOISk0US8dE/YpvNGfSqEdRMdOVqhfsg689SuyMUU0hlyUNs0Nh39xys9bJyq9eC
0RX7zydrK7jMgbgpQYfk6nKHOYF1S5Zn6hPxwC7fWCS72nz957yX/TyBlr8X8BrO
drnDAteGlZImv0wPBVwYuvNbqcmV828NJY8kXOX8QUzEjLZwd9UNj6vSM2h4bVGG
JrBPzIcW+eQR0KRg+oEGoQmUQAhoQ/x57LTDNjwClqfVAov18annU9qZt2lU1BV3
llp7lrDQwPHiXWa9HmGJTJKWrMmJ103o8aPyy3KnNGnFR+HenynTHDxB3cJMV3QD
GvL8Hd0OpXbyGsOpJcDR4qgRlbJjjSSO6kORljCwsVlANaAIm7oGZgSft7wd6zre
J4n9Uvcf2/ewS8T4s3NzWX+rW2zL9HSxlqRQYExskVhCQqxCgPSmIKjpNI1JY2zp
iGSz6BTg+3ltMPHjcQJGS0g8Fe7QT04eCo1i4twoHVPgwQulEvoM22w53D6TWmZ1
VS8hMvw3bs8SaVOeZnVxbGvfmi2aLClxvgHkvjb+VYPrSjCshmSF8d4Ew3B+vunB
WhK+3/wGU5u0m/sZ3nOynsTQyEYeW5Zkk6TQPnN/WdVKK0cwu/U=
=5DQx
-----END PGP SIGNATURE-----

--sqXuC8BsfdjsuO961uqAqo9HE2i9sE1pw--

