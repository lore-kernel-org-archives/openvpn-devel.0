Date: Tue, 28 Jun 2022 17:21:17 +0200 (CEST)
Message-Id: <202206281521.25SFLHCi046584@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220624083809.23487-5-a@...2181...>
References: <20220624083809.23487-5-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: create DCO interface using
 SITNL
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

This does not really do anything yet, and it won't affect "non dco"
builds.  For DCO builds, it looks reasonable and compiles without
warning (and all it really does is "if dco, then add IFLA_OVPN_MODE"
to the netlink message, passing in p2p / p2mp mode)

Your patch has been applied to the master branch.

commit 2a02c90a4501b04a43a25824fe9f7b980e10fc40
Author: Antonio Quartulli
Date:   Fri Jun 24 10:37:48 2022 +0200

     dco: create DCO interface using SITNL

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20220624083809.23487-5-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24514.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


