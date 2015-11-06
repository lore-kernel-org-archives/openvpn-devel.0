Date: Fri, 6 Nov 2015 22:08:59 +0100 (CET)
Message-Id: <201511062108.tA6L8x2n034456@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1446663578-14471-1-git-send-email-selva.nair@...277...>
References: <1446663578-14471-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix termination when windows
	suspends/sleeps
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

ACK.  Explanation makes sense, logs and testers demonstrate that it indeed
fixes a significant problem, and the code is sane :-) - thanks.

Your patch has been applied to the master and release/2.3 branch.

commit ea66a2b5cdb21422139c421b4d3733e1c1c3937e (master)
commit 0d4ba251879c702b9474e26ff73a4f559d922d4f (release/2.3)

Author: Selva Nair
Date:   Wed Nov 4 13:59:38 2015 -0500

     Fix termination when windows suspends/sleeps

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1446663578-14471-1-git-send-email-selva.nair@...277...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10438
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


