From: Heiko Hund <heiko@...2662...>
Date: Thu, 18 Aug 2022 16:39:16 +0200
Message-ID: <8703215.ESkQ3JELAO@...2664...>
In-Reply-To: <20220520213250.3126372-5-arne@...1227...>
References: <20220520213250.3126372-1-arne@...1227...>
 <20220520213250.3126372-5-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2 4/4] Allow scripts and plugins to set
 a custom AUTH_FAILED message
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

What Frank said, and the nitpick about this hunk which should be removed:

On Freitag, 20. Mai 2022 23:32:50 CEST Arne Schwabe wrote:
> @@ -1376,6 +1440,7 @@ verify_user_pass_plugin(struct tls_session *session,
> struct tls_multi *multi, /* call command */
>      retval = plugin_call(session->opt->plugins,
> OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY, NULL, NULL, session->opt->es);
> 
> +
>      if (retval == OPENVPN_PLUGIN_FUNC_DEFERRED)
>      {
>          /* Check if the plugin has written the pending auth control





