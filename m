Date: Mon, 28 Nov 2016 16:45:48 +0100 (CET)
Message-Id: <201611281545.uASFjmwq071091@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1480344801-27855-1-git-send-email-steffan.karger@...1435...>
References: <1480344801-27855-1-git-send-email-steffan.karger@...1435...>
Subject: [Openvpn-devel] [PATCH applied] Re: tls_process: don't set variable
	that's never read
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
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  Easy enough.

Your patch has been applied to the master branch.

commit 06c54466c86ee3beff9b6cd75f40de5e431d8235
Author: Steffan Karger
Date:   Mon Nov 28 15:53:20 2016 +0100

     tls_process: don't set variable that's never read

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1480344801-27855-1-git-send-email-steffan.karger@...1435...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13260.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


