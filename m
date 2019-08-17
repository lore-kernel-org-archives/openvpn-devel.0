Date: Sat, 17 Aug 2019 21:13:22 +0200 (CEST)
Message-Id: <201908171913.x7HJDMeB077436@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20190805092529.9467-7-a@...2181...>
References: <20190805092529.9467-7-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: route.c: simplify ifdef logic
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

These look like reasonable simplifications - if we're not on linux, 
we'll never have ENABLE_IPROUTE2, so no good testing for it.  And so on.

Compile tested on Linux/sitnl, Linux/iproute2, FreeBSD.  Buildbot will
see to the others  (if it breaks AIX, I'll find out next time I play
around with that port, and complain to the dimwit who ACKed this :) ).

Your patch has been applied to the master branch.

commit d42f070c507592a80425fa45801bc2d4cb573789
Author: Antonio Quartulli
Date:   Mon Aug 5 11:25:29 2019 +0200

     route.c: simplify ifdef logic

     Signed-off-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20190805092529.9467-7-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18724.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


