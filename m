Date: Sun, 18 Sep 2022 18:13:20 +0200 (CEST)
Message-Id: <202209181613.28IGDKVV006183@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220914165041.2658423-1-arne@...1227...>
References: <20220914165041.2658423-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement exit notification via
 control channel
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

Adding my ACK to Heiko's, because the push_option_fmt() thing is sufficiently
different from v3 so I had a very close look.

Testing this is not very easy with the current test framework, as it needs
this patch on both ends to become effective.

This said, I've subjected this to extensive client/server tests against
2.3...master peers, to see if it would break compat with anything 
(no tls-ekm, old tls-ekm, new tls-ekm) - seems not so :-)

Testing client and server both with this patch leads to the expected
protocol-flags message:

 ... peer info: IV_PROTO=222
 ... SENT CONTROL ... protocol-flags cc-exit tls-ekm' (status=1)

and on ctrl-c, to 

client:
 2022-09-18 17:10:59 SIGTERM received, sending exit notification to peer
 2022-09-18 17:10:59 SENT CONTROL [server]: 'EXIT' (status=1)

server:

 Sep 18 17:10:59 ... Exit message received by peer
 Sep 18 17:10:59 ... SIGTERM[soft,remote-exit] received, client-instance exiting

(and of course, --explicit-exit-notify with old<->new client/server
combinations also still works, showing the "old" messages)

Testing this against a DCO enabled p2mp server also makes client-to-server
--explicit-exit-notify work now.  Did not test DCO P2P.


NOTE: the commit message does not mention this, but the manpage says
so, without it being clear to the uninvited - p2mp server to client
will never use this new EXIT message or the old OCC_EXIT signalling,
and has always sent "RESTART..." control-channel messages.  This was not
really clear to me before I started untangling this...

NOTE2: p2p peers still exit() on receipt of --explicit-exit-notify
messages.  Not sure if we consider this reasonable behaviour (see
separate mail thread).


Your patch has been applied to the master branch.

commit 179b3728b71013413885e453e477997f5a396f78
Author: Arne Schwabe
Date:   Wed Sep 14 18:50:41 2022 +0200

     Implement exit notification via control channel

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Heiko Hund <heiko@...2662...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220914165041.2658423-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25209.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


