Date: Mon, 21 Apr 2014 13:16:22 +0200 (CEST)
Message-Id: <201404211116.s3LBGMW4018081@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1398064204-26476-3-git-send-email-james@...515...>
References: <1398064204-26476-3-git-send-email-james@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use native strtoull() with MSVC
	2013.
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
To: James Yonan <james@...515...>
Cc: openvpn-devel@lists.sourceforge.net

ACK (you're the one who builds most with MSVC anyway, so you know).

Your patch has been applied to the master and release/23 branches.

commit 6b8e2f4a8143a7260a06b6999dcb21c4c72fc620 (master)
commit 040b306f58fa0cc175c66ed67f390c0a289ddd4e (release/2.3)

Author: James Yonan
Date:   Mon Apr 21 01:10:03 2014 -0600

     Use native strtoull() with MSVC 2013.

     Signed-off-by: James Yonan <james@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1398064204-26476-3-git-send-email-james@...515...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8561
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


