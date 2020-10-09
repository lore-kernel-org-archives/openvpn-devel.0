Date: Fri, 9 Oct 2020 17:24:17 +0200 (CEST)
Message-Id: <202010091524.099FOHwt058092@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20201009134603.36263-1-steffan@...1856...>
References: <20201009134603.36263-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: networking_iproute2: fix memory
 leak in net_iface_mtu_set()
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

Yeah, very obvious when you look at it :-)  (wasn't *me* who
ACKed that commit... but I had to check to be sure ;-) )

Your patch has been applied to the master and release/2.5 branch.

commit 1e6e083e8888042d58f9541bf74d343d52fc5681 (master)
commit a9c8225439f0acaa679ee59244b5b8660b561592 (release/2.5)
Author: Steffan Karger
Date:   Fri Oct 9 15:46:03 2020 +0200

     networking_iproute2: fix memory leak in net_iface_mtu_set()

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20201009134603.36263-1-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21189.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


