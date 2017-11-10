References: <87k1zi18lt.fsf@...2274...>
 <201711041834.vA4IYfGA026870@...2054...>
 <87375t6qas.fsf@...2274...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <bcde5965-7932-2647-36ad-64fb62ee37cf@...1856...>
Date: Fri, 10 Nov 2017 12:55:28 +0100
MIME-Version: 1.0
In-Reply-To: <87375t6qas.fsf@...2274...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Print time_t as long long
 and suseconds_t as long
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

Hi,

On 05-11-17 10:14, Jeremie Courreges-Anglas wrote:
> Here's another small diff, I forgot one suseconds_t occurrence.
>
> From cbe8237ff59129501e1e92c8fd6a3488d94c4c0f Mon Sep 17 00:00:00 2001
> From: Jeremie Courreges-Anglas <jca@...2272...>
> Date: Sun, 5 Nov 2017 10:03:26 +0100
> Subject: [PATCH] Cast and print another suseconds_t as long
> 
> Missed in 31b5c0e
> ---
>  src/openvpn/forward.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index a91a8d9a..1b7455bb 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -649,7 +649,7 @@ check_timeout_random_component_dowork(struct context *c)
>      c->c2.timeout_random_component.tv_usec = (time_t) get_random() & 0x0003FFFF;
>      c->c2.timeout_random_component.tv_sec = 0;
>  
> -    dmsg(D_INTERVAL, "RANDOM USEC=%d", (int) c->c2.timeout_random_component.tv_usec);
> +    dmsg(D_INTERVAL, "RANDOM USEC=%ld", (long) c->c2.timeout_random_component.tv_usec);
>  }
>  
>  static inline void
> -- 
> 2.14.3

Makes sense.

Acked-by: Steffan Karger <steffan@...1856...>

-Steffan

