Date: Wed, 30 Dec 2015 17:57:58 +0100 (CET)
Message-Id: <201512301657.tBUGvwOM050239@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1451422561-23635-1-git-send-email-lstipakov@...277...>
References: <1451422561-23635-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Repair IPv6 netsh calls if Win
	XP is detected
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  Thanks.

Your patch has been applied to the release/2.3 branch.

(I've added a note to Changes.rst about the change and the new
feature)

commit de627cd7d450a0c32de252c098b1ca16912d595e (release/2.3)

Author: Lev Stipakov
Date:   Tue Dec 29 22:56:01 2015 +0200

     Repair IPv6 netsh calls if Win XP is detected

     Signed-off-by: Lev Stipakov <lstipakov@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1451422561-23635-1-git-send-email-lstipakov@...277...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10903
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


