Date: Tue, 20 Feb 2018 13:58:00 +0100 (CET)
Message-Id: <201802201258.w1KCw0NG067385@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1516815105-17882-1-git-send-email-selva.nair@...277...>
References: <1516815105-17882-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use lowest metric interface
 when multiple interfaces match a route
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

Based on JJK's test results, staring at the code, understanding the
intent :-) and test compilation on 16.04.

Your patch has been applied to the master and release/2.4 branch.

TODO: figuring out what's wrong with the IPv6 route "host bits", but
that's totally outside these code paths, it just came up in this thread.

commit 3854d4040e0d6fd2a58292e8bb1c1fbae5c17bb1 (master)
commit 965c7906f61e6de30adc1cc2d24ec73e345e0007 (release/2.4)
Author: Selva Nair
Date:   Wed Jan 24 12:31:45 2018 -0500

     Use lowest metric interface when multiple interfaces match a route

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1516815105-17882-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16347.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


