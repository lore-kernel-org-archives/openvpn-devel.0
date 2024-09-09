Date: Mon, 9 Sep 2024 11:33:29 +0200 (CEST)
Message-Id: <202409090933.4899XToe058168@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240906162514.78671-1-frank@...2641...>
References: <20240906162514.78671-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: tun: use is_tun_p2p more
 consistently
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Sorry for taking so long to handle this.  These old code ruins make
my head spin...

Anyway.  Arne has ACKed it, GHA likes it, my server and client test rigs
find nothing to complain.

Did stare-at-code while the tests were running... all reasonable
changes, nothing should have a behavioural change (except the fix in
ifconfig_sanity_check()).  Good catch on print_topology() ;-)

Quite a few of the old
  "else if (tt->type == DEV_TYPE_TUN && tt->topology == TOP_SUBNET)"
are my doing, I think... seems "if (tun)" was really very unclear...

Also thanks for restructuring the Darwin section to be "just as all
the other platforms" :-)

Your patch has been applied to the master branch.

commit 976a65346d2193181f4f5664f798e16fcbf43345
Author: Frank Lichtenheld
Date:   Fri Sep 6 18:25:14 2024 +0200

     tun: use is_tun_p2p more consistently

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Arne Schwabe <arne-openvpn@...1227...>
     Message-Id: <20240906162514.78671-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29091.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


