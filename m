Date: Tue, 7 Feb 2023 17:49:36 +0100 (CET)
Message-Id: <202302071649.317Gnack058774@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230203191440.136050-3-frank@...2641...>
References: <20230203191440.136050-3-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Windows: fix unused variables
 in delete_route_ipv6
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

Test compiled on mingw & linux, and pushed to the buildbots.  This is
the sort of cross-platform patch that looks harmless and breaks somewhere :-)
(but it didn't).

We normally try to avoid refactoring in the middle of a release branch, but
"we're between .0 and .1, and it's very trivial code movearound only".

Your patch has been applied to the master branch and release/2.6.

commit 48495ce3cd8d53663c56d265ef6a82234878e205 (master)
commit ab46bdd1ef9951b684782de00f37fec4092fd0f1 (release/2.6)
Author: Frank Lichtenheld
Date:   Fri Feb 3 20:14:37 2023 +0100

     Windows: fix unused variables in delete_route_ipv6

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20230203191440.136050-3-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26140.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


