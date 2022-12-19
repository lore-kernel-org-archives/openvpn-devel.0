Date: Mon, 19 Dec 2022 20:31:45 +0100 (CET)
Message-Id: <202212191931.2BJJVjga018144@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221215232104.1181936-1-selva.nair@...277...>
References: <20221215232104.1181936-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Persist DCO client data channel
 traffic stats on restart
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

I have not tested this beyond "push to my github instance and verify
that it still builds", but if Lev says it's been tested and working,
good enough.  Stare-at-code finds me wondering why we didn't remove
ENABLE_MANAGEMENT yet (my fault...) and need these extra indirections -
but that's for 2.7 to clean up, I am afraid.

Your patch has been applied to the master and release/2.6 branch.

commit 0fdbb288db06792d5dd29acd14205d751041513d (master)
commit 1f17444ad02e500a717e2674f6ef74c1d2c49567 (release/2.6)
Author: Selva Nair
Date:   Thu Dec 15 18:21:04 2022 -0500

     Persist DCO client data channel traffic stats on restart

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20221215232104.1181936-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25742.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


