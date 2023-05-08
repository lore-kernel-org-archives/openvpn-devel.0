Date: Mon, 8 May 2023 14:17:18 +0200 (CEST)
Message-Id: <202305081217.348CHIZm004823@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230417125446.27247-1-frank@...2641...>
References: <20230417125446.27247-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: fix typo in help text:
 --ignore-unknown-option
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
To: Michael Nix <mchl.nix@...1030...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

"because it makes sense".

I have not tested this beyond "does it still compile?" (which is just
paranoia since "it's only changing a single byte in a string", but hey...)

@Frank, thanks for forwarding this from a MR to the list.

Your patch has been applied to the master and release/2.6 branch.

commit c7da4e0dcca5a56e2ec37fc8a2672cdbebe65048 (master)
commit d76fc3336def34adf7e76141865c492fdf69d844 (release/2.6)
Author: Michael Nix
Date:   Mon Apr 17 14:54:46 2023 +0200

     fix typo in help text: --ignore-unknown-option

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230417125446.27247-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26592.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


