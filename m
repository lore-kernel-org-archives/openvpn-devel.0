Date: Fri, 7 Oct 2022 18:10:01 +0200 (CEST)
Message-Id: <202210071610.297GA1o7073988@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221006203731.13529-1-a@...2181...>
References: <20221006203731.13529-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: implement --session-timeout
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Dmitry Zelenkovsky <dmitry@...2697...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

This is a useful addition for situations with external constraints
("this VPN access may only be used between 10:00 and 18:00", so you
can ensure the session ends at 17:59:59 without having extra managmeent
logic around).  Whether it's overly useful in "global server context"
or on the client side stands to be debated - but this needs no extra
code, so "it's just there and someone might find use for it".

I have tested client-side (works), server-side/global (will terminate
each instance <n> seconds after connecting, but not itself) and
server-side/ccd (per-instance kill switch with per-instance timer).

Unfortunately, the man page addition about explicit-exit-notify is
wrong - on the server side, it never sends notifies, it just kills
the client TLS instance...

2022-10-07 18:05:13 us=256095 cron2-freebsd-tc-amd64/194.97.140.21:29079 Session timeout, exiting
2022-10-07 18:05:13 us=256170 cron2-freebsd-tc-amd64/194.97.140.21:29079 SIGTERM[soft,session-timeout] received, client-instance exiting

.. without telling the client, so that one needs to run into --ping timeout

2022-10-07 18:05:42 [server] Inactivity timeout (--ping-restart), restarting

.. 30 seconds later, which is not really satisfying...

Can we do better?

I have, for the time being, removed the offending man page section about
--explicit-exit-notify and merged the rest (no code change).


Your patch has been applied to the master branch.

commit f96290ff901f62717fdb4c1adef72142f359e992
Author: Dmitry Zelenkovsky
Date:   Thu Oct 6 22:37:31 2022 +0200

     implement --session-timeout

     Signed-off-by: Dmitry Zelenkovsky <dmitry@...2697...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221006203731.13529-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25352.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


