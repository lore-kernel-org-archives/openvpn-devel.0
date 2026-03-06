Date: Fri, 6 Mar 2026 17:20:26 +0100 (CET)
Message-Id: <202603061620.626GKQ55008815@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20260305084914.1327-1-gert@...1296...>
References: <20260305084914.1327-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: route: Fix type of rgi_needed
 variables
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

Not sure why the compiler isn't smart enough to get this right by itself,
but the change won't hurt... :-)

Your patch has been applied to the master branch.

commit 8e9ebaa8dca386fb282a4be8ec8199046a7ab3ac
Author: Frank Lichtenheld
Date:   Thu Mar 5 09:49:08 2026 +0100

     route: Fix type of rgi_needed variables

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1505
     Message-Id: <20260305084914.1327-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35926.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


