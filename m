Date: Fri, 25 Jul 2025 20:06:05 +0200 (CEST)
Message-Id: <202507251806.56PI65mR020270@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250725172708.19456-1-gert@...1296...>
References: <20250725172708.19456-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco_linux: fix async message
 reception
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
To: Antonio Quartulli <antonio@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for that work.

I tested all the "easy" notifications (DEL_PEER and FLOAT), and can
confirm that the race/mixup we observed in gerrit#1086 (issue #793) is
now fixed for good - with sufficient patience it's still possible to
inject a FLOAT message between "ask for peer stats" and "receive peer
stats", but the new dispatching logic handles things just fine, we're
no longer losing FLOAT messages, and life is good.

I did not test KEY_SWAP_NTF as that's not easy to trigger (without kernel
changes to lower the threshold) but as that code is not affected at all
by this commit I do not expect any surprises there.

Besides the manual test, this handled the DCO client/server test runs
just fine.

There's some suggestions to the code I still have, but "it works,
ship it" (so we get more exposure to the code we considered fixed) - the
cleanup can be a separate patch.

Your patch has been applied to the master branch.

commit f353b7100c859a02e70723c998594c3efd83c419
Author: Antonio Quartulli
Date:   Fri Jul 25 19:27:02 2025 +0200

     dco_linux: fix async message reception

     Signed-off-by: Antonio Quartulli <antonio@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250725172708.19456-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32339.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


