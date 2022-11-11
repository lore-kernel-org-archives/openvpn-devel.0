Message-ID: <2f57bd32-b033-1474-479d-118922440d23@...1227...>
Date: Fri, 11 Nov 2022 14:17:51 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20221111102031.8402-1-kprovost@...2661...>
 <20221111102031.8402-2-kprovost@...2661...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20221111102031.8402-2-kprovost@...2661...>
Subject: Re: [Openvpn-devel] [PATCH] FreeBSD DCO: support AES-192-GCM
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
To: Kristof Provost <kprovost@...2661...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Am 11.11.22 um 11:20 schrieb Kristof Provost via Openvpn-devel:
> From: Kristof Provost <kp@...1376...>
> 
> As of 2c58d0cb3bb3e3a5b714ffac940500efbe5303ca FreeBSD also allows
> AES-192-GCM in DCO. Announce this support.
> 
> Signed-off-by: Kristof Provost <kprovost@...2661...>
> ---
>   src/openvpn/dco_freebsd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
> index c8361028..8e5ee436 100644
> --- a/src/openvpn/dco_freebsd.c
> +++ b/src/openvpn/dco_freebsd.c
> @@ -667,7 +667,7 @@ dco_event_set(dco_context_t *dco, struct event_set *es, void *arg)
>   const char *
>   dco_get_supported_ciphers()
>   {
> -    return "none:AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305";
> +    return "none:AES-256-GCM:AES-192-GCM:AES-128-GCM:CHACHA20-POLY1305";
>   }
>   
>   #endif /* defined(ENABLE_DCO) && defined(TARGET_FREEBSD) */

Acked-By: Arne Schwabe <arne@...1227...>

