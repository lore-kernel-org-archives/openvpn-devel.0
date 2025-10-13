Date: Mon, 13 Oct 2025 18:42:39 +0200 (CEST)
Message-Id: <202510131642.59DGgdKX085109@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251013161759.1656-1-gert@...1296...>
References: <20251013161759.1656-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dhcp: Clean up type handling of
 write_dhcp_*
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

"Change looks good" and the new UT still passes...

And thanks for fixing the clang-format accident in N_DHCP_ADDR ;-)

Your patch has been applied to the master branch.

commit b298a7418e3776972159d84c4636c829ec6f6946
Author: Frank Lichtenheld
Date:   Mon Oct 13 18:17:53 2025 +0200

     dhcp: Clean up type handling of write_dhcp_*

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1268
     Message-Id: <20251013161759.1656-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59246219/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


