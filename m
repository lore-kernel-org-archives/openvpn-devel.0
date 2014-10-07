Date: Tue, 7 Oct 2014 14:40:05 +0200 (CEST)
Message-Id: <201410071240.s97Ce5aR004811@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1412356567-27125-1-git-send-email-openvpn.list@...1114...>
References: <1412356567-27125-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH applied] Re: systemd: Use systemd functions
	to consider systemd availability
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

ACK.  "Doesn't break anything on my test system, so safe for non-systemd
users, and looks reasonable for those"

Your patch has been applied to the master branch.

commit f33ee6bcb12fdc3869b17b7c528a209f16581e2e
Author: David Sommerseth
Date:   Fri Oct 3 19:16:07 2014 +0200

     systemd: Use systemd functions to consider systemd availability

     Signed-off-by: David Sommerseth <davids@...1347...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1412356567-27125-1-git-send-email-openvpn.list@...1114...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/9072
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


