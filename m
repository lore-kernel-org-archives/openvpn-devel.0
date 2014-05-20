Date: Tue, 20 May 2014 11:06:39 +0200 (CEST)
Message-Id: <201405200906.s4K96d4I016230@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1399589436-8730-4-git-send-email-james@...515...>
References: <1399589436-8730-4-git-send-email-james@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: Explicitly cast the third
	parameter of setsockopt to const void * to avoid warning.
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
To: James Yonan <james@...515...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.

Your patch has been applied to the release/2.3 branch only.

"master" has this change as part of 46e02127 already.

commit 36c216556a0de5250040d95ac8f7a8c18b8683b4
Author: James Yonan
Date:   Thu May 8 16:50:33 2014 -0600

     Explicitly cast the third parameter of setsockopt to const void * to avoid warning.

     Signed-off-by: James Yonan <james@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1399589436-8730-4-git-send-email-james@...515...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8708
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


