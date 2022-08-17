Message-ID: <7837867f-24de-4f69-9da0-7bcd26b53f56@...2181...>
Date: Wed, 17 Aug 2022 16:35:01 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220316102317.3356246-1-arne@...1227...>
 <20220817135348.844178-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220817135348.844178-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2] Fix IV_PLAT_VER and UV_ variables
 sent without push-peer-info
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 17/08/2022 15:53, Arne Schwabe wrote:
> Commit 8c72d7981 changed the push_peer_info_detail to have an
> additional level for P2P NCP and shifting most of the other levels
> with 1. The check for UV_ and IV_PLAT_VER was not changed accordingly.
> 
> Fixes: 8c72d7981 ("Support NCP in pure P2P VPN setups")
> Signed-off-by: Arne Schwabe <arne@...1227...>

Same as v1, just rebased and with an extended commit message.

Tested by setting some UV_VAR and seeing it being sent only with 
--push-peer-info.

Acked-by: Antonio Quartulli <a@...2181...>

> ---
>   src/openvpn/ssl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 77f572a40..33e145b3f 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -2036,7 +2036,7 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
>                   {
>                       if ((((strncmp(e->string, "UV_", 3) == 0
>                              || strncmp(e->string, "IV_PLAT_VER=", sizeof("IV_PLAT_VER=") - 1) == 0)
> -                          && session->opt->push_peer_info_detail >= 2)
> +                          && session->opt->push_peer_info_detail > 2)
>                            || (strncmp(e->string, "IV_GUI_VER=", sizeof("IV_GUI_VER=") - 1) == 0)
>                            || (strncmp(e->string, "IV_SSO=", sizeof("IV_SSO=") - 1) == 0)
>                            )

-- 
Antonio Quartulli

