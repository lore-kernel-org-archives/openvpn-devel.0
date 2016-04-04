Date: Mon, 4 Apr 2016 20:27:39 +0200 (CEST)
Message-Id: <201604041827.u34IRdUo041876@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1459092130-19905-1-git-send-email-steffan@...1856...>
References: <1459092130-19905-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix memory leak in
	argv_extract_cmd_name()
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

ACK.  (The code in question is today only ever called from a context where 
it is not leaking, but then, we might change this one day...)

Your patch has been applied to the master and release/2.3 branch.

commit be16d5f6b050248f503455e4a0e8f3aaaa38bdc7 (master)
commit f8da74920998a8fa1125ec73c5e3397707b43017 (release/2.3)

Author: Steffan Karger
Date:   Sun Mar 27 17:22:10 2016 +0200

     Fix memory leak in argv_extract_cmd_name()

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1459092130-19905-1-git-send-email-steffan@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/11369
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


