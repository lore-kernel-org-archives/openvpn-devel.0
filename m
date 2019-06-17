Date: Mon, 17 Jun 2019 19:36:31 +0200 (CEST)
Message-Id: <201906171736.x5HHaVXB011333@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20190617124110.30907-2-a@...2181...>
References: <20190617124110.30907-2-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: route.c: fix windows build by
 removing mismatching function parameter
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
To: Antonio Quartulli <antonio@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

"Because it's the quick fix, reverting one too-eager argument change while
we do not have the rest of the get_default_gateway_ipv6() stuff in-tree"

I have not test-compiled it, but it looks very reasonable :-)

Your patch has been applied to the master branch.

commit 22020547cbfa4a7199925bc4f32d95e84c504af2
Author: Antonio Quartulli
Date:   Mon Jun 17 14:41:10 2019 +0200

     route.c: fix windows build by removing mismatching function parameter

     Signed-off-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20190617124110.30907-2-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18551.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


