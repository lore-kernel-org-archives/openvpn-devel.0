Date: Mon, 20 Jul 2020 11:30:55 +0200 (CEST)
Message-Id: <202007200930.06K9Utis092334@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200719173436.16431-4-arne@...1227...>
References: <20200719173436.16431-4-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: client-connect: Add deferred
 support to the client-connect plugin v1 handler
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
To: Fabian Knittel <fabian.knittel@...1547...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Stared-at-code, server torture test, all succeeded.

Grammar change from Richard included (in the "v1 api" comment).

I have modified the commit message a bit to make it more clear that 
this is about CLIENT_CONNECT and CLIENT_CONNECT_V2, not plugin_func_v1()
vs. plugin_func_v2().


Testing this with my new "client connect tester" plugin, I discovered
two things:

 - one, if the plugin wants to use the "file based status signalling"
   API via $ENV{client_connect_deferred_file}, the file MUST be created
   (with content "2") before returning DEFER - otherwise the caller
   will treat the combination of "no CLIENT_CONNECT_DEFER handler and
   no file" as "success" and continue.  

   This can not be changed without deeper knowlege whether a DEFER 
   handler exists or not (possibly worth having a deeper look).


 - second, we read the "option file" ($ENV{client_connect_config_file}) 
   multiple times on every PUSH_REQUEST - it works, but this is a latent
   race condition, reading a "not yet fully written" file.  So we only
   should do this on "final SUCCESS".

   Here's a log with a plugin that sleeps 15 seconds - added some 
   msg() to see what ret/file_ret is at which point

