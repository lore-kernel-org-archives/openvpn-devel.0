Date: Tue, 20 May 2014 11:01:20 +0200 (CEST)
Message-Id: <201405200901.s4K91K8g008766@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1399589436-8730-2-git-send-email-james@...515...>
References: <1399589436-8730-2-git-send-email-james@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fixed several instances of
	declarations after statements.
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

Your patch has been applied to the release/2.3 branch.

Two of the changes are in "master" already, and the socket.c one has been
superseded by Arne's dual-stack code changes.

commit 8adb295ebaef0ddf10ce732df36fa6be2d939c0c
Author: James Yonan
Date:   Thu May 8 16:50:31 2014 -0600

     Fixed several instances of declarations after statements.

     Signed-off-by: James Yonan <james@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1399589436-8730-2-git-send-email-james@...515...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8709
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


