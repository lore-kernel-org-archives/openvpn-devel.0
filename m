MIME-Version: 1.0
References: <20220310115718.11188-1-gert@...1296...>
In-Reply-To: <20220310115718.11188-1-gert@...1296...>
From: Pete Nelson <petiepooo@...277...>
Date: Thu, 10 Mar 2022 13:57:01 +0000
Message-ID: <CAAYFXLmCztuh1AZHzdGW=3cKM9g5GjaEWy4pBWzbsaGsp7ri+w@...278...>
Content-Type: multipart/alternative; boundary="000000000000416eba05d9dd9789"
Subject: Re: [Openvpn-devel] [PATCH] Enable deferred auth for multiple
 plugins (RFC).
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--000000000000416eba05d9dd9789
Content-Type: text/plain; charset="UTF-8"

One of the behaviors that brought this to light was a user who had an LDAP
(non-deferred) plugin followed by a Duo MFA (deferred) plugin.  He noted
that, even if the LDAP call returned failure, the Duo plugin was still
called.  That would generate a push notification to his phone even though
the authentication was already destined to fail due to LDAP.  It looks like
this patch returns failure when the first plugin fails, so would resolve
that scenario by not calling the Duo plugin at all if LDAP returned failure.

Is the source for the "auth-multi" plugin you tested with available
anywhere?  I could not find it, and had wanted something like it for my own
testing.

On Thu, Mar 10, 2022 at 12:18 PM Gert Doering <gert@...1296...> wrote:

