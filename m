Date: Wed, 22 Jul 2020 11:01:05 +0200 (CEST)
Message-Id: <202007220901.06M915hb011698@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200721163811.22745-1-arne@...1227...>
References: <20200721163811.22745-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Indicate that a client is in
 pull mode in IV_PROTO
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

Stared at code, loooks good.

Tested the client side against an unpatched server -> works (which is not 
surprising, but worth a test).

Then patched the server, tested the patched client again -> works \o/

Jul 22 10:09:15 gentoo tun-tcp-p2mp[5572]: 194.97.140.21:50479 peer info: IV_PROTO=6
Jul 22 10:09:15 gentoo tun-tcp-p2mp[5572]: ... SENT CONTROL [cron2-freebsd-tc-amd64]: 'PUSH_REPLY,...'
Jul 22 10:09:17 gentoo tun-tcp-p2mp[5572]: ... PUSH: Received control message: 'PUSH_REQUEST'

(saves 1-2 seconds - coarse timers on the client side...)


The client side state machine is not truly convincing me yet, though - 
while this works as it is, the client does not properly register that 
it already *has* a PUSH_REPLY, so keeps sending PUSH_REQUESTS until the 
server gives in after 30s (NO-SOUP debounce timer) and sends another 
PUSH_REPLY:

2020-07-22 10:14:26 [server] Peer Connection Initiated with [AF_INET6]2001:608:0:814::f000:11:51198
2020-07-22 10:14:26 PUSH: Received control message: 'PUSH_REPLY,route 10.204.0.0 ...'
[tun/route init stuff, crypto init, ...]
2020-07-22 10:14:26 Initialization Sequence Completed
2020-07-22 10:14:27 SENT CONTROL [server]: 'PUSH_REQUEST' (status=1)
2020-07-22 10:14:32 SENT CONTROL [server]: 'PUSH_REQUEST' (status=1)
2020-07-22 10:14:37 SENT CONTROL [server]: 'PUSH_REQUEST' (status=1)
2020-07-22 10:14:42 SENT CONTROL [server]: 'PUSH_REQUEST' (status=1)
2020-07-22 10:14:47 SENT CONTROL [server]: 'PUSH_REQUEST' (status=1)
2020-07-22 10:14:52 SENT CONTROL [server]: 'PUSH_REQUEST' (status=1)
2020-07-22 10:14:57 SENT CONTROL [server]: 'PUSH_REQUEST' (status=1)
2020-07-22 10:14:57 PUSH: Received control message: 'PUSH_REPLY,route 10.204.0.0 ...




I decided to keep the patch and improve on the client side 
later :-) - and *then* ran the full test with 2.2/2.3/2.4/master(patched) 
against the same server, and AGES later... 

22...
Test sets succeeded: 1 2 3 4 6 8.
Test sets failed: none.
..
master...
Test sets succeeded: 1 1a 1b 1c 1d 1e 2 2a 2b 2c 2d 2e 2f 3 4 5 5a 5b 5c 5v1 5v2 5v3 5w1 5w2 5w3 5w4 5x1 5x2 5x3 5x4 6 7 7x 8 8a 9 4b.
Test sets failed: none.


My RTTs are too low to make a difference wrt packets RTTs, but the
"coarse timer on client" delay alone makes this an improvement.

Your patch has been applied to the master branch.

commit c290df558f8df995f1eeb3ddbf408508a455273e
Author: Arne Schwabe
Date:   Tue Jul 21 18:38:11 2020 +0200

     Indicate that a client is in pull mode in IV_PROTO

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200721163811.22745-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20525.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


