Date: Fri, 7 Oct 2022 11:44:01 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Yz/04cmanSoMHRIc@...2685...>
References: <20220923085804.3743109-1-arne@...1227...>
 <20221006122940.1202712-1-arne@...1227...>
MIME-Version: 1.0
In-Reply-To: <20221006122940.1202712-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2] Document/cleanup event_timeout
 functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, Oct 06, 2022 at 02:29:40PM +0200, Arne Schwabe wrote:
> Remove function event_timeout_clear_ret as it is unused.
> 
> Cleanup event_timeout_trigger a bit. Do an instant return false if the
> timeout is not defined and inline local_now and use
> event_timeout_remaining instead of local duplicated code.
> 
> Add doxygen comments for all timeout function, especially for the
> event_timeout_trigger function that is hard to understand otherwise.
> 
> Patch v2: add many fixes/correction suggested by Frank
> 

The new sentences have some small issues. Gert can probably fix them on
apply.

Acked-By: Frank Lichtenheld <frank@...2641...>

[...]
> -/*
> - * Will return the time left for a timeout, this function does not check
> - * if the timeout is actually valid
> +/**
> + * Returns the time until the timeout should triggered from from now.

"should be triggered, from \c now."

> + * This function does not check if the timeout is actually valid.
>   */
>  static inline interval_t
>  event_timeout_remaining(struct event_timeout *et)
>  {
> -    return (interval_t) (et->last - now + et->n);
> +    return (interval_t) ((et->last + et->n) - now);
>  }
>  
> -/*
> - * This is the principal function for testing and triggering recurring
> - * timers and will return true on a timer signal event.
> - * If et_const_retry == ETT_DEFAULT and a signal occurs,
> - * the function will return true and *et will be armed for the
> - * next event.  If et_const_retry >= 0 and a signal occurs,
> - * *et will not be touched, but *tv will be set to
> - * minimum (*tv, et_const_retry) for a future re-test,
> - * and the function will return true.
> - */
> -
>  #define ETT_DEFAULT (-1)
>  
> +/**
> + * This is the principal function for testing and triggering recurring
> + * timers.
> + *
> + * If *et is not triggered, *tv is set to remaining time until the timeout if
> + * not already lower:
> + *
> + *      *tv = minimum(*tv, event_timeout_remaining(*et))
> + *
> + * If *et triggers and et_const_retry is negative (ETT_DEFAULT is -1):
> + *  - the function will return true
> + *  - *et will be armed for the next event (et->last set to now).
> + *  - *tv will be lowered to the event period (n) if larger than the
> + *     period of the event (set to *et's next timeout)
> + *  - *et will not changed (ie also not rearmed, stays armed)
> + *
> + * If *et triggers and et_const_retry >= 0, *tv will be lowered to et_const_try
> + * if larger:
> + *
> + *    *tv = *minimum(*tv, et_const_retry)
> + *
> + * This is mainly useful is the trigger cannot yet be triggered for other

"if the trigger"

> + * reasons and a backoff timeout should be returned if the timer is ready
> + * to trigger.
> + *
> + *
> + * @param et                the timeout to check
> + * @param tv                will be set to timeout for next check for this
> + *                          timeout unless already smaller.
> + * @param et_const_retry    see above
> + * @return                  if the timeout has triggered and event has been reset
> + */
>  bool event_timeout_trigger(struct event_timeout *et,
>                             struct timeval *tv,
> -                           const int et_const_retry);
> +                           int et_const_retry);
>  
>  /*
>   * Measure time intervals in microseconds
> diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
> index 00cd652fa..95c7d7520 100644
> --- a/src/openvpn/openvpn.h
> +++ b/src/openvpn/openvpn.h
> @@ -386,7 +386,9 @@ struct context_2
>       * Event loop info
>       */
>  
> -    /* how long to wait on link/tun read before we will need to be serviced */
> +    /** Time to next event of timers and similar. This is used to determine
> +     *  how long to wait on event wait (select/poll on link/tun read)
> +     *  before this context wants to be serviced */

Add period for consistency.

>      struct timeval timeval;
>  
>      /* next wakeup for processing coarse timers (>1 sec resolution) */

Regards,
-- 
  Frank Lichtenheld

