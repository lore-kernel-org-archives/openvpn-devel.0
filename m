Date: Fri, 17 Jul 2020 18:49:54 +0200 (CEST)
Message-Id: <202007171649.06HGnsxa014536@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200716134315.17742-1-arne@...1227...>
References: <20200716134315.17742-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: client-connect: Add
 CC_RET_DEFERRED and cope with deferred client-connect
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

Your patch has been applied to the master branch.

Tested on the test rig, stared-at-code by antonio, and commit-message-adjusted
by me :-) (a few "defferred" and integrating the new call convention).

Pushed, then went out to write a plugin to excercise this a bit more... and
lo and behold, breakage!

If I run a server that has *both* a plugin with the connect handler configured 
(which succeeds) and a client-connect script (which fails), it will sort of "stare 
into nothingness".

With only the client-connect script configured, I get:

2020-07-17 18:35:10 us=536817 ... WARNING: Failed running command (--client-connect): external program exited with error status: 10
2020-07-17 18:35:11 us=751714 ... PUSH: Received control message: 'PUSH_REQUEST'
2020-07-17 18:35:11 us=751860 ... SENT CONTROL [cron2-freebsd-tc-amd64]: 'AUTH_FAILED' (status=1)

"all good"

with both configured, I get:

2020-07-17 18:32:34 us=478215 PLUGIN_CALL: POST /root/t_server/tun-udp-p2mp-112-mask/sample-client-connect.so/PLUGIN_CLIENT_CONNECT status=0
2020-07-17 18:32:34 us=478331 OPTIONS IMPORT: reading client specific options from: /tmp/openvpn_cc_36b55f67d059a540483662f8e736189.tmp
2020-07-17 18:32:34 us=478562 PLUGIN sample-cc: OPENVPN_PLUGIN_CLIENT_CONNECT_V2
2020-07-17 18:32:34 us=478670 PLUGIN_CALL: POST /root/t_server/tun-udp-p2mp-112-mask/sample-client-connect.so/PLUGIN_CLIENT_CONNECT status=0
2020-07-17 18:32:34 us=490057 WARNING: Failed running command (--client-connect): external program exited with error status: 10
2020-07-17 18:32:35 us=618131 ... PUSH: Received control message: 'PUSH_REQUEST'
2020-07-17 18:32:40 us=801869 ... PUSH: Received control message: 'PUSH_REQUEST'
2020-07-17 18:32:45 us=948480 ... PUSH: Received control message: 'PUSH_REQUEST'
2020-07-17 18:32:50 us=990555 ... PUSH: Received control message: 'PUSH_REQUEST'
2020-07-17 18:32:56 us=51592 ... PUSH: Received control message: 'PUSH_REQUEST'
2020-07-17 18:33:01 us=311645 ... PUSH: Received control message: 'PUSH_REQUEST'
2020-07-17 18:33:06 us=612242 ... PUSH: Received control message: 'PUSH_REQUEST'
2020-07-17 18:33:11 us=811682 ... PUSH: Received control message: 'PUSH_REQUEST'
2020-07-17 18:33:17 us=11695 ... PUSH: Received control message: 'PUSH_REQUEST'
2020-07-17 18:33:22 us=151679 ... PUSH: Received control message: 'PUSH_REQUEST'
2020-07-17 18:33:27 us=311636 ... PUSH: Received control message: 'PUSH_REQUEST'
2020-07-17 18:33:32 us=351693 ... PUSH: Received control message: 'PUSH_REQUEST'
2020-07-17 18:33:47 us=513879 MULTI: multi_create_instance called
2020-07-17 18:33:47 us=514020 194.97.140.21:51169 Re-using SSL/TLS context

(client retrying after timeout)


Now, if I make the *plugin* fail, it works as requested...

2020-07-17 18:47:21 us=372780 PLUGIN sample-cc: env has UV_WANT_CC_FAIL=10 -> fail
2020-07-17 18:47:21 us=372800 PLUGIN_CALL: POST /root/t_server/tun-udp-p2mp-112-mask/sample-client-connect.so/PLUGIN_CLIENT_CONNECT status=1
2020-07-17 18:47:21 us=372812 PLUGIN_CALL: plugin function PLUGIN_CLIENT_CONNECT failed with status 1: /root/t_server/tun-udp-p2mp-112-mask/sample-client-connect.so
2020-07-17 18:47:21 us=372824 WARNING: client-connect plugin call failed
2020-07-17 18:47:22 us=479574 ... PUSH: Received control message: 'PUSH_REQUEST'
2020-07-17 18:47:22 us=479634 ... Delayed exit in 5 seconds
2020-07-17 18:47:22 us=479661 ... SENT CONTROL [cron2-freebsd-tc-amd64]: 'AUTH_FAILED' (status=1)

- so it seems something in the chain of things is not good if "more than one" 
is there.


commit dfb40edc4acae5f17b0062ecb13ad1fa760ed529
Author: Arne Schwabe
Date:   Thu Jul 16 15:43:10 2020 +0200

     client-connect: Add CC_RET_DEFERRED and cope with deferred client-connect

     Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <antonio@...515...>
     Message-Id: <20200716134315.17742-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20395.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


