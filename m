Date: Tue, 13 Jun 2017 09:11:10 +0200 (CEST)
Message-Id: <201706130711.v5D7BAbE068288@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1494537221-12050-3-git-send-email-steffan@...1856...>
References: <1494537221-12050-3-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Drop packets instead of assert
 out if packet id rolls over (CVE-2017-7479)
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

ACK, same patch as in 2.3 (minus the obvious differences in context,
Changes.rst, cmocka).

Your patch has been applied to the release/2.2 branch.

commit 66576f9903cc166072901673ff1e673fa2e29611
Author: Steffan Karger
Date:   Thu May 11 23:13:41 2017 +0200

     Drop packets instead of assert out if packet id rolls over (CVE-2017-7479)

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1494537221-12050-3-git-send-email-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14645.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


