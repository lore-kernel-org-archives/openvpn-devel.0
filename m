Date: Sat, 24 Jan 2026 18:21:10 +0100 (CET)
Message-Id: <202601241721.60OHLAWJ046724@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260119214927.27766-1-gert@...1296...>
References: <20260119214927.27766-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: Factor out the
 string conversion from GetItfDnsDomains
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

This is paving the way to adding a unit test for this slightly convoluted
modify-string-in-place function - and as such, highly welcome.  ACK from
Heiko, green light from the BBs (which do not really test beyond "does
it compile with no warnings", but at least that)

"git show --color-moved=zebra -w" is helpful in seeing what exactly
got moved (and reindented) and what is new ("the prototype and the 
explanatory comment").

Your patch has been applied to the master branch.

commit cd533c483aa516a60d12a132761ab349f9b8b399
Author: Frank Lichtenheld
Date:   Mon Jan 19 22:49:22 2026 +0100

     openvpnserv: Factor out the string conversion from GetItfDnsDomains

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Heiko Hund <heiko@...515...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1458
     Message-Id: <20260119214927.27766-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35343.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