> Without this patch, OpenVPN behaviour if more than one plugin wants
> to do deferred user/password authentication not well-defined, as
> there is just one set of auth control files and a single plugin state.
>
> This patch changes "key state -> plugin_auth" from a single struct
> to an array of MAX_PLUGINS elements that have per-plugin auth-control
> files and auth status.
>
> All direct access is changed to iterating over this array.
>
> The actual plugin calls are no longer done with the "do them all"
> function plugin_call() (or plugin_call_ssl()) but plugin.c/plugin.h
> is changed to expose the "call one" function plugin_call_item(), and
> verify_user_pass_plugin() calls this for each loaded plugin,
> keeping track of "overall" state.
>
> key_state_test_plugin_auth() is introduced to do the
> "key_state_test_auth_control_file()" test for all plugins, and
> return "FAIL if one fails, PENDING if one is pending, SUCCESS
> if one was pending and succeeded now".
>
> This was tested with the "auth-multi" test plugin, with 5-7 plugins
> loaded (some deferred, some direct) and "some of them failing" or
> "all succeeding".  Testing included "will it leak files if multiple
> deferred plugins are ongoing, and one of the earlier ones rejects
> authentication".
>
> This patch is not suitable for production use:
>  - it's full of debug output
>  - it will break compilation without ENABLE_PLUGINS
>  - it stands to argue whether plugin_call_item() should be exposed,
>    or key_state_test_plugin_auth() might be moved to plugin.c instead
>    (with a null function if ENABLE_PLUGINS is not defined)
>
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/plugin.c     |   2 +-
>  src/openvpn/plugin.h     |   9 +++
>  src/openvpn/ssl.c        |   5 +-
>  src/openvpn/ssl_common.h |   4 +-
>  src/openvpn/ssl_verify.c | 127 ++++++++++++++++++++++++++++++++-------
>  5 files changed, 123 insertions(+), 24 deletions(-)
>
> diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
> index e3a89293..74b57033 100644
> --- a/src/openvpn/plugin.c
> +++ b/src/openvpn/plugin.c
> @@ -518,7 +518,7 @@ plugin_open_item(struct plugin *p,
>      }
>  }
>
> -static int
> +int
>  plugin_call_item(const struct plugin *p,
>                   void *per_client_context,
>                   const int type,
> diff --git a/src/openvpn/plugin.h b/src/openvpn/plugin.h
> index c6fa206a..799a646e 100644
> --- a/src/openvpn/plugin.h
> +++ b/src/openvpn/plugin.h
> @@ -132,6 +132,15 @@ int plugin_call_ssl(const struct plugin_list *pl,
>                      int current_cert_depth,
>                      openvpn_x509_cert_t *current_cert
>                      );
> +int plugin_call_item(const struct plugin *p,
> +                     void *per_client_context,
> +                     const int type,
> +                     const struct argv *av,
> +                     struct openvpn_plugin_string_list **retlist,
> +                     const char **envp,
> +                     int certdepth,
> +                     openvpn_x509_cert_t *current_cert
> +                     );
>
>  void plugin_list_close(struct plugin_list *pl);
>
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 14a943a7..ce6de9a0 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -1036,7 +1036,10 @@ key_state_free(struct key_state *ks, bool clear)
>
>      packet_id_free(&ks->crypto_options.packet_id);
>
> -    key_state_rm_auth_control_files(&ks->plugin_auth);
> +    for (int i=0; i<MAX_PLUGINS; i++)
> +    {
> +        key_state_rm_auth_control_files(&ks->plugin_auth[i]);
> +    }
>      key_state_rm_auth_control_files(&ks->script_auth);
>
>      if (clear)
> diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
> index 8a077c74..0de3290a 100644
> --- a/src/openvpn/ssl_common.h
> +++ b/src/openvpn/ssl_common.h
> @@ -37,6 +37,8 @@
>
>  #include "ssl_backend.h"
>
> +#include "plugin.h"
> +
>  /* passwords */
>  #define UP_TYPE_AUTH        "Auth"
>  #define UP_TYPE_PRIVATE_KEY "Private Key"
> @@ -239,7 +241,7 @@ struct key_state
>  #endif
>      time_t acf_last_mod;
>
> -    struct auth_deferred_status plugin_auth;
> +    struct auth_deferred_status plugin_auth[MAX_PLUGINS];
>      struct auth_deferred_status script_auth;
>  };
>
> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index 3b6b58fa..38c8a830 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
> @@ -1059,6 +1059,50 @@ key_state_test_auth_control_file(struct
> auth_deferred_status *ads, bool cached)
>      return ACF_DISABLED;
>  }
>
> +/**
> + * Checks the auth control status for all plugins.
> + *
> + * returns:
> + * - ACF_PENDING  if any plugin is still waiting for results.
> + * - ACF_SUCCEEDED if there were pending plugins AND all succeeded
> + * - ACF_FAILED   if any plugin fails
> + * - ACF_DISABLED if no plugin is waiting
> + *
> + * @param ads       array of deferred status control structures
> + * @param cached    Return only cached status
> + * @return          ACF_* as per enum
> + */
> +static enum auth_deferred_result
> +key_state_test_plugin_auth(struct auth_deferred_status *ads, bool cached)
> +{
> +    unsigned int ret = ACF_DISABLED;
> +
> +    for (int i=0;i<MAX_PLUGINS;i++)
> +    {
> +        unsigned int ret_one =
> key_state_test_auth_control_file(&(ads[i]), cached);
> +msg(M_INFO, "GERT(9a): kstpa: i=%d, ret_one=%d", i, ret_one);
> +
> +        /* if at least one plugin fails, we fail all */
> +        if ( ret_one == ACF_FAILED )
> +        {
> +            ret = ret_one;
> +            break;
> +        }
> +        /* if at least one plugin is still pending, we're still pending */
> +        if ( ret_one == ACF_PENDING )
> +        {
> +            ret = ret_one;
> +        }
> +        /* if no plugins are pending AND we have success, we succeed */
> +        if ( ret_one == ACF_SUCCEEDED && ret != ACF_PENDING )
> +        {
> +            ret = ret_one;
> +        }
> +    }
> +msg(M_INFO, "GERT(9b): kstpa: ret=%d", ret);
> +    return ret;
> +}
> +
>  /**
>   * This method takes a key_state and if updates the state
>   * of the key if it is deferred.
> @@ -1069,6 +1113,7 @@ key_state_test_auth_control_file(struct
> auth_deferred_status *ads, bool cached)
>  static void
>  update_key_auth_status(bool cached, struct key_state *ks)
>  {
> +msg(M_INFO, "GERT(10) update_key_auth_status authenticated=%d",
> ks->authenticated);
>      if (ks->authenticated == KS_AUTH_FALSE)
>      {
>          return;
> @@ -1078,7 +1123,7 @@ update_key_auth_status(bool cached, struct key_state
> *ks)
>          enum auth_deferred_result auth_plugin = ACF_DISABLED;
>          enum auth_deferred_result auth_script = ACF_DISABLED;
>          enum auth_deferred_result auth_man = ACF_DISABLED;
> -        auth_plugin = key_state_test_auth_control_file(&ks->plugin_auth,
> cached);
> +        auth_plugin = key_state_test_plugin_auth(ks->plugin_auth, cached);
>          auth_script = key_state_test_auth_control_file(&ks->script_auth,
> cached);
>  #ifdef ENABLE_MANAGEMENT
>          auth_man = man_def_auth_test(ks);
> @@ -1357,40 +1402,80 @@ static int
>  verify_user_pass_plugin(struct tls_session *session, struct tls_multi
> *multi,
>                          const struct user_pass *up)
>  {
> -    int retval = OPENVPN_PLUGIN_FUNC_ERROR;
> +    int retval = OPENVPN_PLUGIN_FUNC_SUCCESS;
>      struct key_state *ks = &session->key[KS_PRIMARY];      /* primary key
> */
>
> +    struct gc_arena gc = gc_new();
> +
>      /* set password in private env space */
>      setenv_str(session->opt->es, "password", up->password);
>
> -    /* generate filename for deferred auth control file */
> -    if (!key_state_gen_auth_control_files(&ks->plugin_auth, session->opt))
> +    /* iterate over list of plugins here, because deferred auth needs
> +     * per-plugin auth control files
> +     */
> +    const struct plugin_list *pl = session->opt->plugins;
> +    int plugins_active = plugin_n(pl);
> +    ASSERT( plugins_active < SIZE(ks->plugin_auth) );
> +    msg(M_INFO, "GERT(1): plugins_active=%d, SIZE=%d", plugins_active,
> (int)SIZE(ks->plugin_auth) );
> +
> +    for (int i=0; i<plugins_active; i++)
>      {
> -        msg(D_TLS_ERRORS, "TLS Auth Error (%s): "
> -            "could not create deferred auth control file", __func__);
> -        return retval;
> -    }
> +        /* generate filename for deferred auth control file */
> +        if (!key_state_gen_auth_control_files(&ks->plugin_auth[i],
> session->opt))
> +        {
> +            msg(D_TLS_ERRORS, "TLS Auth Error (%s): "
> +                "could not create deferred auth control file", __func__);
> +            retval = OPENVPN_PLUGIN_FUNC_ERROR;
> +            break;
> +        }
>
> -    /* call command */
> -    retval = plugin_call(session->opt->plugins,
> OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY, NULL, NULL, session->opt->es);
> +        msg(M_INFO, "GERT(4): plugin #%d, acf=%s acp=%s", i,
> +                ks->plugin_auth[i].auth_control_file,
> ks->plugin_auth[i].auth_pending_file);
>
> -    if (retval == OPENVPN_PLUGIN_FUNC_DEFERRED)
> -    {
> -        /* Check if the plugin has written the pending auth control
> -         * file and send the pending auth to the client */
> -        if(!key_state_check_auth_pending_file(&ks->plugin_auth, multi))
> +        /* call command */
> +        // retval = plugin_call_item(session->opt->plugins,
> OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY, NULL, NULL, session->opt->es);
> +        //                                pl                    type
>                        av    pr    es   [crt -1, NULL]
> +
> +        const char **envp = make_env_array(session->opt->es, false, &gc);
> +        const int status = plugin_call_item(&pl->common->plugins[i],
> +
> pl->per_client.per_client_context[i],
> +
> OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY,
> +                                            NULL, NULL, envp, -1, NULL );
> +
> +        if (status == OPENVPN_PLUGIN_FUNC_DEFERRED)
> +        {
> +            /* Check if the plugin has written the pending auth control
> +             * file and send the pending auth to the client */
> +            if(!key_state_check_auth_pending_file(&(ks->plugin_auth[i]),
> multi))
> +            {
> +                retval = OPENVPN_PLUGIN_FUNC_ERROR;
> +                key_state_rm_auth_control_files(&(ks->plugin_auth[i]));
> +                break;
> +            }
> +            else
> +            {
> +                retval = OPENVPN_PLUGIN_FUNC_DEFERRED;
> +            }
> +        }
> +        else
> +        {
> +            /* purge auth control filename (and file itself) for
> non-deferred returns */
> +            key_state_rm_auth_control_files(&(ks->plugin_auth[i]));
> +            ks->plugin_auth[i].auth_control_status = ACF_DISABLED;
> +        }
> +
> +        /* if a single plugin fails, we fail all */
> +        if (status == OPENVPN_PLUGIN_FUNC_ERROR)
>          {
>              retval = OPENVPN_PLUGIN_FUNC_ERROR;
> -            key_state_rm_auth_control_files(&ks->plugin_auth);
> +            break;
>          }
> -    }
> -    else
> -    {
> -        /* purge auth control filename (and file itself) for non-deferred
> returns */
> -        key_state_rm_auth_control_files(&ks->plugin_auth);
> +
> +        msg(M_INFO, "GERT(3): plugin #%d status=%d -> retval=%d", i,
> status, retval );
>      }
>
>      setenv_del(session->opt->es, "password");
> +    gc_free(&gc);
>
>      return retval;
>  }
> --
> 2.34.1
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--000000000000416eba05d9dd9789
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>One of the behaviors that brought this to light was a=
 user who had an LDAP (non-deferred) plugin followed by a Duo MFA (deferred=
) plugin.=C2=A0 He noted that, even if the LDAP call returned failure, the =
Duo plugin was still called.=C2=A0 That would generate a push notification =
to his phone even though the authentication was already destined to fail du=
e to LDAP.=C2=A0 It looks like this patch returns failure when the first pl=
ugin fails, so would resolve that scenario by not calling the Duo plugin at=
 all if LDAP returned failure.<br></div><div><br></div><div>Is the source f=
