Date: Wed, 29 Sep 2021 19:39:38 +0200 (CEST)
Message-Id: <202109291739.18THdc1t056921@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20210903161113.30498-2-a@...2181...>
References: <20210903161113.30498-2-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: set_lladdr: use networking API
 net_addr_ll_set() on Linux
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

Stared at the code, tested on FreeBSD, Linux/iproute2 and Linux/sitnl,
MAC addresses are properly set.

As discussed on IRC a while ago, I have added brackets to the
ugly assignment

      r = (net_addr_ll_set(ctx, ifname, addr) == 0);

and I have added the "Tested-By:" line from Jan Hugo Prins.

Your patch has been applied to the master branch, and pulled up
(3 squashed commits) to release/2.5

commit 7205cdd8508be0ec9a83ea2e012e2a495157cad0 (master)
commit e2fded0f72765467fd0d602562bbf41d48c58d39 (release/2.5)
Author: Antonio Quartulli
Date:   Fri Sep 3 18:11:13 2021 +0200

     set_lladdr: use networking API net_addr_ll_set() on Linux

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20210903161113.30498-2-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22791.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


