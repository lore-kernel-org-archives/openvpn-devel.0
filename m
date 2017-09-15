References: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <593d2d16-dca2-943b-e074-4f56eccb46df@...2181...>
Date: Fri, 15 Sep 2017 11:12:30 +0800
MIME-Version: 1.0
In-Reply-To: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WBOlgkUG8rR547Iv7oUffOKD9jOrbc05M"
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
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WBOlgkUG8rR547Iv7oUffOKD9jOrbc05M
Content-Type: multipart/mixed; boundary="NBqOQAqTtnr1mgtUDbDbNTRlLderAGH7i";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan.karger@...1435...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <593d2d16-dca2-943b-e074-4f56eccb46df@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Don't throw fatal errors from
 create_temp_file()
References: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>

--NBqOQAqTtnr1mgtUDbDbNTRlLderAGH7i
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

I just did a quick skim for now and I only have a codestyle comment below:

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
> +        }
> +        if (!c->c2.pf.enabled)
> +        {
> +            register_signal(c, SIGUSR1, "plugin-pf-init-failed");
>          }
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


The '||' should go at the beginning of the second line.



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

--=20
Antonio Quartulli


--NBqOQAqTtnr1mgtUDbDbNTRlLderAGH7i--

--WBOlgkUG8rR547Iv7oUffOKD9jOrbc05M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAlm7RSEACgkQ0+HICM1s
oFDBrw/+LfUOq0fUzdNLpKDL5y2q9i6qhMLULc1sGTxcEiILyxOh5CKznZ/tzjE0
aVtAZabdFYcA3zdTXYO4xEeMam1RUIAzwnP7eTv+vfccovAuBbMGWau1HnmmmKQW
nk+Z62YkgSoCmVvjQvKcMYqqjIMW6YOQBp/wVm1dCV/b+cc+I1HcRd79g4p0bxna
hYVm8Az4++IAbnJx6F05j5cc+B1Ce5RwAIQGNbLSlckrVmQ+6kTepyZfVLRafWfQ
ivC7grYlZ9m41PlFiI7uP5vLby096jS4ahMf5S8KUrIMKPHcd9dgflVWu+2PIDcH
V+gCH6g2fzavMsQZ3MwNN0l9TW+BACLGa1020ImiZytJzNqYcbpjMjfJYTDfMV72
r2Nn7FgWO93fdKP1xoqAUHG4hYdC+vGa3l8vhnJl6vNHHvFT6lJv2rgXksRP6Ilt
5A/CgWEKrQTNoep16NbqahjqzMfBfuf76FjCRQfeYO4g5fzuuwICmKHqn9qAck3w
BIZw/OhK0+zH9CyPWsz1COlf7zLhkahx7HcAymZhpLxufo+RrDMTcSBwIICL/nO9
HCoUvH9kaMlRNIcPeEpsuAuDEbHtDAqlUU8iahnQyGDR5TFt5nRDkwQkaH/rfA+X
7Jatp3wi8ZozC+DJxqUElBqZvPlo+r08KhvljalURu0pkD5uzXc=
=9g3I
-----END PGP SIGNATURE-----

--WBOlgkUG8rR547Iv7oUffOKD9jOrbc05M--

