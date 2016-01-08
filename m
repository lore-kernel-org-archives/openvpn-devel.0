Date: Fri, 8 Jan 2016 09:17:34 +0100 (CET)
Message-Id: <201601080817.u088HYEH051939@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1452198132-25560-1-git-send-email-steffan@...1856...>
References: <1452198132-25560-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: polarssl: use wrappers to
	access md_info_t member functions
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

ACK.  Tested with "--show-digest" (and t_client test suite).

Your patch has been applied to the master branch.

commit 072fdcd00688d2d16d17745fb7d7b385795d5de1
Author: Steffan Karger
Date:   Thu Jan 7 21:22:12 2016 +0100

     polarssl: use wrappers to access md_info_t member functions

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1452198132-25560-1-git-send-email-steffan@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10955
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


