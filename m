Date: Thu, 13 Mar 2025 18:12:46 +0100 (CET)
Message-Id: <202503131712.52DHCkvh049193@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250227032522.3734947-1-dqfext@...277...>
References: <20250227032522.3734947-1-dqfext@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: fix source IP selection
 when multihome
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
To: Qingfang Deng <dqfext@...277...>
Cc: openvpn-devel@lists.sourceforge.net

At last :-) - thanks, Antonio for testing, thanks Quingfang for your
patience.

I haven't tested it (do I look like I understand DCO stuff? :-) ) but
from looking at other places, "ipi_spec_dst" is what is used elsewhere
as "this is our IP" as well ("dest" might be confusing here, but it's
the "dest of the incoming UDP packet" = "our source for outgoing packets")

Again, I had to link to the sourceforge.net mail archive as the 
mail-archive.org one seems to not have the v3 patch at all.  Highly
annoying.

Your patch has been applied to the master and release/2.6 branch (bugfix).

commit e4beaf7a610793f57984ec8006d26f9a695b0c74 (master)
commit b9ad768ae2daf76f9ee2f20da70ecf8d62b6d4e5 (release/2.6)
Author: Qingfang Deng
Date:   Thu Feb 27 11:25:22 2025 +0800

     dco: fix source IP selection when multihome

     Signed-off-by: Qingfang Deng <dqfext@...277...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20250227032522.3734947-1-dqfext@...277...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59154010/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


