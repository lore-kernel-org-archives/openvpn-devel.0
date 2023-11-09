Date: Thu, 9 Nov 2023 12:31:51 +0100 (CET)
Message-Id: <202311091131.3A9BVpYK020337@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20231108124947.76816-3-gert@...1296...>
References: <20231108124947.76816-3-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix using to_link buffer after
 freed
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

Third in the series.  This is the actual bug fix for the use-after-free
leak - looks trivial enough... as Arne says, this part of the code is
too full of magic and easy to break.

Your patch has been applied to the release/2.6 and master branch.

commit 57a5cd1e12f193927c9b7429f8778fec7e04c50a (release/2.6)
commit a0afe035cbca26f8c74b670a8c2a20b3d9c2294b (master)
Author: Arne Schwabe
Date:   Fri Oct 27 14:19:37 2023 +0200

     Fix using to_link buffer after freed

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: David Sommerseth <davids@...515...>
     Acked-by: Heiko Hund <heiko@...2662...>
     Message-Id: <20231108124947.76816-3-gert@...1296...>
     URL: https://www.mail-archive.com/search?l=mid&q=20231108124947.76816-3-gert@...1296...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


