Date: Sun, 23 Feb 2014 16:31:42 +0100 (CET)
Message-Id: <201402231531.s1NFVgXJ015381@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1392746395-19246-1-git-send-email-heiko.hund@...1489...>
References: <1392746395-19246-1-git-send-email-heiko.hund@...1489...>
Subject: [Openvpn-devel] [PATCH applied] Re: grow route lists dynamically
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

Another ACK from me.  Get rid of one option and a "historic" limitation
(and actually save memory on typical setups with less than 100 routes...),
plus simplify the code in a few places.  *like* :-)

Patch has been applied to the master branch.

commit d0085293e709c8a722356cfa68ad74c962aef9a2 (master)

Author: Heiko Hund
Date:   Tue Feb 18 18:59:55 2014 +0100

     grow route lists dynamically

     Signed-off-by: Heiko Hund <heiko.hund@...1489...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1392746395-19246-1-git-send-email-heiko.hund@...1489...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8295
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


