Date: Thu, 1 Dec 2022 16:18:00 +0100 (CET)
Message-Id: <202212011518.2B1FI0hH030904@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221201110128.271064-1-arne@...1227...>
References: <20221201110128.271064-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Allow reconnecting in p2p mode
 work under FreeBSD
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

Indeed, that fixes the p2p dco reconnect problem we had with FreeBSD,
and with "verb 6" debugging one can nicely see what happens:

14:28:55 P2P mode NCP negotiation result: TLS_export=1, DATA_v2=1, peer-id 10167064, cipher=AES-256-GCM

reconnect, then

14:29:17 P2P mode NCP negotiation result: TLS_export=1, DATA_v2=1, peer-id 3502029, cipher=AES-256-GCM
14:29:17 dco_del_key: peer-id 10167064, slot 0
14:29:18 dco_del_peer: peer-id 10167064
14:29:18 dco_new_peer: peer-id 3502029, fd 7
14:29:18 process_incoming_dco: received message for mismatching peer-id 10167064, expected 3502029

(and we ignore this, not killing the new 3502029 peer)


My own pokings in kernel space confirmed what I assumed - we just add
peers, and they do not expire quickly.  So after the first reconnect,
without this patch, we have 2 peers in kernel with no vpn_ip address, 
so "lookup on nexthop" is not working, and that particular ovpn(4)
interface is dead until ifdown/ifup or all the peers expire.  I did
experiment with a kernel patch that will remove all existing peers on
install of a new p2p peer - and that worked, kernel side, but confused
OpenVPN for the reasons we have a new "check the peer id!" check in this
patch... so we need this patch anyway, obsoleting the need for a
kernel patch...

Tested on 
  - FreeBSD 14 / CURRENT DCO, client and server
  - Ubuntu 20.04, Linux DCO, client and server
  - Gentoo, Linux with no DCO, client and server

Your patch has been sho(u|o)ted into to the master branch.

commit 0f7c5dde1bbd23353467ebd549ae955a6a03746f
Author: Arne Schwabe
Date:   Thu Dec 1 12:01:28 2022 +0100

     Allow reconnecting in p2p mode work under FreeBSD

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221201110128.271064-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25602.html
     Signed-off-by: Gert Doering <gert@...1296...>

--
kind regards,

Gert Doering


