Date: Sun, 20 Feb 2022 15:32:52 +0100 (CET)
Message-Id: <202202201432.21KEWqHP069376@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220214122409.260-1-lstipakov@...277...>
References: <20220214122409.260-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnmsica: add ovpn-dco
 custom actions
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

Acked-by: Gert Doering <gert@...1296...>

Thanks to Simon for testing & advising Lev here.

I would have preferred to have the WCHAR fixes decoupled from "new
functionality" - that makes reviewing easier.  This said, the WCHAR
fixes look good, and the rest looks at least "reasonable" - as I have
no much idea what's going on there I can only look at "safe pointer 
use" etc.

Your patch has been applied to the master branch.

commit 055605783ee08767d871fbeffb6871368bdf1ada
Author: Lev Stipakov
Date:   Mon Feb 14 14:24:09 2022 +0200

     openvpnmsica: add ovpn-dco custom actions

     Signed-off-by: Lev Stipakov <lev@...515...>
     Signed-off-by: Simon Rozman <simon@...2293...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220214122409.260-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23786.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


