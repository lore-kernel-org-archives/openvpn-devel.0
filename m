Date: Mon, 23 May 2022 12:21:29 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <747321434.258660.1653301289545@...2642...>
In-Reply-To: <20220523091724.3418887-1-arne@...1227...>
References: <20220523091724.3418887-1-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Fix client-pending-auth error message
 to say ERROR instead of SUCCESS
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Acked-By: Frank Lichtenheld <frank@...2641...>

Trivial.

> Arne Schwabe <arne@...1227...> hat am 23.05.2022 11:17 geschrieben:
> 
>  
> ---
>  src/openvpn/manage.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
> index aeea5f9ff..9c07bf298 100644
> --- a/src/openvpn/manage.c
> +++ b/src/openvpn/manage.c
> @@ -989,7 +989,7 @@ man_client_pending_auth(struct management *man, const char *cid_str,
>              }
>              else
>              {
> -                msg(M_CLIENT, "SUCCESS: client-pending-auth command failed."
> +                msg(M_CLIENT, "ERROR: client-pending-auth command failed."
>                      " Extra paramter might be too long");

We might want to fix "parameter" at the same time.

Regards,
--
Frank Lichtenheld

