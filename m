Date: Fri, 8 Apr 2022 13:42:07 +0200 (CEST)
Message-Id: <202204081142.238Bg71D081194@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220407081555.25228-1-a@...2181...>
References: <20220407081555.25228-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: t_net.sh: delete dummy iface
 using iproute command
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

Indeed, now t_net.sh properly cleans up behind itself :-) - thanks.

Your patch has been applied to the master and release/2.5 branch.

commit 976e6caf0e161d3c787e1378cec44608c17b292a (master)
commit c3f4419cd37faaf4f2960d911a1008a161b82561 (release/2.5)
Author: Antonio Quartulli
Date:   Thu Apr 7 10:15:55 2022 +0200

     t_net.sh: delete dummy iface using iproute command

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220407081555.25228-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24086.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


