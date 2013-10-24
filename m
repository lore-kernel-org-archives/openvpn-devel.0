Date: Thu, 24 Oct 2013 13:42:34 +0200 (CEST)
Message-Id: <201310241142.r9OBgYAg026675@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1382445917-2974-1-git-send-email-steffan.karger@...1435...>
References: <1382445917-2974-1-git-send-email-steffan.karger@...1435...>
Subject: [Openvpn-devel] [PATCH applied] Re: Require polarssl >= 1.2.10 for
	polarssl-builds, which fixes CVE-2013-5915.
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

ACK, and thanks! 

Your patch has been applied to the master and release/2.3 branch.

commit 92d21e3fed33aad966b7b0ca6568e0cda8c7a8b5 (master)
commit 402ace5477ba582fedf93b31d049d83860407351 (release/2.3)

Author: Steffan Karger
Date:   Tue Oct 22 14:45:17 2013 +0200

     Require polarssl >= 1.2.10 for polarssl-builds, which fixes CVE-2013-5915.

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1382445917-2974-1-git-send-email-steffan.karger@...1435...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/7925
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


