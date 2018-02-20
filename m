Date: Tue, 20 Feb 2018 10:12:11 +0100 (CET)
Message-Id: <201802200912.w1K9CBxZ038368@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20180211101929.4535-1-steffan@...1856...>
References: <20180211101929.4535-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH applied] Re: Log pre-handshake packet drops
 using D_MULTI_DROPPED
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

"because the reasoning make sense, and the code change is trivial enough"

Your patch has been applied to the master and release/2.4 branch.

commit c215c58f2393e881e16f9805549316a1e257a682 (master)
commit 38595e9b1f337ee22a94154323eb14408ed86ef8 (release/2.4)
Author: Steffan Karger
Date:   Sun Feb 11 11:19:29 2018 +0100

     Log pre-handshake packet drops using D_MULTI_DROPPED

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20180211101929.4535-1-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16477.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


