Date: Mon, 12 Dec 2022 14:07:30 +0100 (CET)
Message-Id: <202212121307.2BCD7Ukp085864@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221208153129.1207228-1-arne@...1227...>
References: <20221208153129.1207228-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Ignore connection attempts
 while server is shutting down
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Stare-at-code looks good, and testing confirms that it does fix over-eager
clients reconnecting too fast:

^C2022-12-12 14:03:11 us=841186 event_wait : Interrupted system call (fd=-1,code=4)
2022-12-12 14:03:11 us=841294 SENT CONTROL [cron2-freebsd-tc-amd64]: 'RESTART' (status=1)
2022-12-12 14:03:11 us=841346 SENT CONTROL [freebsd-74-amd64]: 'RESTART' (status=1)
2022-12-12 14:03:11 us=841391 SENT CONTROL [freebsd-11-amd64]: 'RESTART' (status=1)
2022-12-12 14:03:12 us=893434 MULTI: Connection attempt from 194.97.140.21:13788 ignored while server is shutting down

and on the client:

2022-12-12 14:03:11 SIGUSR1[soft,server-pushed-connection-reset] received, process restarting
2022-12-12 14:03:11 Restart pause, 1 second(s)
2022-12-12 14:03:12 TCP/UDP: Preserving recently used remote address: [AF_INET]194.97.140.11:51196
[..]
2022-12-12 14:04:12 TLS Error: TLS key negotiation failed to occur within 60 seconds (check your network connectivity)
2022-12-12 14:04:12 TLS Error: TLS handshake failed

so, no more "it reconnects right away and then the server disappears"
(which I could reproduce without the patch - the client would then
show "Initialization Sequence Completed" and wait for --ping-timeout).


For 2.7, we might actually consider reworking the server-exit behaviour
to "exit as soon as all outstanding control messages have been ACKed"
or even "fire-and-forget on the CC EENs"?  But this is a bigger thing
than "fix goes into 2.6_beta2", I'm afraid.

Your patch has been applied to the master and release/2.6 branch.

commit 7d0a90335fe79a352456f262ce42ea501796ae87 (master)
commit f8bfe1a5fb785d2f26f3a38d597604031f081018 (release/2.6)
Author: Arne Schwabe
Date:   Thu Dec 8 16:31:29 2022 +0100

     Ignore connection attempts while server is shutting down

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221208153129.1207228-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25638.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


