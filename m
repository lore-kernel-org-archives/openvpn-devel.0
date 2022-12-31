Date: Sat, 31 Dec 2022 11:18:35 +0100 (CET)
Message-Id: <202212311018.2BVAIZ4f001080@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221229182739.1477336-2-selva.nair@...277...>
References: <20221229182739.1477336-2-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Cleanup: Close duplicated
 handles in interactive service
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

Again, thanks for the cleanup.  As with 1/2, just glanced at the code
change and not explicitly tested (beyond "feed to github actions").

Your patch has been applied to the master and release/2.6 branch.

commit a10564c71608dca6172a89dc458e6e23254d600b (master)
commit e47c88bbc593f99529712229fae65470a2e4e0a8 (release/2.6)
Author: Selva Nair
Date:   Thu Dec 29 13:27:39 2022 -0500

     Cleanup: Close duplicated handles in interactive service

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20221229182739.1477336-2-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25863.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


