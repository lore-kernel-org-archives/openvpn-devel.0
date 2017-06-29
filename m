References: <1498683921-432-1-git-send-email-arne@...1227...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <d7604f16-8385-f0de-9d87-77d954a3c0cc@...1856...>
Date: Thu, 29 Jun 2017 19:52:39 +0200
MIME-Version: 1.0
In-Reply-To: <1498683921-432-1-git-send-email-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] show the right string for key-direction
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net


On 28-06-17 23:05, Arne Schwabe wrote:
> ---
>  src/openvpn/options.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 61af6e3a..d8049e76 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -1697,7 +1697,7 @@ show_settings(const struct options *o)
>  
>  #ifdef ENABLE_CRYPTO
>      SHOW_STR(shared_secret_file);
> -    SHOW_INT(key_direction);
> +    SHOW_PARM(key_direction, keydirection2ascii(o->key_direction, false), "%s");
>      SHOW_STR(ciphername);
>      SHOW_BOOL(ncp_enabled);
>      SHOW_STR(ncp_ciphers);
> 

Makes sense, but keydirection2acrii() can return NULL, which technically
is undefined behaviour as input for a %s format string specifier...

I know it's slightly lame, but still think either keydirection2ascii
should always return a valid string, or this needs to wrapped in a np()
call.

-Steffan

