Date: Thu, 23 Mar 2023 09:39:38 +0100 (CET)
Message-Id: <202303230839.32N8dcsk035464@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230323080341.51624-1-gert@...1296...>
References: <20230323080341.51624-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco-freebsd: use m->instances[]
 instead of m->hash
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

As this patch has a bit of mixed history "who wrote it, who ACKed it,
what happened afterwards" I decided to record the ACK from Arne and 
Kristof.

v4 has been tested on FreeBSD with DCO enabled, p2mp udp server, one client
being connected all the time and the other client reconnecting (moving
between peer-id 1 and 2), packets going back and forth, looking at the
resulting counters.  Everything looked as expected.

(This is basically an optimization that was discussed in November
already but nobody followed up on it - and with the upcoming Linux DCO
counter patches, the topic "why use iterator when you have an array?"
resurfaced - thanks, Antonio, for covering FreeBSD too)

Your patch has been applied to the master and release/2.6 branch.

commit 03145f223236df90b35d1db444319fd3f785792b (master)
commit 5acefd944c6a8a4338b5105ffe6b9ffce6bad330 (release/2.6)
Author: Antonio Quartulli
Date:   Thu Mar 23 09:03:41 2023 +0100

     dco-freebsd: use m->instances[] instead of m->hash

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Acked-by: Kristof Provost <kp@...1249...>
     Message-Id: <20230323080341.51624-1-gert@...1296...>
     URL: https://www.mail-archive.com/search?l=mid&q=20230323080341.51624-1-gert@...1296...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