or the &quot;auth-multi&quot; plugin you tested with available anywhere?=C2=
=A0 I could not find it, and had wanted something like it for my own testin=
g.<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"=
gmail_attr">On Thu, Mar 10, 2022 at 12:18 PM Gert Doering &lt;<a href=3D"ma=
ilto:gert@...1296...">gert@...1296...</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">Without this patch, OpenVPN behaviour =
if more than one plugin wants<br>
to do deferred user/password authentication not well-defined, as<br>
there is just one set of auth control files and a single plugin state.<br>
<br>
This patch changes &quot;key state -&gt; plugin_auth&quot; from a single st=
ruct<br>
to an array of MAX_PLUGINS elements that have per-plugin auth-control<br>
files and auth status.<br>
<br>
All direct access is changed to iterating over this array.<br>
<br>
The actual plugin calls are no longer done with the &quot;do them all&quot;=
<br>
function plugin_call() (or plugin_call_ssl()) but plugin.c/plugin.h<br>
is changed to expose the &quot;call one&quot; function plugin_call_item(), =
and<br>
verify_user_pass_plugin() calls this for each loaded plugin,<br>
keeping track of &quot;overall&quot; state.<br>
<br>
key_state_test_plugin_auth() is introduced to do the<br>
&quot;key_state_test_auth_control_file()&quot; test for all plugins, and<br>
return &quot;FAIL if one fails, PENDING if one is pending, SUCCESS<br>
if one was pending and succeeded now&quot;.<br>
<br>
This was tested with the &quot;auth-multi&quot; test plugin, with 5-7 plugi=
ns<br>
loaded (some deferred, some direct) and &quot;some of them failing&quot; or=
<br>
&quot;all succeeding&quot;.=C2=A0 Testing included &quot;will it leak files=
 if multiple<br>
