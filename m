Date: Fri, 16 Dec 2022 18:32:28 +0100 (CET)
Message-Id: <202212161732.2BGHWS3L017402@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221215190143.2107896-7-arne@...1227...>
References: <20221215190143.2107896-7-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove unused gc_arena
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

Trivial enough.

Client-side tested to see if the compiler agrees :-) (it does, but in
release/2.5, *one* of these GCs is actually still used - 2.5 still has PF,
and PF log calls mroute_addr_print_ex(..., &gc)... so the backport only
removes the other gc)

Your patch has been applied to the master, release/2.6 and release/2.5 branch.

commit 97929d16a4eb05cb521a469ff4eaca32761699f3 (master)
commit a873736483836a3c0574085712beeaea8bba30e9 (release/2.6)
commit 5ca01c79bc3c972719e844b224dac981e128cbb6 (release/2.5)
Author: Arne Schwabe
Date:   Thu Dec 15 20:01:41 2022 +0100

     Remove unused gc_arena

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221215190143.2107896-7-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25736.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


