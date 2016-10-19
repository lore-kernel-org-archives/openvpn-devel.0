Date: Wed, 19 Oct 2016 23:00:39 +0200 (CEST)
Message-Id: <201610192100.u9JL0dd0059664@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1476905060-29896-1-git-send-email-steffan@...1856...>
References: <1476905060-29896-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix use-after-free bug in
	prepare_push_reply()
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

Uh... re-sending.  Too late.

*ACK* - patch totally matches explanation, and both make sense.

Your patch has been applied to the master branch.

commit 83fdae3e9c482a3d3ceca484d96e1241359a0450
Author: Steffan Karger
Date:   Wed Oct 19 21:24:20 2016 +0200

     Fix use-after-free bug in prepare_push_reply()

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1476905060-29896-1-git-send-email-steffan@...1856...>
     URL: http://www.mail-archive.com/search?l=mid&q=1476905060-29896-1-git-send-email-steffan@...1856...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


