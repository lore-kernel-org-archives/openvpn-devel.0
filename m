From: Jiri Horky <jiri.horky@...277...>
Message-ID: <57239121.8000704@...277...>
Date: Fri, 29 Apr 2016 18:51:45 +0200
MIME-Version: 1.0
Subject: [Openvpn-devel] Artificial delays during connection setup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?B?SmnFmcOtIEphaG4=?= <jahn@...2025...>, =?UTF-8?B?xI0=?= <zubac@...2025...>, =?UTF-8?B?VsOtdCBIZcWZbWFu?= <herman@...2025...>, =?UTF-8?Q?Michal_Zub=c3=a1?=

Hi list,

I was wondering why the connection setup on Linux with openvpn 2.3.10
takes about 2.5s even on local network and dig deeper in the code. It
seems there are two places where an artificial delay of 1s is added.

First one is waiting before checking the connection status is checked in
src/openvpn/init.c

1108   if (!deferred)
1109   {
1110     /* initialize connection establishment timer */
1111     event_timeout_init (&c->c2.wait_for_connect, 1, now);
1112


And the second one is waiting before sending push_request in
src/openvpn/forward.c:

 218         /* send push request in 1 sec */
 219         event_timeout_init (&c->c2.push_request_interval, 1, now);
 220         reset_coarse_timers (c);
 221       }

Is there any good reason why the latency is added there? I've tried to
get rid of it and I am able to connect in less than 300ms on a server
30ms away from me (on Linux).

Regards
Jiri Horky

