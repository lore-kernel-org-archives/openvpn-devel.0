From: Denis Vlasenko <vda@...216...>
Subject: Re: [Openvpn-devel] [BUG] sometimes --ping 30 stops: select() timeout=31536000 seconds (exactly one year)!
References: <twig.1085778940.16289@...41...>
In-Reply-To: <twig.1085778940.16289@...41...>
MIME-Version: 1.0
Message-Id: <200405290104.44011.vda@...216...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri May 28 15:06:02 2004
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: James Yonan <jim@...41...>, OpenVPN devel <openvpn-devel@lists.sourceforge.net>

On Saturday 29 May 2004 00:15, James Yonan wrote:
> Denis,
>
> That looks like a possible bug in the coarse timer update logic.  The
> coarse timer deals with events scheduled at a resolution denoted by an
> integer number of seconds, such as pings.  A timeout of one year is used as
> kind of "effectively infinite" time interval.  If you see this large
> timeout, it means that the ping event is losing its place in the coarse
> timer event queue -- probably a bug.

Yes. It clearly happened here:

static void
check_coarse_timers_dowork (struct context *c)
{
  const struct timeval save = c->c2.timeval;
  c->c2.timeval.tv_sec = BIG_TIMEOUT;
  c->c2.timeval.tv_usec = 0;
  process_coarse_timers (c);
  c->c2.coarse_timer_wakeup = now + c->c2.timeval.tv_sec;

  msg (D_INTERVAL, "TIMER: coarse timer wakeup %d seconds", (int) c->c2.timeval.tv_sec);

  /* Is the coarse timeout NOT the earliest one? */
  if (c->c2.timeval.tv_sec > save.tv_sec)
    c->c2.timeval = save;
}

I can see that TIMER: ... message with 1 year worth of seconds printed.
Obviosly, process_coarse_timers (c) did not do it's job.
I instrumented it this way now:


process_coarse_timers (struct context *c)
{
#ifdef USE_CRYPTO
  /* flush current packet-id to file once per 60
     seconds if --replay-persist was specified */
  check_packet_id_persist_flush (c);
  msg(D_PING, "PING: process_coarse_timers 1 tv=t=%ld", (long)c->c2.timeval.tv_sec);
#endif

  /* process connection establishment items */
  check_connection_established (c);
  msg(D_PING, "PING: process_coarse_timers 2 tv=t=%ld", (long)c->c2.timeval.tv_sec);

#if P2MP
  /* see if we should send a push_request in response to --pull */
  check_push_request (c);
  msg(D_PING, "PING: process_coarse_timers 3 tv=t=%ld", (long)c->c2.timeval.tv_sec);
#endif

  /* process --route options */
  check_add_routes (c);
  msg(D_PING, "PING: process_coarse_timers 4 tv=t=%ld", (long)c->c2.timeval.tv_sec);

  /* possibly exit due to --inactive */
  check_inactivity_timeout (c);
  msg(D_PING, "PING: process_coarse_timers 5 tv=t=%ld", (long)c->c2.timeval.tv_sec);
  if (c->sig->signal_received)
    return;

  /* restart if ping not received */
  check_ping_restart (c);
  msg(D_PING, "PING: process_coarse_timers 6 tv=t=%ld", (long)c->c2.timeval.tv_sec);
  if (c->sig->signal_received)
    return;

  /* Should we send an OCC_REQUEST message? */
  check_send_occ_req (c);
  msg(D_PING, "PING: process_coarse_timers 7 tv=t=%ld", (long)c->c2.timeval.tv_sec);

  /* Should we send an MTU load test? */
  check_send_occ_load_test (c);
  msg(D_PING, "PING: process_coarse_timers 8 tv=t=%ld", (long)c->c2.timeval.tv_sec);

  /* Should we ping the remote? */
  check_ping_send (c);
  msg(D_PING, "PING: process_coarse_timers 9 tv=t=%ld", (long)c->c2.timeval.tv_sec);
}


Output:


Sat May 29 00:54:51 2004 RANDOM USEC=412366
Sat May 29 00:55:01 2004 PING: process_coarse_timers 1 tv=t=31536000
Sat May 29 00:55:01 2004 PING: process_coarse_timers 2 tv=t=31536000
Sat May 29 00:55:01 2004 PING: process_coarse_timers 3 tv=t=31536000
Sat May 29 00:55:01 2004 PING: process_coarse_timers 4 tv=t=31536000
Sat May 29 00:55:01 2004 PING: process_coarse_timers 5 tv=t=31536000
Sat May 29 00:55:01 2004 PING: process_coarse_timers 6 tv=t=31536000
Sat May 29 00:55:01 2004 PING: process_coarse_timers 7 tv=t=31536000
Sat May 29 00:55:01 2004 PING: process_coarse_timers 8 tv=t=31536000
Sat May 29 00:55:01 2004 EVENT event_timeout_wakeup (20/30)
Sat May 29 00:55:01 2004 PING: !event_timeout_trigger(1085781291,20)
Sat May 29 00:55:01 2004 PING: process_coarse_timers 9 tv=t=20

	okay, check_ping_send (c) have done it's job.

Sat May 29 00:55:01 2004 TIMER: coarse timer wakeup 20 seconds
Sat May 29 00:55:01 2004 RANDOM USEC=113731
Sat May 29 00:55:18 2004 RANDOM USEC=994739
Sat May 29 00:55:22 2004 PING: process_coarse_timers 1 tv=t=31536000
Sat May 29 00:55:22 2004 PING: process_coarse_timers 2 tv=t=31536000
Sat May 29 00:55:22 2004 PING: process_coarse_timers 3 tv=t=31536000
Sat May 29 00:55:22 2004 PING: process_coarse_timers 4 tv=t=31536000
Sat May 29 00:55:22 2004 PING: process_coarse_timers 5 tv=t=31536000
Sat May 29 00:55:22 2004 PING: process_coarse_timers 6 tv=t=31536000
Sat May 29 00:55:22 2004 PING: process_coarse_timers 7 tv=t=31536000
Sat May 29 00:55:22 2004 PING: process_coarse_timers 8 tv=t=31536000
Sat May 29 00:55:22 2004 PING: c->c2.to_link.len <> 0
Sat May 29 00:55:22 2004 PING: process_coarse_timers 9 tv=t=31536000
Sat May 29 00:55:22 2004 TIMER: coarse timer wakeup 31536000 seconds

	BOOM!

Sat May 29 00:55:22 2004 PING: select timeout=31536000
Sat May 29 00:55:22 2004 PING: select timeout=31536000
Sat May 29 00:55:22 2004 PING: select timeout=31536000
Sat May 29 00:55:22 2004 PING: select timeout=31536000
Sat May 29 00:55:22 2004 PING: select timeout=31536000

For your reference:

static inline void
check_ping_send (struct context *c)
{
  void check_ping_send_dowork (struct context *c);
  if (!c->options.ping_send_timeout) { msg (D_PING, "PING: !c->options.ping_send_timeout"); return; }
  if (c->c2.to_link.len) { msg (D_PING, "PING: c->c2.to_link.len <> 0"); return; }
  if (!event_timeout_trigger (&c->c2.ping_send_interval, &c->c2.timeval))
    { msg (D_PING, "PING: !event_timeout_trigger(%ld,%ld)",(long)(c->c2.ping_send_interval.last), (long)c->c2.timeval.tv_sec); return; }
    check_ping_send_dowork (c);
}

"if (c->c2.to_link.len)" case does not set timeout as it ought to do.

Is my analysis right?
--
vda


