Date: Tue, 26 Apr 2022 12:12:04 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <90135028.415930.1650967924403@...2642...>
In-Reply-To: <20220422142953.3805364-5-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
 <20220422142953.3805364-5-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 14/28] Move tls_process_state into its
 own function
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Acked-By: Frank Lichtenheld <frank@...2641...> (small issues mentioned below)

Verified visually that this only moves code around and doesn't change behavior.
Only compile/UT tested.

This one actually fixes the spurious whitespace I complained about
in 13/28 but that hunk should just be moved to there.

You removed one comment from the function. See below. But it might
not have been helpful to begin with.

> Arne Schwabe <arne@...1227...> hat am 22.04.2022 16:29 geschrieben:
> 
>  
> This function does most of the state transitions in the TLS state
> machine. Moving it into its own function removes an intention area and
> makes tls_process function easier to understand as the loop is more
> obvious.
> 
> This is largely just a code move with small expection. bool active is
> no longer directly set but inferred from to_link->len
> ---
>  src/openvpn/ssl.c | 444 ++++++++++++++++++++++++----------------------
>  1 file changed, 228 insertions(+), 216 deletions(-)
> 
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 4ca093243..15af58949 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -2433,7 +2433,7 @@ session_move_pre_start(const struct tls_session *session,
>  
>  /**
>   * Moves the key to state to S_ACTIVE and also advances the multi_state state
> - * machine if this is the initial connection. 
> + * machine if this is the initial connection.

Mentioned whitespace fix.

> @@ -2541,209 +2750,15 @@ tls_process(struct tls_multi *multi,
>               state_name(ks_lame->state),
>               to_link->len,
>               *wakeup);
> +        state_change = tls_process_state(multi, session, to_link, to_link_addr,
> +                                         to_link_socket_info, wakeup);
>  
> -        state_change = false;
> -
> -        /*
> -         * TLS activity is finished once we get to S_ACTIVE,
> -         * though we will still process acknowledgements.
> -         *
> -         * CHANGED with 2.0 -> now we may send tunnel configuration
> -         * info over the control channel.
> -         */

You completely removed this comment.

Regards,
--
Frank Lichtenheld

