References: <57239121.8000704@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <57239518.9020503@...1227...>
Date: Fri, 29 Apr 2016 20:08:40 +0300
MIME-Version: 1.0
In-Reply-To: <57239121.8000704@...277...>
Subject: Re: [Openvpn-devel] Artificial delays during connection setup
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
To: Jiri Horky <jiri.horky@...277...>, openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?B?SmnFmcOtIEphaG4=?= <jahn@...2025...>, =?UTF-8?B?xI0=?= <zubac@...2025...>, =?UTF-8?B?VsOtdCBIZcWZbWFu?= <herman@...2025...>

Am 29.04.16 um 19:51 schrieb Jiri Horky:
> Hi list,
> 
> I was wondering why the connection setup on Linux with openvpn 2.3.10
> takes about 2.5s even on local network and dig deeper in the code. It
> seems there are two places where an artificial delay of 1s is added.
> 
> First one is waiting before checking the connection status is checked in
> src/openvpn/init.c
> 
> 1108   if (!deferred)
> 1109   {
> 1110     /* initialize connection establishment timer */
> 1111     event_timeout_init (&c->c2.wait_for_connect, 1, now);
> 1112

I think nobody knows anymore why there is this timeout and without
proper testing/codereview just removing it might be a bit dangerous.

> 
> And the second one is waiting before sending push_request in
> src/openvpn/forward.c:
> 
>  218         /* send push request in 1 sec */
>  219         event_timeout_init (&c->c2.push_request_interval, 1, now);
>  220         reset_coarse_timers (c);
>  221       }
> 
> Is there any good reason why the latency is added there? I've tried to
> get rid of it and I am able to connect in less than 300ms on a server
> 30ms away from me (on Linux).

That has already been removed in master (Commit:
afb93fac803fbab7406d3b2dff6d1f39365bca74)

Arne


