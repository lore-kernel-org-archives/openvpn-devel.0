Date: Thu, 17 Sep 2020 17:50:59 +0200 (CEST)
Message-Id: <202009171550.08HFoxR9059746@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200917085941.20972-1-gert@...1296...>
References: <20200917085941.20972-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: If IPv6 pool specification sets
 pool start to ::0 address, increment.
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Patch has been applied to the master and release/2.5 branch.

Release/2.4 has the same "unintended feature", but the pool code
is sufficiently different that this patch will not work - I do
not see this as significant problem ("a documented workaround 
exists"), so do not currently plan to backport it.

commit 4dff236811a1ec9c97a27ad93182ad4beb12377f (master)
commit 611382c16cbac83195cc0fd4825553dad149ff9a (release/2.5)
Author: Gert Doering
Date:   Thu Sep 17 10:59:41 2020 +0200

     If IPv6 pool specification sets pool start to ::0 address, increment.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20200917085941.20972-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21039.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


