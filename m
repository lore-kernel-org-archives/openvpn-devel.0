Date: Sat, 6 Dec 2014 14:55:17 +0100 (CET)
Message-Id: <201412061355.sB6DtHPX002499@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1416148262-20978-1-git-send-email-openvpn.list@...1114...>
References: <1416148262-20978-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH applied] Re: down-root plugin: Replaced
	system() calls with execve()
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
To: David Sommerseth <davids@...1347...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.3 branch.

commit f87b1beccb817e1633bc95bd5dd19deec35c7edc (master)
commit 07d61fee2047686e5bec237a6cd7467244f91e13 (release/2.3)

Author: David Sommerseth
Date:   Sun Nov 16 15:31:02 2014 +0100

     down-root plugin: Replaced system() calls with execve()

     Signed-off-by: David Sommerseth <davids@...1347...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <1416148262-20978-1-git-send-email-openvpn.list@...1114...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/9238
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


