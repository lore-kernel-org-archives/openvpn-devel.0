Date: Sun, 19 Jul 2020 22:05:54 +0200 (CEST)
Message-Id: <202007192005.06JK5s9N070266@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200719173436.16431-2-arne@...1227...>
References: <20200719173436.16431-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: client-connect: Add deferred
 support to the client-connect script handler
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

Tested on the server rig, with a client-connect script which can do deferred
("echo 2 >$client_connect_deferred_file") if requested, and will then succeed,
fail, or "disable".  For "succeed" and "disable", this is all clear from the
server logs, but for "fail", you see the instance do nothing while the background
process is busy, and then it will start running DISCONNECT handlers...:

Jul 19 21:55:29 gentoo ... PUSH: Received control message: 'PUSH_REQUEST'
Jul 19 21:55:44 gentoo last message buffered 3 times
Jul 19 21:55:44 gentoo ... OPTIONS IMPORT: reading client specific options from: /tmp/openvpn_cc_268321913a8c50ce50deccf46ef6817a.tmp
Jul 19 21:55:44 gentoo ... sample-cc: OPENVPN_PLUGIN_CLIENT_DISCONNECT
Jul 19 21:55:44 gentoo ... PLUGIN_CALL: POST /root/t_server/tun-udp-p2mp-112-mask/sample-client-connect.so/PLUGIN_CLIENT_DISCONNECT status=0

the fact that it's reading the "client specific options" even in case of 
failure is clear form the source (but I decided that it won't do harm, so 
"leave it in") but the fact that it's not logging the failure is not good - so 
I think we need to differenciate CC_RET_SUCCEEDED vs. CC_RET_FAILED in the 
"if (ret != CC_RET_DEFERRED)" clause in in multi_client_connect_script_deferred().

Since this is logging, and basic functionality works, I think this can go in 
a followup patch.


Quite a few typos and grammar corrections from Richard integrated 
(originally to v5 09/14).

Antonio had a few "parenthesis not needed" comments on that one, but after
discussion on IRC the result was "might be, but it's more explicit this way
which address is taken".

Your patch has been applied to the master branch.

commit 529b1ab288de569bff946e7b6f8f6f8817f15163
Author: Fabian Knittel
Date:   Sun Jul 19 19:34:33 2020 +0200

     client-connect: Add deferred support to the client-connect script handler

     Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200719173436.16431-2-arne@...1227...>
     URL: https://www.mail-archive.com/search?l=mid&q=20200719173436.16431-2-arne@...1227...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


