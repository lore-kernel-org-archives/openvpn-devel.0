Date: Wed, 30 Nov 2016 14:13:13 +0200 (EET)
From: Heikki Hannikainen <hessu@...1822...>
In-Reply-To: <1421497831-3424-10-git-send-email-fabian.knittel@...1547...>
Message-ID: <alpine.DEB.2.10.1611301412160.21897@...1831...>
References: <1412978966-15392-1-git-send-email-fabian.knittel@...1547...>
	<1421497831-3424-1-git-send-email-fabian.knittel@...1547...>
	<1421497831-3424-10-git-send-email-fabian.knittel@...1547...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2 9/9] client-connect: Add deferred
 support to the client-connect plugin v1 handler
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: Fabian Knittel <fabian.knittel@...1547...>
Cc: openvpn-devel@lists.sourceforge.net


Fabian,

Have you by any chance ported this patch set forward to the current
OpenVPN master / 2.4. beta?

We have used a variation of it, and gained a noticeable performance boost,
for a long time. Thanks to the deferred client-connect handling the
openvpn server does not stop packet processing while a client-connect
handler plugin is doing what it needs to do, reducing jitter and packet 
loss for other clients.

It'd be great to have this merged in the master tree at some point.


On Sat, 17 Jan 2015, Fabian Knittel wrote:

> Uses the infrastructure provided and used in the previous patch to provide
> deferral support to the v1 client-connect plugin handler as well.
>
> Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
> ---
> src/openvpn/multi.c | 32 ++++++++++++++++++++------------
> 1 file changed, 20 insertions(+), 12 deletions(-)
>
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 68a7248..ab73034 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -1814,6 +1814,7 @@ multi_client_connect_call_plugin_v1 (struct multi_context *m,
> {
>   enum client_connect_return ret = CC_RET_SKIPPED;
> #ifdef ENABLE_PLUGIN
> +  struct client_connect_state *ccs = mi->client_connect_state;
>   ASSERT (m);
>   ASSERT (mi);
>   ASSERT (option_types_found);
> @@ -1821,34 +1822,41 @@ multi_client_connect_call_plugin_v1 (struct multi_context *m,
>   if (plugin_defined (mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT))
>     {
>       int plug_ret;
> -      struct gc_arena gc = gc_new ();
>       struct argv argv = argv_new ();
> -      const char *dc_file = create_temp_file (mi->context.options.tmp_dir, "cc", &gc);
>
> -      if (!dc_file)
> +      if (!ccs_gen_config_file (mi) ||
> +	  !ccs_gen_deferred_ret_file (mi))
> 	{
> 	  ret = CC_RET_FAILED;
> -	  goto script_depr_failed;
> +	  goto cleanup;
> 	}
>
> -      argv_printf (&argv, "%s", dc_file);
> +      argv_printf (&argv, "%s", ccs->config_file);
>
>       plug_ret = plugin_call (mi->context.plugins,
> 			      OPENVPN_PLUGIN_CLIENT_CONNECT,
> 			      &argv, NULL, mi->context.c2.es);
>       argv_reset (&argv);
> -      if (plug_ret != OPENVPN_PLUGIN_FUNC_SUCCESS)
> +      if (plug_ret == OPENVPN_PLUGIN_FUNC_SUCCESS)
> +	{
> +	  multi_client_connect_post (m, mi, ccs->config_file,
> +				     option_types_found);
> +	  ret = CC_RET_SUCCEEDED;
> +	}
> +      else if (plug_ret == OPENVPN_PLUGIN_FUNC_DEFERRED)
> +	ret = CC_RET_DEFERRED;
> +      else
> 	{
> 	  msg (M_WARN, "WARNING: client-connect plugin call failed");
> 	  ret = CC_RET_FAILED;
> 	}
> -      else
> +
> +cleanup:
> +      if (ret != CC_RET_DEFERRED)
> 	{
> -	  multi_client_connect_post (m, mi, dc_file, option_types_found);
> -	  ret = CC_RET_SUCCEEDED;
> +	  ccs_delete_config_file (mi);
> +	  ccs_delete_deferred_ret_file (mi);
> 	}
> -script_depr_failed:
> -      gc_free (&gc);
>     }
> #endif
>   return ret;
> @@ -2141,7 +2149,7 @@ static const struct client_connect_handlers client_connect_handlers[] = {
>   },
>   {
>     main: multi_client_connect_call_plugin_v1,
> -    deferred: multi_client_connect_fail
> +    deferred: multi_client_handle_deferred
>   },
>   {
>     main: multi_client_connect_call_plugin_v2,
> -- 
> 2.1.4
>
>
> ------------------------------------------------------------------------------
> New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
> GigeNET is offering a free month of service with a new server in Ashburn.
> Choose from 2 high performing configs, both with 100TB of bandwidth.
> Higher redundancy.Lower latency.Increased capacity.Completely compliant.
> http://p.sf.net/sfu/gigenet
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

   - Hessu


