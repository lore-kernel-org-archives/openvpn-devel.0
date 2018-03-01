MIME-Version: 1.0
In-Reply-To: <20180102222854.29198-1-steffan@...1856...>
References: <20180102222002.21454-1-steffan@...1856...>
 <20180102222854.29198-1-steffan@...1856...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 28 Feb 2018 23:15:24 -0500
Message-ID: <CAKuzo_gLMrhLj9CiHBkvG18_AOm1Ex=ktPNA-Ye9eDW9iF=P8w@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Check for time_t overflow in
 event_timeout_trigger()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Tue, Jan 2, 2018 at 5:28 PM, Steffan Karger <steffan@...1856...> wrote:
> As reported in trac #922, the wakeup computation in
> event_timeout_trigger() could overflow.  Since time_t and int are signed
> types, that is officially undefined behvaiour.
>
> On systems with a 64-bit signed time_t (most if not all 64-bit system),
> the overflow was caused by the (unnecessary) cast to "int".  Removing
> that, changing the time of "wakeup" to time_t, and assuming that the
> system clock on our host system will never be set to the year
> 292471210579 or later, this can no longer overflow on systems with a
> 64-bit time_t.
>
> For systems with a signed 32-bit time_t however, we need an additional
> check to prevent signed overflow (and thus undefined behaviour).  Since
> time_t is only specified by C99 to be "an arithmetic type capable of
> representing times", and no TIME_MAX or TIME_MIN macros are available,
> checking for overflow is not trivial at all.  This patch takes the
> practical approach, and assumes that time_t is of type "long int" (aka
> "long") or "long long int" (aka "long long").  POSIX requires time_t to
> be an "integer type", and all systems I know of use a long int or long
> long int.  To be sure that this assumption holds, this patch uses static
> asserts.
>
> Since I can't come up with anything useful to do if this check fails,
> and the input are not based on remote input, this patch just turns the
> undefined behaviour into a defined ASSERT().
>
> And while we touch this function, make it obey the 80-char line length
> limit.
>
> So much for this "simple" overflow check.
>
> Trac: #922
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
> v2: Fix (#if 0'd) debug print format specifier for changed type.
>
>  src/openvpn/integer.h  | 14 ++++++++++++++
>  src/openvpn/interval.c |  9 ++++++---
>  2 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/src/openvpn/integer.h b/src/openvpn/integer.h
> index 9bb00a38..51085450 100644
> --- a/src/openvpn/integer.h
> +++ b/src/openvpn/integer.h
> @@ -77,6 +77,20 @@ constrain_int(int x, int min, int max)
>      }
>  }
>
> +/** Return true if the addition of a and b would overflow. */
> +static inline bool
> +time_t_add_overflow(time_t a, time_t b) {
> +    static_assert(((time_t) -1) < 0, "OpenVPN assumes time_t is signed");
> +    static_assert(((time_t) .9) == 0, "OpenVPN assumes time_t is integer type");
> +    static_assert(sizeof(time_t) == sizeof(long) || sizeof(time_t) == sizeof(long long),
> +        "OpenVPN assumes that time_t is of type long int or long long int");
> +    static const time_t TIME_MAX = sizeof(time_t) == sizeof(long) ?
> +            LONG_MAX : LLONG_MAX;
> +    static const time_t TIME_MIN = sizeof(time_t) == sizeof(long) ?
> +            LONG_MIN : LLONG_MIN;
> +    return (a > 0 && b > TIME_MAX - a) || (a < 0 && b < TIME_MIN - a);
> +}
> +

Finally I've to agree that jumping through all those hoops is
necessary to check overflow in time_t type. Good to note that its
still very efficient as all except the last line are evaluated at
compile time.

That said, in this particular case, there is a better way out:

>  /*
>   * Functions used for circular buffer index arithmetic.
>   */
> diff --git a/src/openvpn/interval.c b/src/openvpn/interval.c
> index 16343865..909e3fcd 100644
> --- a/src/openvpn/interval.c
> +++ b/src/openvpn/interval.c
> @@ -51,11 +51,13 @@ event_timeout_trigger(struct event_timeout *et,
>
>      if (et->defined)
>      {
> -        int wakeup = (int) et->last + et->n - local_now;
> +        ASSERT(!time_t_add_overflow(et->last, et->n));
> +        time_t wakeup = et->last + et->n - local_now;

We can avoid all overflow and eliminate the check and the ASSERT
by writing it as

time_t wakeup = (et->last - local_now) + et->n; // parens added for clarity

For the first subtraction to overflow, last and now have to differ by
> INT_MAX (for 32 bit time_t), not something we should worry about
(can't happen in normal operation).
Further, the term in brackets is always negative (as now >= last),
while et->n is positive and < INT_MAX by construction. So the final
addition also cannot overflow. All assuming that 32 bit "now" and
"last" are not used beyond 2037.

That would take care of this particular overflow concern.

>          if (wakeup <= 0)
>          {
>  #if INTERVAL_DEBUG
> -            dmsg(D_INTERVAL, "EVENT event_timeout_trigger (%d) etcr=%d", et->n, et_const_retry);
> +            dmsg(D_INTERVAL, "EVENT event_timeout_trigger (%d) etcr=%d", et->n,
> +                 et_const_retry);
>  #endif
>              if (et_const_retry < 0)
>              {
> @@ -72,7 +74,8 @@ event_timeout_trigger(struct event_timeout *et,
>          if (tv && wakeup < tv->tv_sec)
>          {
>  #if INTERVAL_DEBUG
> -            dmsg(D_INTERVAL, "EVENT event_timeout_wakeup (%d/%d) etcr=%d", wakeup, et->n, et_const_retry);
> +            dmsg(D_INTERVAL, "EVENT event_timeout_wakeup (%ld/%d) etcr=%d",
> +                 (long) wakeup, et->n, et_const_retry);
>  #endif
>              tv->tv_sec = wakeup;
>              tv->tv_usec = 0;
> --

Selva

P.S.

If and when we do need to check for overflow, it may be useful to define
the check to match the signature of builtins like

bool __builtin_add_overflow (type1 a, type2 b, type3 *res)
          [gcc 5+ and clang 7+].

That would allow drop-in replacement when such builtins are more
widely available.

