Date: Tue, 10 Nov 2015 21:23:56 +0100 (CET)
Message-Id: <201511102023.tAAKNu5U007707@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1446757381-27863-1-git-send-email-steffan@...1856...>
References: <1446757381-27863-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Add macro to ensure we exit on
	fatal errors
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

ACK.  It does increase the code slightly (because while the compiler can
optimize away the if() clause in most cases, for each FATAL msg(), the
new exit() leaves a few bytes...) - but the increase is truly marginal
(602843 to 603143 bytes "text segment" on my i386 linux) and it helps
with coverity et al in weeding out false warnings...  certainly useful.

Patch has been applied to the master and release/2.3 branch.

commit 9aebc37c45e440bda5f71b717146b5dc330d5277 (master)
commit 3254099bc4c88315352457b4efb067587df29a77 (release/2.3)

Author: Steffan Karger
Date:   Thu Nov 5 22:03:01 2015 +0100

     Add macro to ensure we exit on fatal errors

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1446757381-27863-1-git-send-email-steffan@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10440
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


