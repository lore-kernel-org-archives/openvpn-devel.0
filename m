Date: Sat, 13 Aug 2022 21:03:06 +0200 (CEST)
Message-Id: <202208131903.27DJ36jn053725@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220812130657.29899-11-a@...2181...>
References: <20220812130657.29899-11-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: move message to DCO debug
 level and reword a bit
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

Acked-by: Gert Doering <gert@...1296...>

Indeed :-) - this message is fairly confusing on systems with multiple
DCO-using OpenVPN instances, running with --verb 3 - for all new 
clients and client disconnects, there's noise in "other" instances,
which looked quite scary.

I haven't tested this (beyond a compile test), but I know when and where
I saw these, and making them go to DCO debug level is reasonable.

Your patch has been applied to the master branch.

commit f088db208621ead8e8c7151f3e705f5ff9a0cbb5
Author: Antonio Quartulli
Date:   Fri Aug 12 15:06:57 2022 +0200

     dco: move message to DCO debug level and reword a bit

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220812130657.29899-11-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24893.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


