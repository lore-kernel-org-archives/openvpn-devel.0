Date: Wed, 21 Jun 2017 12:02:39 +0200 (CEST)
Message-Id: <201706211002.v5LA2dJI073810@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1497864520-12219-2-git-send-email-steffan.karger@...1435...>
References: <1497864520-12219-2-git-send-email-steffan.karger@...1435...>
Subject: [Openvpn-devel] [PATCH applied] Re: mbedtls: fix --x509-track
 post-authentication remote DoS (CVE-2017-7522)
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
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.4 branch.

commit 426392940c7060300a10077c389f5156c790c2f6 (master)
commit 67edada0beaf5ce6e47f13526b9f678dad4fc126 (release/2.4)
Author: Steffan Karger
Date:   Mon Jun 19 11:28:36 2017 +0200

     mbedtls: fix --x509-track post-authentication remote DoS (CVE-2017-7522)

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1497864520-12219-2-git-send-email-steffan.karger@...1435...>
     URL: https://www.mail-archive.com/search?l=mid&q=1497864520-12219-2-git-send-email-steffan.karger@...1435...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


