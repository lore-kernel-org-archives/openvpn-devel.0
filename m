Date: Wed, 25 Jan 2023 10:17:03 +0100 (CET)
Message-Id: <202301250917.30P9H38s040443@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230124142316.441-1-lstipakov@...277...>
References: <20230124142316.441-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnmsica: fix adapters
 discovery logic for DCO
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

And here we have the winning patch for "very last minute before 2.6.0
release" - I hope it won't break Windows installation, as I couldn't
actually test it.  It does not break Windows compilation :-) (GH is 
broken, as is most of Microsoft today - local mingw build succeeds)

Your patch has been applied to the master and release/2.6 branch.

commit 7a23a7dda27349f7c7fd7af2ed1380ede1becf06 (master)
commit f4904e2ef4a61665561272fead0c4393947a27d1 (release/2.6)
Author: Lev Stipakov
Date:   Tue Jan 24 16:23:16 2023 +0200

     openvpnmsica: fix adapters discovery logic for DCO

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20230124142316.441-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26072.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


