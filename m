Date: Sun, 22 Jun 2025 13:35:39 +0200 (CEST)
Message-Id: <202506221135.55MBZdbg082837@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250622110311.1140-1-gert@...1296...>
References: <20250622110311.1140-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Route: add support for user
 defined routing table
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

Thanks, Gianmarco for persisting, and apologies that it took so long.

This is one of the features that do not really cost us much to maintain,
because (recent versions of the patch, at least ;-) ) this is very
lightweight and very non-intrusive - SITNL always had the code to deal
with table-IDs, we just lacked the config option and data structure
members to pass our demands to it.  Which this patch adds.

When not using "--route-table <id>" it changes nothing whatsoever (id is
CLEAR()ed to "0", and "0" has been passed to SITNL since its introduction),
so the risk of unintended site effects was very small.  Tested the full
t_server set nevertheless (and, as expected, no surprises there).

If using the option, it will put up routes configured / learned after
--route-table <id> into, well, "routing table <id>".  Order matters, so
if you want some routes here and some routes there, just mix "route-table"
and "route" statements.

Example, adding to a --client command line

 ... --client --route-table 77 --route 10.195.0.0 255.255.0.0 --route-table

will result in 

2025-06-22 13:14:01 net_route_v4_add: 10.195.0.0/16 via 10.194.2.169 dev [NULL] table 77 metric -1
2025-06-22 13:14:01 net_route_v4_add: 10.194.0.0/16 via 10.194.2.169 dev [NULL] table 78 metric -1
2025-06-22 13:14:01 net_route_v4_add: 10.194.2.1/32 via 10.194.2.169 dev [NULL] table 78 metric -1
2025-06-22 13:14:01 net_route_v6_add: fd00:abcd:194::/48 via :: dev tun8 table 78 metric -1

.. so the first route goes to 77, and all pushed routes go to 78, and
"ip route show table <n>" confirms that routes get installed correctly.

Now, whether this is *useful* depends a lot on the local setup, whether
VRFs and multiple routing tables are in use, and which goes where.

This is a field where we could come up with some sort of "best practices"
document for "when and why would you use OpenVPN with --bind-dev and
--route-table, and how to set up and debug that"?

Also, at least FreeBSD can also do multiple routing tables, and backend
code could be written :-)


Your patch has been applied to the master branch.

commit f93fc813ffa53d170f79222e76188a18f6819a54
Author: Gianmarco De Gregori
Date:   Sun Jun 22 13:03:05 2025 +0200

     Route: add support for user defined routing table

     Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250622110311.1140-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31946.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


