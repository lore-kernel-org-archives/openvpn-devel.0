Date: Tue, 1 Apr 2014 15:41:48 +0200 (CEST)
Message-Id: <201404011341.s31DflBK010123@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1396346803-31772-1-git-send-email-heiko.hund@...1489...>
References: <1396346803-31772-1-git-send-email-heiko.hund@...1489...>
Subject: [Openvpn-devel] [PATCH applied] Re: fix route struct name
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

ACK, thanks.  

Inside #ifdef WIN32, which is why we didn't catch it on unix before (we
really need a windows buildslave...).

Your patch has been applied to the master branch.

commit 60b40a58c4caaeb5c5aa8d402020414d3ba05050 (master)

Author: Heiko Hund
Date:   Tue Apr 1 12:06:43 2014 +0200

     fix route struct name

     Signed-off-by: Heiko Hund <heiko.hund@...1489...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1396346803-31772-1-git-send-email-heiko.hund@...1489...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8421
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


