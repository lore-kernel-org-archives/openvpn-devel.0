Date: Tue, 10 Sep 2024 08:03:55 +0200 (CEST)
Message-Id: <202409100603.48A63tuC098225@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240909204829.10379-1-selva.nair@...277...>
References: <20240909204829.10379-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix more of uninitialized
 struct user_pass local vars
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

Acked-by: Gert Doering <gert@...1296...>

Thanks.  Not tested beyond "does it compile", as the changes are very
straightforward :-)

Your patch has been applied to the master and released/2.6 branch.

commit aa1dd09b5fc196499c84d2ef9b0c254ebb1745d8 (master)
commit f9ab7edbebd6dfb3fd384b56626aabb3171ac0ad (release/2.6)
Author: Selva Nair
Date:   Mon Sep 9 16:48:29 2024 -0400

     Fix more of uninitialized struct user_pass local vars

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20240909204829.10379-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29152.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


