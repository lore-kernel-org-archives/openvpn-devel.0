Date: Wed, 23 Sep 2015 19:09:44 +0200 (CEST)
Message-Id: <201509231709.t8NH9iSW063158@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1440680402-96548-1-git-send-email-gert@...1296...>
References: <1440680402-96548-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Replace unaligned 16bit access
	to TCP MSS value with bytewise access
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Patch has been applied to the master and release/2.3 branch.

commit 2e2a34181962b33d70c34c28dcb1e1977c2fd54e (master)
commit 9a2ab2fbebb1c6712e23c98cb06a93d40d378fcd (release/2.3)

Author: Gert Doering
Date:   Thu Aug 27 15:00:02 2015 +0200

     Replace unaligned 16bit access to TCP MSS value with bytewise access

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <1440680402-96548-1-git-send-email-gert@...1296...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10056


--
kind regards,

Gert Doering


