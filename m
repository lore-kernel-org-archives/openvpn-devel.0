Message-ID: <4BC8D891.9090309@...1338...>
Date: Fri, 16 Apr 2010 23:37:21 +0200
From: Fabian Knittel <fabian.knittel@...1338...>
MIME-Version: 1.0
References: <1271449313-26315-1-git-send-email-openvpn.list@...1114...>
	<1271449313-26315-3-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1271449313-26315-3-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCHv2 2/3] Renamed all calls
	to	create_temp_filename()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: David Sommerseth <openvpn.list@...1114...>
Cc: James Yonan <james@...515...>, David Sommerseth <dazo@...384...>, Openvpn-devel@lists.sourceforge.net

Hi David,

David Sommerseth wrote:
> diff --git a/multi.c b/multi.c
> index 2b04428..826a113 100644
> --- a/multi.c
> +++ b/multi.c
> @@ -1530,7 +1530,13 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
>        if (plugin_defined (mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT))
>  	{
>  	  struct argv argv = argv_new ();
> -	  const char *dc_file = create_temp_filename (mi->context.options.tmp_dir, "cc", &gc);
> +	  const char *dc_file = create_temp_file (mi->context.options.tmp_dir, "cc", &gc);
> +
> +          if( !dc_file ) {
> +            cc_succeeded = false;
> +            goto script_depr_failed;
> +          }
> +
>  	  argv_printf (&argv, "%s", dc_file);
>  	  delete_file (dc_file);
>  	  if (plugin_call (mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT, &argv, NULL, mi->context.c2.es) != OPENVPN_PLUGIN_FUNC_SUCCESS)

You'll probably want to remove the remaining delete_file, right? :)

[...]
> diff --git a/ssl.c b/ssl.c
> index ddd5ee7..552bcbe 100644
> --- a/ssl.c
> +++ b/ssl.c
> @@ -1094,10 +1094,11 @@ key_state_gen_auth_control_file (struct key_state *ks, const struct tls_options
>    const char *acf;
>  
>    key_state_rm_auth_control_file (ks);
> -  acf = create_temp_filename (opt->tmp_dir, "acf", &gc);
> -  ks->auth_control_file = string_alloc (acf, NULL);
> -  setenv_str (opt->es, "auth_control_file", ks->auth_control_file);
> -
> +  acf = create_temp_file (opt->tmp_dir, "acf", &gc);
> +  if( acf ) {
> +    ks->auth_control_file = string_alloc (acf, NULL);
> +    setenv_str (opt->es, "auth_control_file", ks->auth_control_file);
> +  } /* FIXME: Should have better error handling? */
>    gc_free (&gc);					  
>  }
>  

I just noticed your FIXME. With the above change, the client auth plugin
would have the chance to notice that there's no "auth_control_file"
environment variable and error out. It was already logged that the temp
file creation failed, so it should be clear to the admin why it happened.

An improvement might be to ensure that verify_user_pass_plugin()
disallows the plugin from doing OPENVPN_PLUGIN_FUNC_DEFERRED if there's
no auth_control_file. (The function could simply check the return value
and force FAILURE.)

Cheers
Fabian

