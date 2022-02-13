Date: Sun, 13 Feb 2022 11:56:54 +0100 (CET)
Message-Id: <202202131056.21DAusDR055723@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220210162632.3309974-6-arne@...1227...>
References: <20220210162632.3309974-6-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Remove extra_link from frame
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

Acked-by: Gert Doering <gert@...1296...>

This patch series is coming to an end, and now we get to reap the 
benefits - code gets simpler, old cruft gets removed.

Stared at the change (looks good and fairly straightforward), still
ran full set of client side tests (including SOCKS).  Not run the
server side tests as there really isn't anthing that looks relevant.

Your patch has been applied to the master branch.

commit 625c4063a543700713c8fdde7dd911343dcc4dcc
Author: Arne Schwabe
Date:   Thu Feb 10 17:26:30 2022 +0100

     Remove extra_link from frame

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220210162632.3309974-6-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23751.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


