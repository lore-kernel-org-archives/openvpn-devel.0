References: <20200709101603.11941-1-arne@...1227...>
 <20200709101603.11941-8-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <2deb5ad8-8a86-430f-80c1-631cf3cb09f7@...2181...>
Date: Thu, 9 Jul 2020 21:22:44 +0200
MIME-Version: 1.0
In-Reply-To: <20200709101603.11941-8-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 8/8] Code cleanup: remove superflous
 variable
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 09/07/2020 12:16, Arne Schwabe wrote:
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/ssl.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 4ee4c245..54a23011 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -1231,11 +1231,10 @@ lame_duck_must_die(const struct tls_session *session, interval_t *wakeup)
>      const struct key_state *lame = &session->key[KS_LAME_DUCK];
>      if (lame->state >= S_INITIAL)
>      {
> -        const time_t local_now = now;
>          ASSERT(lame->must_die); /* a lame duck key must always have an expiration */
> -        if (local_now < lame->must_die)
> +        if (now < lame->must_die)
>          {
> -            compute_earliest_wakeup(wakeup, lame->must_die - local_now);
> +            compute_earliest_wakeup(wakeup, lame->must_die - now);

The only reason for having this local variable is the case where this
code would run concurrently with a thread that could update "now" behind
our back.

Since openvpn runs in a single thread, such scenario is not possible at all.

For this reason this patch makes sense and it removes one more bit that
was originally introduced in the attempt of implementing multi threading.

Acked-by: Antonio Quartulli <a@...2181...>

>              return false;
>          }
>          else
> 

-- 
Antonio Quartulli

