Date: Wed, 6 Nov 2019 20:42:15 +0100 (CET)
Message-Id: <201911061942.xA6JgFka099725@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1572439499-16276-1-git-send-email-lstipakov@...277...>
References: <1572439499-16276-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix broken fragmentation logic
 when using NCP
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
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Thanks for clarifying what the actual problem is, so we have it nicely
in the logs.  I have diff'ed this patch vs. d22ba6b2c551f, and the only
difference is related to "use_iv" which got kicked out from master.

So I'm mostly relying on the ACks from Arne and Steffan and not doing
any review myself :-) - I have done a full client test, of course.

Your patch has been applied to the release/2.4 branch.

commit 3bd91cd0e68762b861c57cf37f144d8a11704e9d
Author: Lev Stipakov
Date:   Wed Oct 30 14:44:59 2019 +0200

     Fix broken fragmentation logic when using NCP

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1572439499-16276-1-git-send-email-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18975.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


