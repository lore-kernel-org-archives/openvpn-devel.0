Date: Wed, 15 May 2019 21:08:27 +0200 (CEST)
Message-Id: <201905151908.x4FJ8RRT035404@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20190514081159.12192-1-a@...2181...>
References: <20190514081159.12192-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: implement platform generic
 networking API
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

This patch does not actually *do* anything - it just brings in a
new file (networking.h) with the new API.  The file wouldn't compile
because it references not-yet-existing other .h files, so the patch
is a bit confusing - but since the rest of the series has ACKs and
needs this prequel, here we go.

Your patch has been applied to the master branch.

Note: I think "networking.h" and "networking_iproute2.h" are very
long file names (and are hurting my sense for aesthetics) so I suggest
we rename those to "net.h" and "net_<method>.h" afterwards - not the
most elegant approach but I do not want to hold up the series any
longer.

Note2: when this is in, I want us to drop support for ifconfig/route
on Linux, and get rid of --enable-iproute2 (this would become the
fallback if --enable-sitnl is not set).  Two options are enough.


commit 3d26593736982852fcf277b541da38b4c3cc7fc8
Author: Antonio Quartulli
Date:   Tue May 14 10:11:59 2019 +0200

     implement platform generic networking API

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20190514081159.12192-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18458.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


