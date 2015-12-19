Date: Sat, 19 Dec 2015 14:28:16 +0100 (CET)
Message-Id: <201512191328.tBJDSGgv092195@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1450525169-12961-2-git-send-email-steffan@...1856...>
References: <1450525169-12961-2-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Warn user if their certificate
	has expired
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

ACK (as this is basically just the combined and already-ACKed patches 
from master, 644f2cdd13f4 + 091edd8e29968, which we did not cherrypick
because the PolarSSL 1.3 upgrade needed to be done first).

Your patch has been applied to the release/2.3 branch.

commit dfd940bb008feb2fe981ceab3ed66fdb3cf21bdb
Author: Steffan Karger
Date:   Sat Dec 19 12:39:29 2015 +0100

     Warn user if their certificate has expired

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1450525169-12961-2-git-send-email-steffan@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10855
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


