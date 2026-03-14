Date: Sat, 14 Mar 2026 11:49:39 +0100 (CET)
Message-Id: <202603141049.62EAndlj085173@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260313223833.3813-1-gert@...1296...>
References: <20260313223833.3813-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: systemd: Change LimitNPROC to
 TasksMax and increase limit
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

While I could care less about systemd, arguably this was a non-helpful
setting (wrong variable and over-strict limit) - so this is a reasonable
change.  Arne ACKed v1 (name change), v2 also bumps the limit.

Your patch has been applied to the master and release/2.7 branch.

commit c02964f0b20d860176545dbeaf54b11127e9f8a3 (master)
commit 8a156abb4b40dee63174fd45fe66e4591409b497 (release/2.7)
Author: Frank Lichtenheld
Date:   Fri Mar 13 23:38:28 2026 +0100

     systemd: Change LimitNPROC to TasksMax and increase limit

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1539
     Message-Id: <20260313223833.3813-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36123.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


