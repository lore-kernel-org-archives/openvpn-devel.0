Message-ID: <4E159949.7050905@...68...>
Date: Thu, 07 Jul 2011 13:32:25 +0200
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <1CED409804E2164C8104F9E623B08B901269D8E721@...1436...>
	<1310023632-30830-1-git-send-email-dejong@...1435...>
In-Reply-To: <1310023632-30830-1-git-send-email-dejong@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] Fixes for the plugin system:
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
To: openvpn-devel@lists.sourceforge.net

Am 07.07.2011 09:27, schrieb Adriaan de Jong:
>  - Removed the dependency on an SSL library for USE_SSL when creating non-SSL plugins
>  - Fixed example plugin code to include USE_SSL when needed
> 
> Signed-off-by: Adriaan de Jong <dejong@...1435...>
> diff --git a/openvpn-plugin.h b/openvpn-plugin.h
> index 9cce9d8..65a3ffd 100644
> --- a/openvpn-plugin.h
> +++ b/openvpn-plugin.h
> @@ -267,9 +270,9 @@ struct openvpn_plugin_args_open_return
>   * *per_client_context : the per-client context pointer which was returned by
>   *        openvpn_plugin_client_constructor_v1, if defined.
>   *
> - * current_cert_depth : Certificate depth of the certificate being passed over
> + * current_cert_depth : Certificate depth of the certificate being passed over (only if compiled with USE_SSL defined)
>   *
> - * *current_cert : X509 Certificate object received from the client
> + * *current_cert : X509 Certificate object received from the client (only if compiled with USE_SSL defined)
>   *
>   */
>  struct openvpn_plugin_args_func_in
> @@ -279,8 +282,13 @@ struct openvpn_plugin_args_func_in
>    const char ** const envp;
>    openvpn_plugin_handle_t handle;
>    void *per_client_context;
> +#ifdef USE_SSL
>    int current_cert_depth;
>    x509_cert_t *current_cert;
> +#else
> +  int current_cert_depth; /* Unused, for compatibility purposes only */
> +  void *current_cert; /* Unused, for compatibility purposes only */
> +#endif
>  };

I'd veto the #else part here. It is dangerous (because it provides
variables that are unused) and doesn't match the comments in the earlier
hunk, and IMNSHO SSL-specific and/or undefined variables should also
remain undeclared so that the plugins can either #define USE_SSL
whatever, or remove references to the junkyard^W^Wcurrent_cert* variables.

