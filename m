Date: Mon, 14 Mar 2022 12:57:05 +0100 (CET)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <2039799592.238813.1647259025325@...2642...>
In-Reply-To: <20220313193154.9350-3-openvpn@...2080...>
References: <20220313193154.9350-1-openvpn@...2080...>
 <20220313193154.9350-3-openvpn@...2080...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v4 2/3] plug-ins: Disallow multiple
 deferred authentication plug-ins
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: David Sommerseth <openvpn@...2080...>, openvpn-devel@lists.sourceforge.net



> David Sommerseth <openvpn@...2080...> hat am 13.03.2022 20:31 geschrieben:
> diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
> index e3a89293..8236e29e 100644
> --- a/src/openvpn/plugin.c
> +++ b/src/openvpn/plugin.c
> @@ -802,7 +802,7 @@ plugin_call_ssl(const struct plugin_list *pl,
>          const char **envp;
>          const int n = plugin_n(pl);
>          bool error = false;
> -        bool deferred = false;
> +        bool deferred_auth_done = false;
>  
>          setenv_del(es, "script_type");
>          envp = make_env_array(es, false, &gc);
> @@ -824,7 +824,34 @@ plugin_call_ssl(const struct plugin_list *pl,
>                      break;
>  
>                  case OPENVPN_PLUGIN_FUNC_DEFERRED:
> -                    deferred = true;
> +                    if ((type == OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY)
> +                        && deferred_auth_done)
> +                    {
> +                        /*
> +                         * Do not allow deferred auth if a deferred auth has
> +                         * already been started.  This should allow a single
> +                         * deferred auth call to happen, with one or more
> +                         * auth calls with an instant authentication result.
> +                         *
> +                         * The plug-in API is not designed for multiple
> +                         * deferred authentications to happen, as the
> +                         * auth_control_file file will be shared across all
> +                         * the plug-ins.
> +                         *
> +                         * Since this is considered a critical configuration
> +                         * error, we bail out and exit the OpenVPN process.
> +                         */
> +                        error = true;
> +                        msg(M_FATAL,
> +                            "Exiting due to multiple authentication plug-ins "
> +                            "performing deferred authentication. Only one "

Super nitpick, but there is a second space missing here to be consistent with the other full stop.

> +                            "authentication plug-in doing deferred auth is "
> +                            "allowed.  Ignoring the result and stopping now, "
> +                            "the current authentication result is not to be "
> +                            "trusted.");
> +                        break;
> +                    }
> +                    deferred_auth_done = true;
>                      break;
>  
>                  default:

Regards,
--
Frank Lichtenheld

