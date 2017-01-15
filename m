References: <20170115061718.3218-1-praiskup@...1347...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <3821af27-817b-9ee5-29db-bf3516bcdad3@...1856...>
Date: Sun, 15 Jan 2017 09:52:46 +0100
MIME-Version: 1.0
In-Reply-To: <20170115061718.3218-1-praiskup@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] options: allow setting default --ca
 argument value
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 15-01-17 07:17, Pavel Raiskup wrote:
> Adding a new --with-ca-bundle configure option.  It's argument is
> used as default CA file when no --ca option is specified at
> runtime.
> 
> This option is primarily designed for systems where users are
> allowed to manage trusted authorities for whole system (in one
> consolidated file; usually implemented in 'ca-certificates'
> package).
> 
> Signed-off-by: Pavel Raiskup <praiskup@...1347...>
> ---
>  configure.ac          | 5 +++++
>  src/openvpn/options.c | 9 +++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/configure.ac b/configure.ac
> index 43487b0..f5e1e63 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -308,6 +308,11 @@ AC_ARG_WITH(
>  	[with_plugindir="\$(libdir)/openvpn/plugins"]
>  )
>  
> +AC_ARG_WITH(
> +	[ca-bundle],
> +	[AS_HELP_STRING([--with-ca-bundle], [use consolidated CA bundle])],
> +	[AC_DEFINE_UNQUOTED([DEFAULT_CA_FILE], ["$withval"], [Default --ca argument])]
> +)
>  
>  AC_DEFINE_UNQUOTED([TARGET_ALIAS], ["${host}"], [A string representing our host])
>  case "$host" in
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index d9c384e..92d81ae 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -3000,6 +3000,15 @@ options_postprocess_mutate(struct options *o)
>      }
>  #endif
>  
> +#ifdef DEFAULT_CA_FILE
> +    if (!o->ca_file && !platform_access(DEFAULT_CA_FILE, R_OK))
> +    {
> +        msg(M_WARN, "option '--ca' unspecified; using system bundle '%s'",
> +            DEFAULT_CA_FILE);
> +        o->ca_file = DEFAULT_CA_FILE;
> +    }
> +#endif
> +
>  #if ENABLE_MANAGEMENT
>      if (o->http_proxy_override)
>      {
> 

Feature-NAK.  OpenVPN should use it's own CA, not the system CA list.

There is no reason to allow hundreds of parties in the world to
man-in-the-middle your OpenVPN connections.  Please please please do not
use your system CA list for OpenVPN, just specify the CA you do want to
trust.

(OpenVPN is /not/ WWW, don't think about OpenVPN's usage of CAs as if it
were the WWW.)

-Steffan

