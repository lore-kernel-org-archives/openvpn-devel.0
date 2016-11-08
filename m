References: <1478598242-23514-1-git-send-email-gert@...1296...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <08f37428-ac6d-c354-7ba4-98ea121bcab7@...1435...>
Date: Tue, 8 Nov 2016 11:06:07 +0100
MIME-Version: 1.0
In-Reply-To: <1478598242-23514-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Fix potential division by zero in
 shaper_reset()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 08-11-16 10:44, Gert Doering wrote:
> shaper_reset() is only ever called with "bytes_per_second" set to
> a non-zero value - so the whole check "is it zero? if not, use
> constrain_int() to make sure it is within bounds" is not needed ->
> reduce check to just constrain_int() so even if somebody would
> call shaper_reset(..., 0) it would not lead to a div-by-zero.
> 
> Found by Coverity.
> 
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/shaper.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/shaper.h b/src/openvpn/shaper.h
> index afeb9c3..fa132c4 100644
> --- a/src/openvpn/shaper.h
> +++ b/src/openvpn/shaper.h
> @@ -75,7 +75,7 @@ bool shaper_soonest_event (struct timeval *tv, int delay);
>  static inline void
>  shaper_reset (struct shaper *s, int bytes_per_second)
>  {
> -  s->bytes_per_second = bytes_per_second ? constrain_int (bytes_per_second, SHAPER_MIN, SHAPER_MAX) : 0;
> +  s->bytes_per_second = constrain_int (bytes_per_second, SHAPER_MIN, SHAPER_MAX);
>  
>  #ifdef SHAPER_USE_FP
>    s->factor = 1000000.0 / (double)s->bytes_per_second;

ACK

-Steffan

