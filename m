Date: Wed, 2 Feb 2022 14:39:10 +0100 (CET)
Message-Id: <202202021339.212DdAQh030711@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220101162532.2251835-5-arne@...1227...>
References: <20220101162532.2251835-5-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix datagram_overhead and
 assorted functions
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

For reference, this was 12/21 in the first patch series, and got an
ACK from Frank Lichtenheld there.

Stared at the code.  Looks bigger than it really is :-) - what it
really does is pass on the socket address family down the call
chain to the "datagram_overhead()" function, which will then know
if it's v4 or v6.  

Should we ever support SCTP, we'll only have to adjust a single
function here, no mixture of functions and tables... :-)

Tested client and server side.  P2P NCP is still broken (waiting for 
13/14), Rest works.

Your patch has been applied to the master branch.

commit a63a727b020ef42c475bd861b960200686359b2d
Author: Arne Schwabe
Date:   Sat Jan 1 17:25:22 2022 +0100

     Fix datagram_overhead and assorted functions

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220101162532.2251835-5-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23504.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


