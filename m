Date: Mon, 11 Jul 2016 16:41:33 +0200 (CEST)
Message-Id: <201607111441.u6BEfXIi090997@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1467732770-19110-1-git-send-email-selva.nair@...277...>
References: <1467732770-19110-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Exponentially back off on
	repeated connect retries
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

Another ACK from me, looks good (and works :) )...

Mon Jul 11 16:30:28 2016 us=977593 Restart pause, 2 second(s)
Mon Jul 11 16:30:32 2016 us=937071 Restart pause, 2 second(s)
Mon Jul 11 16:30:36 2016 us=957047 Restart pause, 2 second(s)
Mon Jul 11 16:30:40 2016 us=907049 Restart pause, 2 second(s)
Mon Jul 11 16:30:44 2016 us=867052 Restart pause, 4 second(s)
Mon Jul 11 16:30:50 2016 us=677019 Restart pause, 8 second(s)
Mon Jul 11 16:31:00 2016 us=497045 Restart pause, 16 second(s)
Mon Jul 11 16:31:18 2016 us=517110 Restart pause, 32 second(s)
Mon Jul 11 16:31:52 2016 us=367066 Restart pause, 64 second(s)
Mon Jul 11 16:32:58 2016 us=337024 Restart pause, 128 second(s)
Mon Jul 11 16:35:08 2016 us=227030 Restart pause, 140 second(s)
Mon Jul 11 16:37:30 2016 us=137063 Restart pause, 140 second(s)

(--connect-retry 2 140)

Thanks :)

Your patch has been applied to the master branch.

commit 5d429efd9720109b9c9f1265f5d351a75a401942
Author: Selva Nair
Date:   Tue Jul 5 11:32:50 2016 -0400

     Exponentially back off on repeated connect retries

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1467732770-19110-1-git-send-email-selva.nair@...277...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/12050
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


