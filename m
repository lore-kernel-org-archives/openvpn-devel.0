Date: Sun, 24 Nov 2013 20:31:18 +0100 (CET)
Message-Id: <201311241931.rAOJVIu0014776@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1385064495-25877-4-git-send-email-arne@...1227...>
References: <1385064495-25877-4-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix assertion when SIGUSR1 is
	received while getaddrinfo is successful
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

ACK.

I can't easily reproduce this issue here (it's timing critical and you
need a slow resolver to be able to "hit" that window), but I think the
bug is clear enough - without the patch, the code will destroy "res",
then decide to ignore the signal (= not go to "done") and then fall over
ASSERT(res)...  so with the new code, it won't destry "res" for SIGUSR1.

Patch has been applied to the master and release/2.3 branch, as this
is just a bug, not really related to dual-stack support.

commit 282788a835f6c9dfb85e8f9a3bd45f5841271b06 (master)
commit 47a963681a6ed18d32405ec26b74d56925425093 (release/2.3)

Author: Arne Schwabe
Date:   Thu Nov 21 21:08:05 2013 +0100

     Fix assertion when SIGUSR1 is received while getaddrinfo is successful

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1385064495-25877-4-git-send-email-arne@...1227...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8019
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


