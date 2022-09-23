Date: Fri, 23 Sep 2022 12:12:18 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Yy2Ggixtz/Uo1RVZ@...2685...>
References: <20220923085804.3743109-1-arne@...1227...>
MIME-Version: 1.0
In-Reply-To: <20220923085804.3743109-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Document/cleanup event_timeout functions
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

On Fri, Sep 23, 2022 at 10:58:04AM +0200, Arne Schwabe wrote:
> Remove function event_timeout_clear_ret as it is unused.
> 
> Cleanup event_timeout_trigger a bit. Do an instant return false if the
> timeout is not defined and inline local_now and use
> event_timeout_remaining instead of local duplicated code.

That part best seen with git diff -w ;)
Changes look good to me.

> Add doxygen comments for all timeout function, especially for the
> event_timeout_trigger function that is hard to understand otherwise.

Some comments on those below.

> diff --git a/src/openvpn/interval.h b/src/openvpn/interval.h
> index f58bfacf6..f6e40705c 100644
> --- a/src/openvpn/interval.h
> +++ b/src/openvpn/interval.h
> @@ -135,9 +135,9 @@ interval_action(struct interval *top)
>  
>  struct event_timeout
>  {
> -    bool defined;
> -    interval_t n;
> -    time_t last; /* time of last event */
> +    bool defined;       /**< This timeout is active */
> +    interval_t n;       /**< periodic interval for periodic timeouts */
> +    time_t last;        /**< time of last event */
>  };
>  
>  static inline bool
> @@ -145,7 +145,12 @@ event_timeout_defined(const struct event_timeout *et)
>  {
>      return et->defined;
>  }
> -
> +/**
> + * Clears the timeout and reset all values to 0. Following timer checks will
> + * not trigger.
> + *
> + * @param et    timer struct
> + */
>  static inline void
>  event_timeout_clear(struct event_timeout *et)
>  {
> @@ -154,22 +159,30 @@ event_timeout_clear(struct event_timeout *et)
>      et->last = 0;
>  }
>  
> -static inline struct event_timeout
> -event_timeout_clear_ret(void)
> -{
> -    struct event_timeout ret;
> -    event_timeout_clear(&ret);
> -    return ret;
> -}
>  
> +/**
> + * Initialises a timer struct. The timer will become true/trigger after last + n seconds

Add period for consistency.

> + *
> + *
> + * @param et            Timer struct
> + * @param n             Interval of the timer for periodic timer. A negative value for n will be interpreted as 0

Add period for consistency. Wrap text? 113 is a bit broad.

> + * @param last          Sets the base time of the timer.
> + */
>  static inline void
> -event_timeout_init(struct event_timeout *et, interval_t n, const time_t local_now)
> +event_timeout_init(struct event_timeout *et, interval_t n, const time_t last)
>  {
>      et->defined = true;
>      et->n = (n >= 0) ? n : 0;
> -    et->last = local_now;
> +    et->last = last;
>  }
>  
> +/**
> + * Reset a timer.

"Resets" for consistency.

> + *
> + * Sets the last time the timer has been triggered for the calculation of the
> + * next event.
> + * @param et
> + */
>  static inline void
>  event_timeout_reset(struct event_timeout *et)
>  {
> @@ -179,6 +192,12 @@ event_timeout_reset(struct event_timeout *et)
>      }
>  }
>  
> +/**
> + * Sets the periodic parameter n of a timeout.

"interval" instead of "periodic parameter" for consistency?

> + * @param et
> + * @param n set the periodic value of a timeout, negative values
> + *          will be interpreted as 0

Redundant description. Maybe more like

* @param n  Interval of the timer. A negative value for n will be interpreted as 0

> + */
>  static inline void
>  event_timeout_modify_wakeup(struct event_timeout *et, interval_t n)
>  {

Just below here there is an additional comment inside the function:
/* note that you might need to call reset_coarse_timers after this */

That should be moved into the doxygen comment.

> @@ -189,32 +208,47 @@ event_timeout_modify_wakeup(struct event_timeout *et, interval_t n)
>      }
>  }
>  
> -/*
> - * Will return the time left for a timeout, this function does not check
> - * if the timeout is actually valid
> +/**
> + * Return time until the timeout should triggered from from now,
> + * this function does not check if the timeout is actually valid.
>   */

"Returns" for consistency.
"now, this" -> "now. This"

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
> + * If *et is not triggered *tv is set to remaining time until the timeout if
> + * not already lower:
> + *
> + *      *tv = minimum(*tv, event_timeout_remaining(*et))
> + *
> + * If *et triggers and et_const_retry is negative (ETT_DEFAULT is -1):
> + *  - the function will return true
> + *  - *et will be armed for the next event (et->last set to now).
> + *  - *tv will be lowered to the event period (n) if larger than the
> + *     period of the event (set to *et's next timeout)
> + *
> + * If *et triggers and et_const_retry >= 0, *tv be reduced to et_const_try if

"will be"

> + * larger:
> + *
> + *    *tv = *minimum(*tv, et_const_retry)

I think this should explicitly mention that et is NOT re-armed and explain why
you would want to use that.

> + *
> + *
> + * @param et                the timeout to check
> + * @param tv                will be set to timeout for next check for this timeout unless already small.

"smaller"

> + * @param et_const_retry    see above

"above" does not actually explain why you would use this. See above ;)

> + * @return                  if the timeout has triggered and event has been reset
> + */

You're mixing lowered/lower and reduced/larger/smaller. I think it would be better
to only use one of those.

>  bool event_timeout_trigger(struct event_timeout *et,
>                             struct timeval *tv,
> -                           const int et_const_retry);
> +                           int et_const_retry);

Why remove the const here? You did not remove it in interval.c

>  
>  /*
>   * Measure time intervals in microseconds
> diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
> index 00cd652fa..aae1d21b8 100644
> --- a/src/openvpn/openvpn.h
> +++ b/src/openvpn/openvpn.h
> @@ -386,7 +386,9 @@ struct context_2
>       * Event loop info
>       */
>  
> -    /* how long to wait on link/tun read before we will need to be serviced */
> +    /* time to next event of timers and similar. This is used to determine

"Time"

> +     * how long to wait on event wait (select/poll on link/tun read)
> +     * before this context wants to be serviced */

Add period for consistency

>      struct timeval timeval;
>  
>      /* next wakeup for processing coarse timers (>1 sec resolution) */
> -- 
> 2.37.0 (Apple Git-136)

Regards,
-- 
  Frank Lichtenheld

