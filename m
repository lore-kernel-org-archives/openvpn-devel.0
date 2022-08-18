From: Heiko Hund <heiko@...2662...>
Date: Thu, 18 Aug 2022 10:26:04 +0200
Message-ID: <3032908.4Ter4YMrkd@...2664...>
In-Reply-To: <20220217182234.33850-1-arne@...1227...>
References: <20220217182234.33850-1-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v3] Fix OpenVPN querying user/password
 if auth-token with user expires
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

On Donnerstag, 17. Februar 2022 19:22:34 CEST Arne Schwabe wrote:

> @@ -590,6 +590,7 @@ init_query_passwords(const struct context *c)
>      /* Auth user/pass input */
>      if (c->options.auth_user_pass_file)
>      {
> +        enable_auth_user_pass();
>  #ifdef ENABLE_MANAGEMENT
>          auth_user_pass_setup(c->options.auth_user_pass_file,
> &c->options.sc_info); #else

This should be inside the #ifdef to do exactly the same as before, i.e. 
doesn't introduce side effects potentially. But then we want to get rid of 
ENABLE_MANAGEMENT soonish, thus it may not matter.

Acked-by: Heiko Hund <heiko@...2662...>



