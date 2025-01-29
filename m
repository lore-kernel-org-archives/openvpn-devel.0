Date: Wed, 29 Jan 2025 17:46:25 +0100 (CET)
Message-Id: <202501291646.50TGkPKf066705@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250129161609.19202-1-gert@...1296...>
References: <20250129161609.19202-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: mroute/management: repair mgmt
 client-kill for mroute with proto
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
To: Gianmarco De Gregori <gianmarco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

This is somewhat of a cleanup-repair-broken-API patch, and it took us
a few rounds to get this in a nice shape.  commit dda93f304 adds a 
"proto" field to the mroute hashing & comparison to disambiguate 
udp and tcp connects, and that promptly broke the "kill $ip:$port"
management command (not matching at all, and Coverity complaining 
about "proto" being uninitialized there).  Change that API command
to do "kill $proto:$ip:$port" now, and adjust the documentation(!).

NOTE: this is still broken for IPv6, as only IPv4 addresses are parsed -
and this has been broken since IPv6 transport has been introduced - so
I guess nobody is really using it...

Your patch has been applied to the master branch.

commit 10a82b1f2fe3cf295a4a44dac1f61fdf750c172a
Author: Gianmarco De Gregori
Date:   Wed Jan 29 17:16:08 2025 +0100

     mroute/management: repair mgmt client-kill for mroute with proto

     Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250129161609.19202-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30716.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


