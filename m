References: <20210401131337.3684-1-arne@...1227...>
 <20210401131337.3684-5-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <d29a2be4-ee2f-6492-17e6-e5a21b9a6a49@...2181...>
Date: Sat, 3 Apr 2021 18:22:58 +0200
MIME-Version: 1.0
In-Reply-To: <20210401131337.3684-5-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 04/14] Add documentation on
 EVENT_READ/EVENT_WRITE constants
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net



On 01/04/2021 15:13, Arne Schwabe wrote:
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/forward.c |  3 ++-
>  src/openvpn/openvpn.h | 12 +++++++++++-
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index 6f7a50048..98caf6651 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -1880,7 +1880,8 @@ io_wait_dowork(struct context *c, const unsigned int flags)
>      unsigned int tuntap = 0;
>      struct event_set_return esr[4];
>  
> -    /* These shifts all depend on EVENT_READ and EVENT_WRITE */
> +    /* These shifts all depend on EVENT_READ (=1) and EVENT_WRITE (=2) */
> +    /* and are added to the shift. */

I suggest making a classic multiline comment here, instead of two single
lines.

>      static int socket_shift = 0;   /* depends on SOCKET_READ and SOCKET_WRITE */
>      static int tun_shift = 2;      /* depends on TUN_READ and TUN_WRITE */
>      static int err_shift = 4;      /* depends on ES_ERROR */
> diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
> index 0ddaeb730..322ab3ee1 100644
> --- a/src/openvpn/openvpn.h
> +++ b/src/openvpn/openvpn.h
> @@ -245,7 +245,17 @@ struct context_2
>      int event_set_max;
>      bool event_set_owned;
>  
> -    /* event flags returned by io_wait */
> +    /* event flags returned by io_wait,

colon or period instead of comma?

> +     * All these event are their respective shift as defined in io_wait_dowork
> +     * adding a shift of 0 for the READ event and 1 for the write event.
> +     *
> +     * E.g. management_shift = 6;
> +     * MANAGMENT_READ = (1<<(6+0)),
> +     * MANAGEMNET_WRITE = (1<<(6+1))
> +     *
> +     * Some shifts (error, file_close) are using read/write for diferent

diferent -> different

> +     * signals.
> +     */
>  #define SOCKET_READ       (1<<0)
>  #define SOCKET_WRITE      (1<<1)
>  #define TUN_READ          (1<<2)
> 

I get what you are trying to describe, but it is not easy to grasp
without jumping back and forth between openvpn.h, forward.c and events.c.

Instead of talking about shifts, why not going high level and explain
how the bitmask is supposed to look like (i.e. 2 bits are associated
with each class of operations. The first bit is a READ event, the second
one is a WRITE event..etc..).

Opinions?

In this patch you could even move the definition of all the *_shift to
openvpn.h, next to the various _READ and _WRITE, since they are all related.

What do you think? Would it make sense?

Cheers,

-- 
Antonio Quartulli

