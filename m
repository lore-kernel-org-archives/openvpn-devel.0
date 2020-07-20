Date: Mon, 20 Jul 2020 12:52:03 +0200 (CEST)
Message-Id: <202007201052.06KAq3Fh093607@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200719173436.16431-5-arne@...1227...>
References: <20200719173436.16431-5-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: client-connect: Implement
 deferred connect support for plugin API v2
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

Stared-at-code, and whacked it from all sides - sync and 
async/deferred CLIENT_CONNECT and CLIENT_CONNECT_V2, with
"success", "failure" and "disabled" rejection:

Test sets succeeded: 5 5a 5b 5c 5v1 5v2 5v3 5w1 5w2 5w3 5w4 5x1 5x2 5x3 5x4.
Test sets failed: none.

(Full "full test" is still running, but I do not expect breakage
in other code paths)

I even tested this case:

2020-07-20 12:12:20 us=422277 cron2-freebsd-tc-amd64/194.97.140.21:50614 A plugin that defers from the OPENVPN_PLUGIN_CLIENT_CONNECT_V2 call must also declare support for OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER_V2

which I truly like ("this is an error in the plugin, point it 
out clearly and refuse cooperation")


The polling of the plugin status is a bit weird, as in "events are firing
much more often than I would have expected" - this is for a plugin with
25s delay (and the plugin handler logging the remaining time):

2020-07-20 12:30:26 PLUGIN sample-cc: OPENVPN_PLUGIN_CLIENT_CONNECT_V2
2020-07-20 12:30:26 PLUGIN sample-cc: env has UV_WANT_CC2_ASYNC=25 -> set up deferred handler
2020-07-20 12:30:26 PLUGIN_CALL: POST /root/t_server/tun-udp-p2mp-112-mask/sample-client-connect.so/PLUGIN_CLIENT_CONNECT status=2
2020-07-20 12:30:27 cron2-freebsd-tc-amd64/194.97.140.21:35288 PUSH: Received control message: 'PUSH_REQUEST'
2020-07-20 12:30:27 PLUGIN sample-cc: defer_v2: seconds left=24
2020-07-20 12:30:27 cron2-freebsd-tc-amd64/194.97.140.21:35288 PLUGIN_CALL: POST ...V2 status=2
2020-07-20 12:30:27 PLUGIN sample-cc: defer_v2: seconds left=24
2020-07-20 12:30:27 cron2-freebsd-tc-amd64/194.97.140.21:35288 PLUGIN_CALL: POST ...V2 status=2
2020-07-20 12:30:28 PLUGIN sample-cc: defer_v2: seconds left=23
2020-07-20 12:30:28 cron2-freebsd-tc-amd64/194.97.140.21:35288 PLUGIN_CALL: POST ...V2 status=2
2020-07-20 12:30:32 cron2-freebsd-tc-amd64/194.97.140.21:35288 PUSH: Received control message: 'PUSH_REQUEST'
2020-07-20 12:30:32 PLUGIN sample-cc: defer_v2: seconds left=19
2020-07-20 12:30:32 cron2-freebsd-tc-amd64/194.97.140.21:35288 PLUGIN_CALL: POST ...V2 status=2
2020-07-20 12:30:32 PLUGIN sample-cc: defer_v2: seconds left=19
2020-07-20 12:30:32 cron2-freebsd-tc-amd64/194.97.140.21:35288 PLUGIN_CALL: POST ...V2 status=2
2020-07-20 12:30:37 cron2-freebsd-tc-amd64/194.97.140.21:35288 PUSH: Received control message: 'PUSH_REQUEST'
2020-07-20 12:30:37 PLUGIN sample-cc: defer_v2: seconds left=14
2020-07-20 12:30:37 cron2-freebsd-tc-amd64/194.97.140.21:35288 PLUGIN_CALL: POST ...V2 status=2
2020-07-20 12:30:37 PLUGIN sample-cc: defer_v2: seconds left=14
2020-07-20 12:30:37 cron2-freebsd-tc-amd64/194.97.140.21:35288 PLUGIN_CALL: POST ...V2 status=2
2020-07-20 12:30:42 PLUGIN sample-cc: defer_v2: seconds left=9
2020-07-20 12:30:42 cron2-freebsd-tc-amd64/194.97.140.21:35288 PLUGIN_CALL: POST ...V2 status=2
2020-07-20 12:30:42 cron2-freebsd-tc-amd64/194.97.140.21:35288 PUSH: Received control message: 'PUSH_REQUEST'
2020-07-20 12:30:42 PLUGIN sample-cc: defer_v2: seconds left=9
2020-07-20 12:30:42 cron2-freebsd-tc-amd64/194.97.140.21:35288 PLUGIN_CALL: POST ...V2 status=2
2020-07-20 12:30:42 PLUGIN sample-cc: defer_v2: seconds left=9
2020-07-20 12:30:42 cron2-freebsd-tc-amd64/194.97.140.21:35288 PLUGIN_CALL: POST ...V2 status=2
2020-07-20 12:30:47 PLUGIN sample-cc: defer_v2: seconds left=4
2020-07-20 12:30:47 cron2-freebsd-tc-amd64/194.97.140.21:35288 PLUGIN_CALL: POST ...V2 status=2
2020-07-20 12:30:47 cron2-freebsd-tc-amd64/194.97.140.21:35288 PUSH: Received control message: 'PUSH_REQUEST'
2020-07-20 12:30:47 PLUGIN sample-cc: defer_v2: seconds left=4
2020-07-20 12:30:47 cron2-freebsd-tc-amd64/194.97.140.21:35288 PLUGIN_CALL: POST ...V2 status=2
2020-07-20 12:30:47 PLUGIN sample-cc: defer_v2: seconds left=4
2020-07-20 12:30:47 cron2-freebsd-tc-amd64/194.97.140.21:35288 PLUGIN_CALL: POST ...V2 status=2
2020-07-20 12:30:52 PLUGIN sample-cc: defer_v2: seconds left=-1
2020-07-20 12:30:52 PLUGIN sample-cc: env has UV_WANT_CC2_FAIL -> fail
2020-07-20 12:30:52 cron2-freebsd-tc-amd64/194.97.140.21:35288 PLUGIN_CALL: POST /root/t_server/tun-udp-p2mp-112-mask/sample-client-connect.so/PLUGIN_CLIENT_CONNECT_DEFER_V2 status=1
2020-07-20 12:30:52 cron2-freebsd-tc-amd64/194.97.140.21:35288 PLUGIN_CALL: plugin function PLUGIN_CLIENT_CONNECT_DEFER_V2 failed with status 1: /root/t_server/tun-udp-p2mp-112-mask/sample-client-connect.so
2020-07-20 12:30:52 cron2-freebsd-tc-amd64/194.97.140.21:35288 WARNING: client-connect-v2 plugin call failed
2020-07-20 12:30:52 PLUGIN sample-cc: OPENVPN_PLUGIN_CLIENT_DISCONNECT

Is this intentional?  Or more some sort of "huh? why?" effect?

(This is with just a single client connecting, so no events from 
other instances)


Your patch has been applied to the master branch.

commit aad16b6c48735c5449d9b3bd0689bfc0a0a9fff6
Author: Arne Schwabe
Date:   Sun Jul 19 19:34:36 2020 +0200

     client-connect: Implement deferred connect support for plugin API v2

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200719173436.16431-5-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20480.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


