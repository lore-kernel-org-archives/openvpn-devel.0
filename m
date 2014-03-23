Date: Sun, 23 Mar 2014 21:50:40 +0100 (CET)
Message-Id: <201403232050.s2NKoex1026708@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1395407925-25518-9-git-send-email-arne@...1227...>
References: <1395407925-25518-9-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add gateway and device to
	android control messages
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

ACK, on the basis of "this is all happening inside #ifdef ANDROID, and
from the description on IRC" (necessary to enable the GUI to properly
exclude routes-to-eth0 by recognizing routes-to-eth0 in the first place,
like the vpn gateway in the "redirect-gateway" case).

Patch has been applied to the master branch.

commit 928e341073cbe5aef4496e0b55aae5c6335b1fc3
Author: Arne Schwabe
Date:   Fri Mar 21 14:18:41 2014 +0100

     Add gateway and device to android control messages

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1395407925-25518-9-git-send-email-arne@...1227...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8368
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


