Date: Fri, 3 Nov 2017 19:22:26 +0100 (CET)
Message-Id: <201711031822.vA3IMQrK001723@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1508520356-18277-1-git-send-email-selva.nair@...277...>
References: <1508520356-18277-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Avoid illegal memory access
 when malformed data is read from the pipe
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
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

ACK, and now with time to merge :-)

Your patch has been applied to the master and release/2.4 branch.

commit 6f20808c8f37301c43d822f6a22d30b3587abc57 (master)
commit 17884fa4ab2b3113559542404704402e5fce7643 (release/2.4)
Author: Selva Nair
Date:   Fri Oct 20 13:25:56 2017 -0400

     Avoid illegal memory access when malformed data is read from the pipe

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1508520356-18277-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15657.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


