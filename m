Date: Wed, 5 Jul 2023 16:00:44 +0200 (CEST)
Message-Id: <202307051400.365E0iYf003236@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221127085933.3487177-1-arne@...1227...>
References: <20221127085933.3487177-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: fix warning with gcc 12.2.0
 (compiler bug?)
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Since the patch is so straightforward, and has an ACK, not tested anything.

Your patch has been applied to the master and release/2.6 branch.

commit 5ad793e8cab8fcccae93fe9442eca6a6de8c044c (master)
commit 5bdeda19e7aaa89523180e46369fc85ba204f70f (release/2.6)
Author: Arne Schwabe
Date:   Sun Nov 27 09:59:33 2022 +0100

     fix warning with gcc 12.2.0 (compiler bug?)

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Heiko Hund <heiko@...2662...>
     Message-Id: <20221127085933.3487177-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25549.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


