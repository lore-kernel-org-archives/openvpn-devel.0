MIME-Version: 1.0
In-Reply-To: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>
References: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>
From: "sameer.s.athaley" <sameera.athaley@...277...>
Date: Thu, 21 Sep 2017 22:52:50 +0530
Message-ID: <CADtuLXQk_H7W_YTVz722445BWn1E1S1Y3fTvd2x4XYEMaqSP3Q@...278...>
Content-Type: multipart/alternative; boundary="94eb2c1a5fd88a28460559b657f2"
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

--94eb2c1a5fd88a28460559b657f2
Content-Type: text/plain; charset="UTF-8"

Please stop sending me mails u fools, this is not unsubscribing fed up of
this.
Remove my mail I'd for GOD sacks

On 15-Sep-2017 3:05 AM, "Steffan Karger" <steffan.karger@...1435...> wrote:

> This function is called in response to connecting clients, and can fail
> when I/O fails for some (possibly temporary) reason.  In such cases we
> should not exit the process, but just reject the connecting client.
>
> This commit changes the function to actually return NULL on errors, and
> (where needed) changes the callers to check for and handle errors.
>
> Note that this changes the behavior for pf plugins: instead of just not
> initializing the firewall rules and happily continuing, this now rejects
> the client in the case of an (unlikely) failure to initialize the pf.
>
> Since the tls-crypt-v2 metadata code also calls create_temp_file() when
> clients connect, I consider this a prerequisite for tls-crypt-v2.
>
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
>  src/openvpn/misc.c       |  6 +++---
>  src/openvpn/pf.c         |  8 ++++----
>  src/openvpn/ssl_verify.c | 32 +++++++++++++++++++++-----------
>  3 files changed, 28 insertions(+), 18 deletions(-)
>
> diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
> index 8c7f611..25f3800 100644
> --- a/src/openvpn/misc.c
> +++ b/src/openvpn/misc.c
> @@ -740,7 +740,7 @@ create_temp_file(const char *directory, const char
> *prefix, struct gc_arena *gc)
>          retfname = gen_path(directory, BSTR(&fname), gc);
>          if (!retfname)
>          {
> -            msg(M_FATAL, "Failed to create temporary filename and path");
> +            msg(M_WARN, "Failed to create temporary filename and path");
>              return NULL;
>          }
>
> @@ -755,14 +755,14 @@ create_temp_file(const char *directory, const char
> *prefix, struct gc_arena *gc)
>          else if (fd == -1 && errno != EEXIST)
>          {
>              /* Something else went wrong, no need to retry.  */
> -            msg(M_FATAL | M_ERRNO, "Could not create temporary file '%s'",
> +            msg(M_WARN | M_ERRNO, "Could not create temporary file '%s'",
>                  retfname);
>              return NULL;
>          }
>      }
>      while (attempts < 6);
>
> -    msg(M_FATAL, "Failed to create temporary file after %i attempts",
> attempts);
> +    msg(M_WARN, "Failed to create temporary file after %i attempts",
> attempts);
>      return NULL;
>  }
>
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
> -                msg(M_WARN, "WARNING: OPENVPN_PLUGIN_ENABLE_PF disabled");
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
> @@ -547,14 +547,14 @@ verify_cert_export_cert(openvpn_x509_cert_t
> *peercert, const char *tmp_dir, stru
>      FILE *peercert_file;
>      const char *peercert_filename = "";
>
> -    if (!tmp_dir)
> +    /* create tmp file to store peer cert */
> +    if (!tmp_dir ||
> +        !(peercert_filename = create_temp_file(tmp_dir, "pcf", gc)))
>      {
> +        msg (M_WARN, "Failed to create peer cert file");
>          return NULL;
>      }
>
> -    /* create tmp file to store peer cert */
> -    peercert_filename = create_temp_file(tmp_dir, "pcf", gc);
> -
>      /* write peer-cert in tmp-file */
>      peercert_file = fopen(peercert_filename, "w+");
>      if (!peercert_file)
> @@ -589,10 +589,13 @@ verify_cert_call_command(const char *verify_command,
> struct env_set *es,
>
>      if (verify_export_cert)
>      {
> -        if ((tmp_file = verify_cert_export_cert(cert, verify_export_cert,
> &gc)))
> +        tmp_file = verify_cert_export_cert(cert, verify_export_cert, &gc);
> +        if (!tmp_file)
>          {
> -            setenv_str(es, "peer_cert", tmp_file);
> +            ret = false;
> +            goto cleanup;
>          }
> +        setenv_str(es, "peer_cert", tmp_file);
>      }
>
>      argv_parse_cmd(&argv, verify_command);
> @@ -609,6 +612,7 @@ verify_cert_call_command(const char *verify_command,
> struct env_set *es,
>          }
>      }
>
> +cleanup:
>      gc_free(&gc);
>      argv_reset(&argv);
>
> @@ -879,21 +883,21 @@ key_state_rm_auth_control_file(struct key_state *ks)
>      }
>  }
>
> -static void
> +static bool
>  key_state_gen_auth_control_file(struct key_state *ks, const struct
> tls_options *opt)
>  {
>      struct gc_arena gc = gc_new();
> -    const char *acf;
>
>      key_state_rm_auth_control_file(ks);
> -    acf = create_temp_file(opt->tmp_dir, "acf", &gc);
> +    const char *acf = create_temp_file(opt->tmp_dir, "acf", &gc);
>      if (acf)
>      {
>          ks->auth_control_file = string_alloc(acf, NULL);
>          setenv_str(opt->es, "auth_control_file", ks->auth_control_file);
> -    } /* FIXME: Should have better error handling? */
> +    }
>
>      gc_free(&gc);
> +    return acf;
>  }
>
>  static unsigned int
> @@ -1184,7 +1188,12 @@ verify_user_pass_plugin(struct tls_session
> *session, const struct user_pass *up,
>
>  #ifdef PLUGIN_DEF_AUTH
>          /* generate filename for deferred auth control file */
> -        key_state_gen_auth_control_file(ks, session->opt);
> +        if (!key_state_gen_auth_control_file(ks, session->opt))
> +        {
> +            msg (D_TLS_ERRORS, "TLS Auth Error (%s): "
> +                 "could not create deferred auth control file", __func__);
> +            goto cleanup;
> +        }
>  #endif
>
>          /* call command */
> @@ -1209,6 +1218,7 @@ verify_user_pass_plugin(struct tls_session *session,
> const struct user_pass *up,
>          msg(D_TLS_ERRORS, "TLS Auth Error (verify_user_pass_plugin): peer
> provided a blank username");
>      }
>
> +cleanup:
>      return retval;
>  }
>
> --
> 2.7.4
>
>
> ------------------------------------------------------------
> ------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--94eb2c1a5fd88a28460559b657f2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Please stop sending me mails u fools, this is not unsubsc=
ribing fed up of this.<div dir=3D"auto">Remove my mail I&#39;d for GOD sack=
s</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On 1=
5-Sep-2017 3:05 AM, &quot;Steffan Karger&quot; &lt;<a href=3D"mailto:steffa=
n.karger@...1435...">steffan.karger@...1435...</a>&gt; wrote:<br type=3D"at=
tribution"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">This function is called in respon=
se to connecting clients, and can fail<br>
when I/O fails for some (possibly temporary) reason.=C2=A0 In such cases we=
<br>
should not exit the process, but just reject the connecting client.<br>
<br>
This commit changes the function to actually return NULL on errors, and<br>
(where needed) changes the callers to check for and handle errors.<br>
<br>
Note that this changes the behavior for pf plugins: instead of just not<br>
initializing the firewall rules and happily continuing, this now rejects<br>
the client in the case of an (unlikely) failure to initialize the pf.<br>
<br>
Since the tls-crypt-v2 metadata code also calls create_temp_file() when<br>
clients connect, I consider this a prerequisite for tls-crypt-v2.<br>
<br>
Signed-off-by: Steffan Karger &lt;<a href=3D"mailto:steffan.karger@...2191...=
..">steffan.karger@...1435...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/misc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6 +++---<br>
=C2=A0src/openvpn/pf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 8 ++++----<=
br>
=C2=A0src/openvpn/ssl_verify.c | 32 +++++++++++++++++++++---------<wbr>--<b=
r>
=C2=A03 files changed, 28 insertions(+), 18 deletions(-)<br>
<br>
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c<br>
index 8c7f611..25f3800 100644<br>
--- a/src/openvpn/misc.c<br>
+++ b/src/openvpn/misc.c<br>
@@ -740,7 +740,7 @@ create_temp_file(const char *directory, const char *pre=
fix, struct gc_arena *gc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retfname =3D gen_path(directory, BSTR(&am=
p;fname), gc);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!retfname)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_FATAL, &quot;Failed to cre=
ate temporary filename and path&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN, &quot;Failed to crea=
te temporary filename and path&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -755,14 +755,14 @@ create_temp_file(const char *directory, const char *p=
refix, struct gc_arena *gc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (fd =3D=3D -1 &amp;&amp; errno !=
=3D EEXIST)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Something else went wron=
g, no need to retry.=C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_FATAL | M_ERRNO, &quot;Cou=
ld not create temporary file &#39;%s&#39;&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN | M_ERRNO, &quot;Coul=
d not create temporary file &#39;%s&#39;&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retfname);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0while (attempts &lt; 6);<br>
<br>
-=C2=A0 =C2=A0 msg(M_FATAL, &quot;Failed to create temporary file after %i =
attempts&quot;, attempts);<br>
+=C2=A0 =C2=A0 msg(M_WARN, &quot;Failed to create temporary file after %i a=
ttempts&quot;, attempts);<br>
=C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0}<br>
<br>
diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c<br>
index 5cb002b..5fe1734 100644<br>
--- a/src/openvpn/pf.c<br>
+++ b/src/openvpn/pf.c<br>
@@ -639,10 +639,10 @@ pf_init_context(struct context *c)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_WARN, &quot;=
WARNING: OPENVPN_PLUGIN_ENABLE_PF disabled&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!c-&gt;c2.pf.enabled)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 register_signal(c, SIGUSR1, &quo=
t;plugin-pf-init-failed&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#endif /* ifdef PLUGIN_PF */<br>
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c<br>
index 9cd36d7..df2736c 100644<br>
--- a/src/openvpn/ssl_verify.c<br>
+++ b/src/openvpn/ssl_verify.c<br>
@@ -547,14 +547,14 @@ verify_cert_export_cert(<wbr>openvpn_x509_cert_t *pee=
rcert, const char *tmp_dir, stru<br>
=C2=A0 =C2=A0 =C2=A0FILE *peercert_file;<br>
=C2=A0 =C2=A0 =C2=A0const char *peercert_filename =3D &quot;&quot;;<br>
<br>
-=C2=A0 =C2=A0 if (!tmp_dir)<br>
+=C2=A0 =C2=A0 /* create tmp file to store peer cert */<br>
+=C2=A0 =C2=A0 if (!tmp_dir ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 !(peercert_filename =3D create_temp_file(tmp_d=
ir, &quot;pcf&quot;, gc)))<br>
=C2=A0 =C2=A0 =C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (M_WARN, &quot;Failed to create peer cert =
file&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 /* create tmp file to store peer cert */<br>
-=C2=A0 =C2=A0 peercert_filename =3D create_temp_file(tmp_dir, &quot;pcf&qu=
ot;, gc);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0/* write peer-cert in tmp-file */<br>
=C2=A0 =C2=A0 =C2=A0peercert_file =3D fopen(peercert_filename, &quot;w+&quo=
t;);<br>
=C2=A0 =C2=A0 =C2=A0if (!peercert_file)<br>
@@ -589,10 +589,13 @@ verify_cert_call_command(const char *verify_command, =
struct env_set *es,<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (verify_export_cert)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((tmp_file =3D verify_cert_export_cert(cert=
, verify_export_cert, &amp;gc)))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 tmp_file =3D verify_cert_export_cert(cert, ver=
ify_export_cert, &amp;gc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!tmp_file)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 setenv_str(es, &quot;peer_cert&q=
uot;, tmp_file);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 setenv_str(es, &quot;peer_cert&quot;, tmp_file=
);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0argv_parse_cmd(&amp;argv, verify_command);<br>
@@ -609,6 +612,7 @@ verify_cert_call_command(const char *verify_command, st=
ruct env_set *es,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+cleanup:<br>
=C2=A0 =C2=A0 =C2=A0gc_free(&amp;gc);<br>
=C2=A0 =C2=A0 =C2=A0argv_reset(&amp;argv);<br>
<br>
@@ -879,21 +883,21 @@ key_state_rm_auth_control_<wbr>file(struct key_state =
*ks)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-static void<br>
+static bool<br>
=C2=A0key_state_gen_auth_control_<wbr>file(struct key_state *ks, const stru=
ct tls_options *opt)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0struct gc_arena gc =3D gc_new();<br>
-=C2=A0 =C2=A0 const char *acf;<br>
<br>
=C2=A0 =C2=A0 =C2=A0key_state_rm_auth_control_<wbr>file(ks);<br>
-=C2=A0 =C2=A0 acf =3D create_temp_file(opt-&gt;tmp_dir, &quot;acf&quot;, &=
amp;gc);<br>
+=C2=A0 =C2=A0 const char *acf =3D create_temp_file(opt-&gt;tmp_dir, &quot;=
acf&quot;, &amp;gc);<br>
=C2=A0 =C2=A0 =C2=A0if (acf)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ks-&gt;auth_control_file =3D string_alloc=
(acf, NULL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0setenv_str(opt-&gt;es, &quot;auth_control=
_file&quot;, ks-&gt;auth_control_file);<br>
-=C2=A0 =C2=A0 } /* FIXME: Should have better error handling? */<br>
+=C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0gc_free(&amp;gc);<br>
+=C2=A0 =C2=A0 return acf;<br>
=C2=A0}<br>
<br>
=C2=A0static unsigned int<br>
@@ -1184,7 +1188,12 @@ verify_user_pass_plugin(struct tls_session *session,=
 const struct user_pass *up,<br>
<br>
=C2=A0#ifdef PLUGIN_DEF_AUTH<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* generate filename for deferred auth co=
ntrol file */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 key_state_gen_auth_control_<wbr>file(ks, sessi=
on-&gt;opt);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!key_state_gen_auth_control_<wbr>file(ks, =
session-&gt;opt))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (D_TLS_ERRORS, &quot;TLS Aut=
h Error (%s): &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;could =
not create deferred auth control file&quot;, __func__);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto cleanup;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0#endif<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* call command */<br>
@@ -1209,6 +1218,7 @@ verify_user_pass_plugin(struct tls_session *session, =
const struct user_pass *up,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(D_TLS_ERRORS, &quot;TLS Auth Error (v=
erify_user_pass_plugin): peer provided a blank username&quot;);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+cleanup:<br>
=C2=A0 =C2=A0 =C2=A0return retval;<br>
=C2=A0}<br>
<br>
--<br>
2.7.4<br>
<br>
<br>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, Slashdot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
</blockquote></div></div>

--94eb2c1a5fd88a28460559b657f2--

