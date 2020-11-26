Date: Thu, 26 Nov 2020 15:49:53 +0100 (CET)
Message-Id: <202011261449.0AQEnrgA075360@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20201023120259.29783-6-arne@...1227...>
References: <20201023120259.29783-6-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Send AUTH_FAILED message to
 clients on renegotiation failures
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

I actually have a test case for this...

 - auth-gen-token 600
 - reneg-sec 30
 - sync plugin-auth-pam

then it will happily renegotiate every 30 seconds, and after 
10 minutes it will "fail without noticing" - the server logs

2020-11-26 15:10:30 us=755319 cron2-freebsd-tc-amd64/2001:608:0:814::f000:21 --auth-token-gen: auth-token from client expired
2020-11-26 15:10:30 us=755355 cron2-freebsd-tc-amd64/2001:608:0:814::f000:21 TLS: Username/auth-token authentication failed for username 'fbsd-tc-master'

(but never tells the client).

Eventually the keys time out:

2020-11-26 15:10:50 us=604558 cron2-freebsd-tc-amd64/2001:608:0:814::f000:21 TLS Error: local/remote TLS keys are out of sync: [AF_INET6]2001:608:0:814::f000:21:42838 (received key id: 7, known key ids:  [key#0 state=S_ACTIVE auth=KS_AUTH_FALSE id=7 sid=4ead8bbc 11847581] [key#1 state=S_ACTIVE auth=KS_AUTH_TRUE id=6 sid=4ead8bbc 11847581] [key#2 state=S_UNDEF auth=KS_AUTH_FALSE id=0 sid=00000000 00000000])

.. so pings start failing from here.

2020-11-26 15:11:00 us=968564 cron2-freebsd-tc-amd64/2001:608:0:814::f000:21 SIGTERM[soft,auth-control-exit] received, client-instance exiting

.. and on the next reneg-interval, the MI is closed.

The client runs into *ping* timeout eventually...  (but is never told by the server 
that the server instance went away):

2020-11-26 15:11:00 TLS: soft reset sec=30/30 bytes=7869/-1 pkts=61/0
2020-11-26 15:11:24 [server] Inactivity timeout (--ping-restart), restarting

retries after 5s:

2020-11-26 15:11:31 us=7470 2001:608:0:814::f000:21 SENT CONTROL [cron2-freebsd-tc-amd64]: 'AUTH_FAILED,SESSION: token expired' (status=1)

here the client *is* told, and re-tries 5 seconds later, with the 
"non-token" auth:

2020-11-26 15:11:36 us=98591 2001:608:0:814::f000:21 TLS: Username/Password authentication succeeded for username 'fbsd-tc-master' 

(failure of 51 seconds in here)


*With* the patch, there still is silliness involved

2020-11-26 15:42:30 us=587138 cron2-freebsd-tc-amd64/2001:608:0:814::f000:21 --auth-token-gen: auth-token from client expired
2020-11-26 15:42:30 us=587168 cron2-freebsd-tc-amd64/2001:608:0:814::f000:21 TLS: Username/auth-token authentication failed for username 'fbsd-tc-master'
2020-11-26 15:42:30 us=591020 cron2-freebsd-tc-amd64/2001:608:0:814::f000:21 Control Channel: TLSv1.3, cipher TLSv1.3 TLS_AES_256_GCM_SHA384, 2048 bit RSA
2020-11-26 15:42:45 us=175486 cron2-freebsd-tc-amd64/2001:608:0:814::f000:21 TLS Error: local/remote TLS keys are out of sync: [AF_INET6]2001:608:0:814::f000:21:29307 (received key id: 7, known key ids:  [key#0 state=S_ACTIVE auth=KS_AUTH_FALSE id=7 sid=028b5663 63c9dc4d] [key#1 state=S_ACTIVE auth=KS_AUTH_TRUE id=6 sid=028b5663 63c9dc4d] [key#2 state=S_UNDEF auth=KS_AUTH_FALSE id=0 sid=00000000 00000000])

.. and pings fail from 15:42:45 onwards, without telling the client.

The improvement bit happens then:

2020-11-26 15:43:00 TLS: soft reset sec=30/30 bytes=7869/-1 pkts=61/0
2020-11-26 15:43:00 AUTH: Received control message: AUTH_FAILED,SESSION: token expired
2020-11-26 15:43:00 Restart pause, 5 second(s)
2020-11-26 15:43:05 [server] Peer Connection Initiated with [AF_INET6]2001:608:0:814::f000:11:51199

So on the next renegotiation the client will receive a proper
error, and can reconnect right away.

Ping failure time is down from 51s to 23s, so "improvement" :-)


Your patch has been applied to the master branch.

commit 55d5eaa3e021a21b9537a474c46636d4c2dcdac5
Author: Arne Schwabe
Date:   Fri Oct 23 14:02:58 2020 +0200

     Send AUTH_FAILED message to clients on renegotiation failures

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20201023120259.29783-6-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21222.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


