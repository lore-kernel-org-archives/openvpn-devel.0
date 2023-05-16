Date: Tue, 16 May 2023 13:21:34 +0200 (CEST)
Message-Id: <202305161121.34GBLYKq047134@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230516024232.2680491-1-selva.nair@...277...>
References: <20230516024232.2680491-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Correctly handle Unicode names
 for exit event
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Explanation makes sense, though it's only relevant for "outside openvpn GUI"
use cases.  But I look forward to a submission of "openvpn windows CLI" :-)

Test compiled on MinGW.  Does our GH windows test setup use the event
mechanism?  Or "classic signals"?

Your patch has been applied to the master and release/2.6 branch.

commit 80b073b649fca54f5021f6b4ae45a1e74a07faea (master)
commit 232a0fac1ede6724688cbd4f5d5f2e619f647e16 (release/2.6)
Author: Selva Nair
Date:   Mon May 15 22:42:32 2023 -0400

     Correctly handle Unicode names for exit event

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20230516024232.2680491-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26666.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


