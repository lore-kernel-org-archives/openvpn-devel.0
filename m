Date: Wed, 19 Oct 2022 19:39:17 +0200 (CEST)
Message-Id: <202210191739.29JHdHMt079682@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220624122657.28675-1-frank@...2641...>
References: <20220624122657.28675-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: test_crypto: fix
 test_occ_mtu_calculation with --disable-fragment
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

Change makes sense :-) - have not tested any actual builds without
ENABLE_FRAGMENT to verify that it exploded *before*, but it looks
like this will fix it.

Your patch has been applied to the master branch.

commit 252e5d6888261d7b2aae1034c834fba8a393cef4
Author: Frank Lichtenheld
Date:   Fri Jun 24 14:26:57 2022 +0200

     test_crypto: fix test_occ_mtu_calculation with --disable-fragment

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20220624122657.28675-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24550.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


