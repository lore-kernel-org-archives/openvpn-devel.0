Date: Mon, 30 Jun 2014 16:51:04 +0200 (CEST)
Message-Id: <201406301451.s5UEp3ja019618@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <A1005665-126D-45D5-A6F2-75ED0EAE30FE@...1918...>
References: <A1005665-126D-45D5-A6F2-75ED0EAE30FE@...1918...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix socket-flag/TCP_NODELAY on
	Mac OS X
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: James Bekkema <james@...1918...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks. Patch has been applied to the master and release/2.3 branches.

commit 37170767a221a4847416fc339083704ae1b4c001 (master)
commit 066202de18a13d67664534d10698eda1fdeab381 (release/2.3)

Author: James Bekkema
Date:   Thu Jun 26 21:40:39 2014 +1000

     Fix socket-flag/TCP_NODELAY on Mac OS X

     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <A1005665-126D-45D5-A6F2-75ED0EAE30FE@...1918...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8809
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


