Date: Mon, 28 Nov 2022 11:09:53 +0100 (CET)
Message-Id: <202211281009.2ASA9rsI004485@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221127090742.3487997-1-arne@...1227...>
References: <20221127090742.3487997-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use dedicated
 multi->dco_peer_id for DCO instead of multi->peer_id
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

This patch survived all tests I threw at it (Linux and FreeBSD client
and server, with and without DCO, including multiple p2mp clients on
the server under test).

The "main" code change (dco_peer_id) is fairly straightforward, if
one checks for the right values of "-1".

The completely new bit in v3 is "multi_client_setup_dco_initial()",
which packs all the "init a new p2mp DCO peer" into a single function,
so early-return is possible, and the path "anything DCO fails ->
CAS_FAILED -> AUTH_FAILED" is easier to see.

We discussed - at breakfast - changes necessary to make the server
not abort "if anything DCO fails" (v2 tried to setup a peer with "-1",
which failed, and that did not lead to "CAS_FAILED" but to "server
aborts").  The code in question is in ssl.c, init_key_contexts(), and it
has two M_FATAL conditions - we should see that we can turn this into
"kill the client instance, not the server".  As discussed, "not being
able to set up keys in DCO" is a race with "the kernel might have
killed that instance just now, due to TCP RST etc".

This is not part of *this* patch yet, but it's not caused by this 
patch either - so no reason to not progress.


Your patch has been applied to the master branch.

commit 8d4dbb56e7dda87ef031fdf52c6d87e533250ff3
Author: Arne Schwabe
Date:   Sun Nov 27 10:07:42 2022 +0100

     Use dedicated multi->dco_peer_id for DCO instead of multi->peer_id

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221127090742.3487997-1-arne@...1227...>
     URL: https://www.mail-archive.com/search?l=mid&q=20221127090742.3487997-1-arne@...1227...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


