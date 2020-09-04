Date: Fri, 4 Sep 2020 21:26:09 +0200 (CEST)
Message-Id: <202009041926.084JQ9x5004562@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200902213643.401-1-lstipakov@...277...>
References: <20200902213643.401-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnmsica: make adapter
 renaming non-fatal
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.5 branch.

Thanks for coming up with the solution & testing & reviewing it!

The comment line is a bit long... uncrustify will catch it next time.

I have not tested anything, trusting Lev and Simon here :-)  (but
from a cursory glance, the change looks nice and reasonable)

commit b341b1c596931f8a1f77f054ba505b5c1e3547be (master)
commit 567e277f1cbaa8059319a8feea4c08edf77b6a5a (release/2.5)
Author: Lev Stipakov
Date:   Thu Sep 3 00:36:43 2020 +0300

     openvpnmsica: make adapter renaming non-fatal

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Simon Rozman <simon@...2293...>
     Message-Id: <20200902213643.401-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20875.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


