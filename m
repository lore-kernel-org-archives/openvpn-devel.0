Message-ID: <5149E6F3.8020807@...1227...>
Date: Wed, 20 Mar 2013 17:42:27 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <kicobf$9m7$1@...1062...>
In-Reply-To: <kicobf$9m7$1@...1062...>
Subject: Re: [Openvpn-devel] [PATCH] Warn when using verb levels >=7 without
 debug
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
To: Josh Cepek <josh.cepek@...1085...>
Cc: openvpn-devel@lists.sourceforge.net

Am 20.03.13 17:32, schrieb Josh Cepek:
> This patch adds a log warning when using --verb levels at 7 or higher
> when running on builds lacking debug support. Since official builds are
> now built with enable_debug=no, this warning will help developers
> identify why expected debug messages may not be present in log output.
>
> The test and message output code is omitted when built with
> enable_debug=yes or enable_small=yes.
>
> Signed-off-by: Josh Cepek <josh.cepek@...1085...>
> ---
>  src/openvpn/options.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 2eb4f91..7f8940c 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -4672,6 +4672,12 @@ add_option (struct options *options,
>      {
>        VERIFY_PERMISSION (OPT_P_MESSAGES);
>        options->verbosity = positive_atoi (p[1]);
> +#if !defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
> +      /* Warn when a debug verbosity is supplied when built without debug support */
> +      if (options->verbosity >= 7)
> +        msg (M_WARN, "NOTE: a debug verb level (--verb %d) is enabled, but this build lacks debug support.",
> +	      options->verbosity);
> +#endif
>      }
>    else if (streq (p[0], "mute") && p[1])
>      {


ACK. But I would change "debug verb" to "debug verbosity" and I think
there should be no comma before "but"

