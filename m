Date: Tue, 9 Jun 2020 16:01:04 +0200 (CEST)
Message-Id: <202006091401.059E14fJ008104@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200608201613.23750-1-a@...2181...>
References: <20200608201613.23750-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH applied] Re: ipv6-pool: get rid of size
 constraint
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

Stared-at-code and tested on the t_server machine.  And crashed.  But
that was not actually *this* patch's fault, but 6a8cd033b18's (fixed).

This code does what it says on the lid - loosen up the "/112 is the
minimum size" restriction on IPv6 pools, up to a /124 (which we can
*now* handle correctly, as we do actual size calculations and checks).

At the same time it introduces a minimum size sanity check - a pool
that has less than 2 free addresses left (::ffff/124) will error out.

(Which is not working right now, because the IPv6 pool size calculation
is not correct yet for small pools - but that will be fixed with the next 
commit)

Your patch has been applied to the master branch.

commit 1379e5271d0057fcaed82d6985e614ca2ed8c265
Author: Antonio Quartulli
Date:   Mon Jun 8 22:16:13 2020 +0200

     ipv6-pool: get rid of size constraint

     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20200608201613.23750-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20005.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


