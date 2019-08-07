Date: Wed, 7 Aug 2019 12:11:04 +0200 (CEST)
Message-Id: <201908071011.x77AB4KJ015728@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20190805092529.9467-3-a@...2181...>
References: <20190805092529.9467-3-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: networking/best_gw: remove
 useless prefixlen parameter
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

Nice, trivial, and to the point :-) - passing "make check" for iproute2
and sitnl builds.

Your patch has been applied to the master branch.

commit 4490b5a1eae96904f8973d44ff0e12d819cb9cbc
Author: Antonio Quartulli
Date:   Mon Aug 5 11:25:25 2019 +0200

     networking/best_gw: remove useless prefixlen parameter

     Signed-off-by: Antonio Quartulli <antonio2openvpn.net>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20190805092529.9467-3-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18725.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


