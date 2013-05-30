Message-ID: <51A7609C.1020606@...1147...>
Date: Thu, 30 May 2013 16:22:20 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <1369920428-11350-1-git-send-email-arne@...1227...>
In-Reply-To: <1369920428-11350-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Only print script warnings when a
 script is	used. Remove stray mention of script-security system.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

ACK!

Arne Schwabe wrote:
> ---
>  src/openvpn/common.h |    2 +-
>  src/openvpn/init.c   |   19 +++++++++++++------
>  2 files changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/src/openvpn/common.h b/src/openvpn/common.h
> index dd2c83f..2f85bec 100644
> --- a/src/openvpn/common.h
> +++ b/src/openvpn/common.h
> @@ -100,6 +100,6 @@ typedef unsigned long ptr_type;
>  /*
>   * Script security warning
>   */
> -#define SCRIPT_SECURITY_WARNING "WARNING: External program may not be called unless '--script-security 2' or higher is enabled.  Use '--script-security 3 system' for backward compatibility with 2.1_rc8 and earlier.  See --help text or man page for detailed info."
> +#define SCRIPT_SECURITY_WARNING "WARNING: External program may not be called unless '--script-security 2' or higher is enabled. See --help text or man page for detailed info."
>  
>  #endif
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 2a0ba85..1dc7ee7 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -2542,12 +2542,19 @@ do_option_warnings (struct context *c)
>      msg (M_WARN, "NOTE: --connect-timeout option is not supported on this OS");
>  #endif
>  
> -  if (script_security >= SSEC_SCRIPTS)
> -    msg (M_WARN, "NOTE: the current --script-security setting may allow this configuration to call user-defined scripts");
> -  else if (script_security >= SSEC_PW_ENV)
> -    msg (M_WARN, "WARNING: the current --script-security setting may allow passwords to be passed to scripts via environmental variables");
> -  else
> -    msg (M_WARN, "NOTE: " PACKAGE_NAME " 2.1 requires '--script-security 2' or higher to call user-defined scripts or executables");
> + /* Check if a script is used and print approiate warnings */
> + if (o->up_script || o->ipchange || o->down_script || o->route_script
> +     || o->route_predown_script || o->auth_user_pass_verify_script
> +     || o->client_disconnect_script || o->client_connect_script
> +     || o->learn_address_script || o->tls_verify)
> +   {
> +     if (script_security >= SSEC_SCRIPTS)
> +       msg (M_WARN, "NOTE: the current --script-security setting may allow this configuration to call user-defined scripts");
> +     else if (script_security >= SSEC_PW_ENV)
> +       msg (M_WARN, "WARNING: the current --script-security setting may allow passwords to be passed to scripts via environmental variables");
> +     else
> +       msg (M_WARN, "NOTE: " PACKAGE_NAME " 2.1+ requires '--script-security 2' or higher to call user-defined scripts or executables");
> +   }
>  }
>  
>  static void
>   