2020-07-20 11:24:19 us=679280 cron2-freebsd-tc-amd64/194.97.140.21:63588 mcccp1 (enter): ret=3, deferred=0
2020-07-20 11:24:19 us=679456 PLUGIN sample-cc: OPENVPN_PLUGIN_CLIENT_CONNECT
2020-07-20 11:24:19 us=681322 PLUGIN sample-cc: in async/deferred handler, sleep(15)
2020-07-20 11:24:19 us=682060 cron2-freebsd-tc-amd64/194.97.140.21:63588 PLUGIN_CALL: POST /root/t_server/tun-udp-p2mp-112-mask/sample-client-connect.so/PLUGIN_CLIENT_CONNECT status=2
2020-07-20 11:24:19 us=682132 cron2-freebsd-tc-amd64/194.97.140.21:63588 mcccp1: ret=2, file_ret=2
2020-07-20 11:24:19 us=682155 cron2-freebsd-tc-amd64/194.97.140.21:63588 mcccp1: ret=2
2020-07-20 11:24:20 us=753014 cron2-freebsd-tc-amd64/194.97.140.21:63588 PUSH: Received control message: 'PUSH_REQUEST'
2020-07-20 11:24:20 us=753070 cron2-freebsd-tc-amd64/194.97.140.21:63588 mcccp1 (enter): ret=3, deferred=1
2020-07-20 11:24:20 us=753105 cron2-freebsd-tc-amd64/194.97.140.21:63588 OPTIONS IMPORT: reading client specific options from: /tmp/openvpn_cc_7a30544bd345b76b6b2ea66939408119.tmp
2020-07-20 11:24:20 us=753180 cron2-freebsd-tc-amd64/194.97.140.21:63588 mcccp1: ret=1, file_ret=2
2020-07-20 11:24:20 us=753203 cron2-freebsd-tc-amd64/194.97.140.21:63588 mcccp1: ret=2
2020-07-20 11:24:20 us=753278 cron2-freebsd-tc-amd64/194.97.140.21:63588 mcccp1 (enter): ret=3, deferred=1
2020-07-20 11:24:20 us=753312 cron2-freebsd-tc-amd64/194.97.140.21:63588 OPTIONS IMPORT: reading client specific options from: /tmp/openvpn_cc_7a30544bd345b76b6b2ea66939408119.tmp
2020-07-20 11:24:20 us=753365 cron2-freebsd-tc-amd64/194.97.140.21:63588 mcccp1: ret=1, file_ret=2
2020-07-20 11:24:20 us=753386 cron2-freebsd-tc-amd64/194.97.140.21:63588 mcccp1: ret=2
2020-07-20 11:24:21 us=879455 cron2-freebsd-tc-amd64/194.97.140.21:63588 mcccp1 (enter): ret=3, deferred=1
2020-07-20 11:24:21 us=879546 cron2-freebsd-tc-amd64/194.97.140.21:63588 OPTIONS IMPORT: reading client specific options from: /tmp/openvpn_cc_7a30544bd345b76b6b2ea66939408119.tmp
2020-07-20 11:24:21 us=879618 cron2-freebsd-tc-amd64/194.97.140.21:63588 mcccp1: ret=1, file_ret=2
2020-07-20 11:24:21 us=879636 cron2-freebsd-tc-amd64/194.97.140.21:63588 mcccp1: ret=2
2020-07-20 11:24:25 us=832648 cron2-freebsd-tc-amd64/194.97.140.21:63588 PUSH: Received control message: 'PUSH_REQUEST'
2020-07-20 11:24:25 us=832705 cron2-freebsd-tc-amd64/194.97.140.21:63588 mcccp1 (enter): ret=3, deferred=1
2020-07-20 11:24:25 us=832742 cron2-freebsd-tc-amd64/194.97.140.21:63588 OPTIONS IMPORT: reading client specific options from: /tmp/openvpn_cc_7a30544bd345b76b6b2ea66939408119.tmp
2020-07-20 11:24:25 us=832835 cron2-freebsd-tc-amd64/194.97.140.21:63588 mcccp1: ret=1, file_ret=2
2020-07-20 11:24:25 us=832853 cron2-freebsd-tc-amd64/194.97.140.21:63588 mcccp1: ret=2
2020-07-20 11:24:25 us=832920 cron2-freebsd-tc-amd64/194.97.140.21:63588 mcccp1 (enter): ret=3, deferred=1
2020-07-20 11:24:25 us=832955 cron2-freebsd-tc-amd64/194.97.140.21:63588 OPTIONS IMPORT: reading client specific options from: /tmp/openvpn_cc_7a30544bd345b76b6b2ea66939408119.tmp
2020-07-20 11:24:25 us=833006 cron2-freebsd-tc-amd64/194.97.140.21:63588 mcccp1: ret=1, file_ret=2
2020-07-20 11:24:25 us=833027 cron2-freebsd-tc-amd64/194.97.140.21:63588 mcccp1: ret=2
2020-07-20 11:24:30 us=865604 cron2-freebsd-tc-amd64/194.97.140.21:63588 PUSH: Received control message: 'PUSH_REQUEST'
2020-07-20 11:24:30 us=865667 cron2-freebsd-tc-amd64/194.97.140.21:63588 mcccp1 (enter): ret=3, deferred=1
2020-07-20 11:24:30 us=865710 cron2-freebsd-tc-amd64/194.97.140.21:63588 OPTIONS IMPORT: reading client specific options from: /tmp/openvpn_cc_7a30544bd345b76b6b2ea66939408119.tmp
2020-07-20 11:24:30 us=865802 cron2-freebsd-tc-amd64/194.97.140.21:63588 mcccp1: ret=1, file_ret=2
2020-07-20 11:24:30 us=865821 cron2-freebsd-tc-amd64/194.97.140.21:63588 mcccp1: ret=2
2020-07-20 11:24:30 us=865894 cron2-freebsd-tc-amd64/194.97.140.21:63588 mcccp1 (enter): ret=3, deferred=1
2020-07-20 11:24:30 us=865923 cron2-freebsd-tc-amd64/194.97.140.21:63588 OPTIONS IMPORT: reading client specific options from: /tmp/openvpn_cc_7a30544bd345b76b6b2ea66939408119.tmp
2020-07-20 11:24:30 us=865974 cron2-freebsd-tc-amd64/194.97.140.21:63588 mcccp1: ret=1, file_ret=2
2020-07-20 11:24:30 us=865990 cron2-freebsd-tc-amd64/194.97.140.21:63588 mcccp1: ret=2
2020-07-20 11:24:34 us=681701 PLUGIN sample-cc: env has UV_WANT_CC_DISABLE, reject
2020-07-20 11:24:34 us=681955 PLUGIN sample-cc: cc_handle_deferred_v1: done, signalling success
2020-07-20 11:24:34 us=682094 mcccp1 (enter): ret=3, deferred=1
2020-07-20 11:24:34 us=682280 OPTIONS IMPORT: reading client specific options from: /tmp/openvpn_cc_7a30544bd345b76b6b2ea66939408119.tmp
2020-07-20 11:24:34 us=682549 mcccp1: ret=1, file_ret=1
2020-07-20 11:24:34 us=682705 mcccp1: ret=1
2020-07-20 11:24:34 us=682972 PLUGIN sample-cc: OPENVPN_PLUGIN_CLIENT_CONNECT_V2
2020-07-20 11:24:34 us=683080 PLUGIN_CALL: POST /root/t_server/tun-udp-p2mp-112-mask/sample-client-connect.so/PLUGIN_CLIENT_CONNECT status=0
2020-07-20 11:24:34 us=690210 OPTIONS IMPORT: reading client specific options from: /tmp/openvpn_cc_2938f1331badc1d130fbe9454149b280.tmp
2020-07-20 11:24:34 us=690325 MULTI: client has been rejected due to 'disable' directive
2020-07-20 11:24:34 us=690364 PLUGIN sample-cc: OPENVPN_PLUGIN_CLIENT_DISCONNECT

(there is more weirdness here, because the "disable" is sent by CLIENT_CONNECT,
but only noticed after CLIENT_CONNECT_V2 is called...)


Your patch has been applied to the master branch.

commit 3d2af1568ccb5b64446fb77218193e6f2ad6e995
Author: Fabian Knittel
Date:   Sun Jul 19 19:34:35 2020 +0200

     client-connect: Add deferred support to the client-connect plugin v1 handler

     Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200719173436.16431-4-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20483.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