deferred plugins are ongoing, and one of the earlier ones rejects<br>
authentication&quot;.<br>
<br>
This patch is not suitable for production use:<br>
=C2=A0- it&#39;s full of debug output<br>
=C2=A0- it will break compilation without ENABLE_PLUGINS<br>
=C2=A0- it stands to argue whether plugin_call_item() should be exposed,<br>
=C2=A0 =C2=A0or key_state_test_plugin_auth() might be moved to plugin.c ins=
tead<br>
=C2=A0 =C2=A0(with a null function if ENABLE_PLUGINS is not defined)<br>
<br>
Signed-off-by: Gert Doering &lt;<a href=3D"mailto:gert@...1296..." target=
=3D"_blank">gert@...1296...</a>&gt;<br>
---<br>
=C2=A0src/openvpn/plugin.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0src/openvpn/plugin.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A09 +++<br>
=C2=A0src/openvpn/ssl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A05 +-<br>
=C2=A0src/openvpn/ssl_common.h |=C2=A0 =C2=A04 +-<br>
=C2=A0src/openvpn/ssl_verify.c | 127 ++++++++++++++++++++++++++++++++------=
-<br>
=C2=A05 files changed, 123 insertions(+), 24 deletions(-)<br>
<br>
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c<br>
index e3a89293..74b57033 100644<br>
--- a/src/openvpn/plugin.c<br>
+++ b/src/openvpn/plugin.c<br>
@@ -518,7 +518,7 @@ plugin_open_item(struct plugin *p,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-static int<br>
+int<br>
=C2=A0plugin_call_item(const struct plugin *p,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *per_cl=
ient_context,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const int ty=
pe,<br>
diff --git a/src/openvpn/plugin.h b/src/openvpn/plugin.h<br>
index c6fa206a..799a646e 100644<br>
--- a/src/openvpn/plugin.h<br>
+++ b/src/openvpn/plugin.h<br>
@@ -132,6 +132,15 @@ int plugin_call_ssl(const struct plugin_list *pl,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0int current_cert_depth,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0openvpn_x509_cert_t *current_cert<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0);<br>
+int plugin_call_item(const struct plugin *p,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0void *per_client_context,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0const int type,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0const struct argv *av,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0struct openvpn_plugin_string_list **retlist,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0const char **envp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0int certdepth,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0openvpn_x509_cert_t *current_cert<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0);<br>
<br>
=C2=A0void plugin_list_close(struct plugin_list *pl);<br>
<br>
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c<br>
index 14a943a7..ce6de9a0 100644<br>
--- a/src/openvpn/ssl.c<br>
+++ b/src/openvpn/ssl.c<br>
@@ -1036,7 +1036,10 @@ key_state_free(struct key_state *ks, bool clear)<br>
<br>
=C2=A0 =C2=A0 =C2=A0packet_id_free(&amp;ks-&gt;crypto_options.packet_id);<b=
r>
<br>
-=C2=A0 =C2=A0 key_state_rm_auth_control_files(&amp;ks-&gt;plugin_auth);<br>
+=C2=A0 =C2=A0 for (int i=3D0; i&lt;MAX_PLUGINS; i++)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 key_state_rm_auth_control_files(&amp;ks-&gt;pl=
ugin_auth[i]);<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0key_state_rm_auth_control_files(&amp;ks-&gt;script_auth=
);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (clear)<br>
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h<br>
index 8a077c74..0de3290a 100644<br>
--- a/src/openvpn/ssl_common.h<br>
+++ b/src/openvpn/ssl_common.h<br>
@@ -37,6 +37,8 @@<br>
<br>
=C2=A0#include &quot;ssl_backend.h&quot;<br>
<br>
+#include &quot;plugin.h&quot;<br>
+<br>
=C2=A0/* passwords */<br>
=C2=A0#define UP_TYPE_AUTH=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Auth&quot;<br>
=C2=A0#define UP_TYPE_PRIVATE_KEY &quot;Private Key&quot;<br>
@@ -239,7 +241,7 @@ struct key_state<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0time_t acf_last_mod;<br>
<br>
-=C2=A0 =C2=A0 struct auth_deferred_status plugin_auth;<br>
+=C2=A0 =C2=A0 struct auth_deferred_status plugin_auth[MAX_PLUGINS];<br>
=C2=A0 =C2=A0 =C2=A0struct auth_deferred_status script_auth;<br>
=C2=A0};<br>
<br>
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c<br>
index 3b6b58fa..38c8a830 100644<br>
--- a/src/openvpn/ssl_verify.c<br>
+++ b/src/openvpn/ssl_verify.c<br>
@@ -1059,6 +1059,50 @@ key_state_test_auth_control_file(struct auth_deferre=
d_status *ads, bool cached)<br>
=C2=A0 =C2=A0 =C2=A0return ACF_DISABLED;<br>
=C2=A0}<br>
<br>
+/**<br>
+ * Checks the auth control status for all plugins.<br>
+ *<br>
+ * returns:<br>
+ * - ACF_PENDING=C2=A0 if any plugin is still waiting for results.<br>
+ * - ACF_SUCCEEDED if there were pending plugins AND all succeeded<br>
+ * - ACF_FAILED=C2=A0 =C2=A0if any plugin fails<br>
+ * - ACF_DISABLED if no plugin is waiting<br>
+ *<br>
+ * @param ads=C2=A0 =C2=A0 =C2=A0 =C2=A0array of deferred status control s=
tructures<br>
+ * @param cached=C2=A0 =C2=A0 Return only cached status<br>
+ * @return=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ACF_* as per enum<br>
+ */<br>
+static enum auth_deferred_result<br>
+key_state_test_plugin_auth(struct auth_deferred_status *ads, bool cached)<=
br>
+{<br>
+=C2=A0 =C2=A0 unsigned int ret =3D ACF_DISABLED;<br>
+<br>
+=C2=A0 =C2=A0 for (int i=3D0;i&lt;MAX_PLUGINS;i++)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int ret_one =3D key_state_test_auth_c=
ontrol_file(&amp;(ads[i]), cached);<br>
+msg(M_INFO, &quot;GERT(9a): kstpa: i=3D%d, ret_one=3D%d&quot;, i, ret_one)=
;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* if at least one plugin fails, we fail all *=
/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ( ret_one =3D=3D ACF_FAILED )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D ret_one;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* if at least one plugin is still pending, we=
&#39;re still pending */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ( ret_one =3D=3D ACF_PENDING )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D ret_one;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* if no plugins are pending AND we have succe=
ss, we succeed */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ( ret_one =3D=3D ACF_SUCCEEDED &amp;&amp; r=
et !=3D ACF_PENDING )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D ret_one;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+msg(M_INFO, &quot;GERT(9b): kstpa: ret=3D%d&quot;, ret);<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br>
+<br>
=C2=A0/**<br>
=C2=A0 * This method takes a key_state and if updates the state<br>
=C2=A0 * of the key if it is deferred.<br>
@@ -1069,6 +1113,7 @@ key_state_test_auth_control_file(struct auth_deferred=
_status *ads, bool cached)<br>
=C2=A0static void<br>
=C2=A0update_key_auth_status(bool cached, struct key_state *ks)<br>
=C2=A0{<br>
+msg(M_INFO, &quot;GERT(10) update_key_auth_status authenticated=3D%d&quot;=
, ks-&gt;authenticated);<br>
=C2=A0 =C2=A0 =C2=A0if (ks-&gt;authenticated =3D=3D KS_AUTH_FALSE)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
@@ -1078,7 +1123,7 @@ update_key_auth_status(bool cached, struct key_state =
*ks)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum auth_deferred_result auth_plugin =3D=
 ACF_DISABLED;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum auth_deferred_result auth_script =3D=
 ACF_DISABLED;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum auth_deferred_result auth_man =3D AC=
F_DISABLED;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_plugin =3D key_state_test_auth_control_fi=
le(&amp;ks-&gt;plugin_auth, cached);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 auth_plugin =3D key_state_test_plugin_auth(ks-=
&gt;plugin_auth, cached);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0auth_script =3D key_state_test_auth_contr=
ol_file(&amp;ks-&gt;script_auth, cached);<br>
=C2=A0#ifdef ENABLE_MANAGEMENT<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0auth_man =3D man_def_auth_test(ks);<br>
@@ -1357,40 +1402,80 @@ static int<br>
=C2=A0verify_user_pass_plugin(struct tls_session *session, struct tls_multi=
 *multi,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0const struct user_pass *up)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 int retval =3D OPENVPN_PLUGIN_FUNC_ERROR;<br>
+=C2=A0 =C2=A0 int retval =3D OPENVPN_PLUGIN_FUNC_SUCCESS;<br>
=C2=A0 =C2=A0 =C2=A0struct key_state *ks =3D &amp;session-&gt;key[KS_PRIMAR=
Y];=C2=A0 =C2=A0 =C2=A0 /* primary key */<br>
<br>
+=C2=A0 =C2=A0 struct gc_arena gc =3D gc_new();<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/* set password in private env space */<br>
=C2=A0 =C2=A0 =C2=A0setenv_str(session-&gt;opt-&gt;es, &quot;password&quot;=
, up-&gt;password);<br>
<br>
-=C2=A0 =C2=A0 /* generate filename for deferred auth control file */<br>
-=C2=A0 =C2=A0 if (!key_state_gen_auth_control_files(&amp;ks-&gt;plugin_aut=
h, session-&gt;opt))<br>
+=C2=A0 =C2=A0 /* iterate over list of plugins here, because deferred auth =
needs<br>
+=C2=A0 =C2=A0 =C2=A0* per-plugin auth control files<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 const struct plugin_list *pl =3D session-&gt;opt-&gt;plugins=
;<br>
+=C2=A0 =C2=A0 int plugins_active =3D plugin_n(pl);<br>
+=C2=A0 =C2=A0 ASSERT( plugins_active &lt; SIZE(ks-&gt;plugin_auth) );<br>
+=C2=A0 =C2=A0 msg(M_INFO, &quot;GERT(1): plugins_active=3D%d, SIZE=3D%d&qu=
ot;, plugins_active, (int)SIZE(ks-&gt;plugin_auth) );<br>
+<br>
+=C2=A0 =C2=A0 for (int i=3D0; i&lt;plugins_active; i++)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_TLS_ERRORS, &quot;TLS Auth Error (%s): &=
quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;could not create deferred =
auth control file&quot;, __func__);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return retval;<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* generate filename for deferred auth control=
 file */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!key_state_gen_auth_control_files(&amp;ks-=
&gt;plugin_auth[i], session-&gt;opt))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(D_TLS_ERRORS, &quot;TLS Auth=
 Error (%s): &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;could not cr=
eate deferred auth control file&quot;, __func__);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D OPENVPN_PLUGIN_FUNC_E=
RROR;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 /* call command */<br>
-=C2=A0 =C2=A0 retval =3D plugin_call(session-&gt;opt-&gt;plugins, OPENVPN_=
PLUGIN_AUTH_USER_PASS_VERIFY, NULL, NULL, session-&gt;opt-&gt;es);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_INFO, &quot;GERT(4): plugin #%d, acf=3D%=
s acp=3D%s&quot;, i, <br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ks-&gt;plugin_auth=
[i].auth_control_file, ks-&gt;plugin_auth[i].auth_pending_file);<br>
<br>
-=C2=A0 =C2=A0 if (retval =3D=3D OPENVPN_PLUGIN_FUNC_DEFERRED)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check if the plugin has written the pending=
 auth control<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* file and send the pending auth to the =
