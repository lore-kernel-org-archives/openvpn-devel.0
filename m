Date: Thu, 5 Dec 2013 19:49:16 +0100
Message-Id: <201312051849.rB5InGOr028923@...1729...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1384882574-28242-1-git-send-email-heiko.hund@...1489...>
References: <1384882574-28242-1-git-send-email-heiko.hund@...1489...>
Subject: [Openvpn-devel] [PATCH applied] Re: Support non-ASCII characters in
	Windows tmp path
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

ACK, the code looks reasonable.

Your patch has been applied to the master and release/2.3 branch,
with the language fixes by Matthias Andree.

commit 925b8a463b78620c1f856a0224396ac7d53e6295 (master)
commit 1146c724e4d966248d23a0b350bc76d1af35a00c (release/2.3)

Author: Heiko Hund
Date:   Tue Nov 19 18:36:14 2013 +0100

     Support non-ASCII characters in Windows tmp path

     Signed-off-by: Heiko Hund <heiko.hund@...1489...>
     Acked-by: <chipitsine@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1384882574-28242-1-git-send-email-heiko.hund@...1489...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8002
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


