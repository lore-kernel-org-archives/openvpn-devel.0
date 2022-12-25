Date: Sun, 25 Dec 2022 21:03:07 +0100 (CET)
Message-Id: <202212252003.2BPK37i1086737@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221224194253.3202231-9-arne@...1227...>
References: <20221224194253.3202231-9-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Improve logging when seeing a
 message for an unkown peer
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

This looks like a good change - only log the "this is not really relevant"
messages if we're interested (verb 6), and also add more details.

Run on Linux-DCO client/server testbed, and I see quite a number of them...

Dec 25 19:22:01 ubuntu2004 tun-udp-p2mp-topology-subnet[1965839]: Received packet for peer-id unknown to OpenVPN: -1, type 0, reason 2
Dec 25 19:22:01 ubuntu2004 tun-udp-p2mp[1965830]: Received packet for peer-id unknown to OpenVPN: -1, type 0, reason 0
Dec 25 19:22:01 ubuntu2004 tun-tcp-p2mp[1965819]: Received packet for peer-id unknown to OpenVPN: -1, type 0, reason 1
Dec 25 19:22:01 ubuntu2004 tun-udp-p2mp-topology-subnet[1965839]: Received packet for peer-id unknown to OpenVPN: -1, type 0, reason 2
Dec 25 19:22:01 ubuntu2004 tun-udp-p2mp[1965830]: Received packet for peer-id unknown to OpenVPN: -1, type 0, reason 0
Dec 25 19:22:01 ubuntu2004 tun-tcp-p2mp[1965819]: Received packet for peer-id unknown to OpenVPN: -1, type 0, reason 1

.. though I can't claim to understand what is happening here...

Why is the kernel sending packets for "peer-id -1"?  Why are these being
sent to all OpenVPN instances at the same moment?  Even if we're ignoring
these messages, they leave me with an uneasy feeling...  (type = 0 is
"CMD_UNSPEC", reason 0/1/2 would be TEARDOWN, USERSPACE, EXPIRED - 
shouldn't these be DEL_PEER messages, so type=3?)

Your patch has been applied to the master and release/2.6 branch.

commit 8516b4b3665aa94d3114194f33fbb9c34119ab71 (master)
commit 5d47df8d69c73629eccc1e443b3dfedbb9e8fd2d (release/2.6)
Author: Arne Schwabe
Date:   Sat Dec 24 20:42:52 2022 +0100

     Improve logging when seeing a message for an unkown peer

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221224194253.3202231-9-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25793.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


