Date: Thu, 24 Nov 2022 19:55:10 +0100 (CET)
Message-Id: <202211241855.2AOItA5O000570@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221124162642.3173118-1-arne@...1227...>
References: <20221124162642.3173118-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Move dco_installed from
 sock->info to sock->info.lsa.actual
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

Taking the ACK from Antonio on v2, adding my stare-at-code for v2->v3
(introduction of addr_set_dco_installed(), callout to it from 
dco_p2p_add_new_peer() and dco_multi_add_new_peer()).

Tieing "key state" to "remote addr" is not all wrong, as we do not
currently properly differentiate "renegotiate" (= same remote IP/Port)
and "reconnect" (might be same, most likely different).  So this is
certainly something that wants to be cleaned up more thoroughly...


Note: there might be a bit of code duplication here (which should not
harm, and might go away in one of the next patches anyway) - addr_set...()
has:

+    get_link_socket_info(c)->lsa->actual.dco_installed = true;

and both callers do

+    c->c2.link_socket->info.lsa->actual.dco_installed = true;

.. which seems to be the same thing, in different wrapping, no?  Or
maybe not, as get_link_socket_info() *could* return a pointer to
c->c2.link_socket_info instead.  WTF?


Test results are much better now, though :-)

 - Ubuntu 20.04 + DCO, client (with+without DCO), server with DCO
   --> all tests pass (* - those that passed before)
   (this is the one that uncovered the "TCP p2mp breaks" in v2)

 - Gentoo, no DCO in kernel, client + server, many client instances
   --> all tests pass (*)

 - FreeBSD 14, DCO in kernel, client + server, server talks to
   Ubuntu 20.04 client instances with/without DCO
   --> all tests pass (*)

 - tried ("just to be sure") --reneg-sec to a p2mp tcp DCO server as
   well.  Renegotiates perfectly.

Your patch has been applied to the master branch.

commit f7ea7c2b4c0badfb99f75c94171400888715e8ce
Author: Arne Schwabe
Date:   Thu Nov 24 17:26:42 2022 +0100

     Move dco_installed from sock->info to sock->info.lsa.actual

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Antonio Quartulli <a@...2181...>
     Message-Id: <20221124162642.3173118-1-arne@...1227...>
     URL: https://www.mail-archive.com/search?l=mid&q=20221124162642.3173118-1-arne@...1227...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