client */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if(!key_state_check_auth_pending_file(&amp;ks-=
&gt;plugin_auth, multi))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* call command */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 // retval =3D plugin_call_item(session-&gt;opt=
-&gt;plugins, OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY, NULL, NULL, session-&gt=
;opt-&gt;es);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 //=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pl=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 type=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0av=C2=A0 =C2=A0 pr=C2=A0 =C2=A0 es=C2=A0 =C2=A0[=
crt -1, NULL]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char **envp =3D make_env_array(session-&=
gt;opt-&gt;es, false, &amp;gc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 const int status =3D plugin_call_item(&amp;pl-=
&gt;common-&gt;plugins[i],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 pl-&gt;per_client.per_client_context[i],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 NULL, NULL, envp, -1, NULL );<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (status =3D=3D OPENVPN_PLUGIN_FUNC_DEFERRED=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check if the plugin has writt=
en the pending auth control<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* file and send the pendin=
g auth to the client */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if(!key_state_check_auth_pending=
_file(&amp;(ks-&gt;plugin_auth[i]), multi))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D OPENVPN=
_PLUGIN_FUNC_ERROR;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 key_state_rm_auth_=
control_files(&amp;(ks-&gt;plugin_auth[i]));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D OPENVPN=
_PLUGIN_FUNC_DEFERRED;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* purge auth control filename (=
and file itself) for non-deferred returns */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 key_state_rm_auth_control_files(=
&amp;(ks-&gt;plugin_auth[i]));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ks-&gt;plugin_auth[i].auth_contr=
ol_status =3D ACF_DISABLED;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* if a single plugin fails, we fail all */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (status =3D=3D OPENVPN_PLUGIN_FUNC_ERROR)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retval =3D OPENVPN_PLUGIN_F=
UNC_ERROR;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 key_state_rm_auth_control_files(=
&amp;ks-&gt;plugin_auth);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 else<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* purge auth control filename (and file itsel=
f) for non-deferred returns */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 key_state_rm_auth_control_files(&amp;ks-&gt;pl=
ugin_auth);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(M_INFO, &quot;GERT(3): plugin #%d status=
=3D%d -&gt; retval=3D%d&quot;, i, status, retval );<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0setenv_del(session-&gt;opt-&gt;es, &quot;password&quot;=
);<br>
+=C2=A0 =C2=A0 gc_free(&amp;gc);<br>
<br>
=C2=A0 =C2=A0 =C2=A0return retval;<br>
=C2=A0}<br>
-- <br>
2.34.1<br>
<br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div>

--000000000000416eba05d9dd9789--

