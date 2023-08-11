Date: Fri, 11 Aug 2023 18:39:29 +0200 (CEST)
Message-Id: <202308111639.37BGdTXP089073@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <60951251cdb2f39b20cfc86130c2dc0570ba0363-HTML@...2715...>
References: <60951251cdb2f39b20cfc86130c2dc0570ba0363-HTML@...2715...>
Subject: [Openvpn-devel] [PATCH applied] Re: route: Fix overriding return
 value of add_route3
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Yep, Coverity is right :-) - silly code.  Fix is in the same style we
use elsewhere, so fine.

(The whole error handling on route addition is a bit wonky, but even
then we should not forget about errors)

Test compiled on Linux, just to be sure I did not overlook anything.

Your patch has been applied to the master and release/2.6 branch.

commit 8067cc8d1b384d3eb0fc9000992710b02951b266 (master)
commit 09e2360a163077001fd33f2f338cf337b45b9ab6 (release/2.6)
Author: Frank Lichtenheld
Date:   Fri Jul 28 14:47:12 2023 +0200

     route: Fix overriding return value of add_route3

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <60951251cdb2f39b20cfc86130c2dc0570ba0363-HTML@...2715...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26900.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


