Date: Sun, 29 Nov 2015 14:32:00 +0100 (CET)
Message-Id: <201511291332.tATDW0pg018260@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1448590853-26862-1-git-send-email-selva.nair@...277...>
References: <1448590853-26862-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Unbreak read username password
	from management
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  This looks reasonable, and I've tested the use cases I can easily
test here ("all from stdin", "username from file, pass from stdin", "both 
from file").  Sorry for causing you pain in your VPN setups - and thanks
for taking care of this.

Your patch has been applied to the master and release/2.3 branch.

commit cdd69bb7f1c207fb5a9648f36440d7c6e2dcaa76 (master)
commit 9557196ffb3296f2a8e5aee4521702f1d0c2019b (release/2.3)

Author: Selva Nair
Date:   Thu Nov 26 21:20:53 2015 -0500

     Unbreak read username password from management

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1448590853-26862-1-git-send-email-selva.nair@...277...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10630
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


