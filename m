Date: Mon, 17 Oct 2016 12:32:42 +0200 (CEST)
Message-Id: <201610171032.u9HAWgAI032747@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20161009152550.GQ78279@...1296...>
References: <20161009152550.GQ78279@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Windows: do_ifconfig() after
	open_tun()
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

Your patch has been applied to the master branch.

(ACK for v1 from me, ACK for v2 from Heiko, so stuff indeed got reviewed
- and with all the windows testing reports, it even got *tested* properly)

commit 533495298bd93ddaaf4418dc666922779ce5ef9b
Author: Heiko Hund
Date:   Fri Jun 24 18:01:41 2016 +0200

     Windows: do_ifconfig() after open_tun()

     Signed-off-by: Heiko Hund <heiko.hund@...1489...>
     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Gert Doering <gert@...1296...>
     Acked-by: Heiko Hund <heiko.hund@...1489...>
     Message-Id: <20161009152550.GQ78279@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg12631.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


