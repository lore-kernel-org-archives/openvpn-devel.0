References: <20150701154039.GG382@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <55FA7AB0.2020202@...1227...>
Date: Thu, 17 Sep 2015 09:32:48 +0100
MIME-Version: 1.0
In-Reply-To: <20150701154039.GG382@...1296...>
Subject: Re: [Openvpn-devel] RfD: speed up PUSH_REQUEST...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net



Am 01.07.15 um 16:40 schrieb Gert Doering:
> Hi,
>
> experimenting with the MTU patch, I discovered that we basically sit
> idle for two seconds on the client between "TLS is up!" and "PUSH_REQUEST".
>
> This is part due to the coarse granularity of, well, our coarse timers,
> but in part due to *two* timers having to fire...
>
> - TLS is done, we schedule an "wait_for_connect" timer to fire in +1 second
>   (init.c, do_init_timers())
>
> - when that timer fires, 1 second after TLS completes, we set up *another*
>   timer inside check_connection_established_dowork(), that is intended to
>   fire in +1 second
>
> - +1 second later, we send PUSH_REQUEST
>
> due to the calling sequence and check_push_request() being called right
> after check_connection_established(), it seems to be fairly safe to just
> set up the event to "fire right away" (*having* the event is needed to
> be able to reset it to "fire again in +5 seconds").
>
> So, with the patch below on top of the MTU patch, connection times to a
> server which is 150ms away from me went down from 5 seconds to 2 seconds
> - which I consider quite significant :-)
>
> Anyone better versed in the history of this code who can tell me whether
> this is safe, or why the extra delay is there?
>
> gert
>
>
>
>
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index 6d459d2..e1571ec 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -212,8 +212,8 @@ check_connection_established_dowork (struct context *c)
>  					0);
>  		}
>  #endif
> -	      /* send push request in 1 sec */
> -	      event_timeout_init (&c->c2.push_request_interval, 1, now);
> +	      /* fire up push request right away (already 1s delayed) */
> +	      event_timeout_init (&c->c2.push_request_interval, 0, now);
>  	      reset_coarse_timers (c);
>  	    }
>  	  else

ACK on the basis that it looks right and none of my Android users has a
problem with this patch.

Arne

