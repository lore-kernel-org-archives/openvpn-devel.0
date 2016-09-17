Date: Sat, 17 Sep 2016 14:01:03 +0200 (CEST)
Message-Id: <201609171201.u8HC13GD056462@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1474102835-13402-1-git-send-email-arne@...1227...>
References: <1474102835-13402-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Prefer RECVDSTADDR to PKTINFO
	for IPv4 in OS X since it actually works (unlike PKTINFO)
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.

Your patch has been applied to the master branch.

commit 3ffe2338c092d7bd4abace3ae9fa0b4f85cf4b87
Author: Arne Schwabe
Date:   Sat Sep 17 11:00:35 2016 +0200

     Prefer RECVDSTADDR to PKTINFO for IPv4 in OS X since it actually works (unlike PKTINFO)

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1474102835-13402-1-git-send-email-arne@...1227...>
     URL: http://www.mail-archive.com/search?l=mid&q=1474102835-13402-1-git-send-email-arne@...1227...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


