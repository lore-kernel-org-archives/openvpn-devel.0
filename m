Date: Fri, 14 Nov 2025 22:01:02 +0100 (CET)
Message-Id: <202511142101.5AEL12rm062717@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251112215106.14182-1-gert@...1296...>
References: <20251112215106.14182-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: iservice: use saved iface index
 to restore metric
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
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

Makes sense.  Lev happy, BB happy, test compile happy.

release/2.6 might benefit from this as well, but the code is different
enough that this is not an "automatic" backport

  DeleteBlockDNS(const block_dns_message_t *msg, undo_lists_t *lists)
  =======
  DeleteWfpBlock(undo_lists_t *lists)

(it's fairly straightforward, but still "more code change than I should do",
and it needs explicit testing on the 2.6 branch)

Your patch has been applied to the master branch.

commit a1d4a79487ec0089ee01ab635921761933e4e1d6
Author: Heiko Hund
Date:   Wed Nov 12 22:51:00 2025 +0100

     iservice: use saved iface index to restore metric

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1363
     Message-Id: <20251112215106.14182-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34400.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


