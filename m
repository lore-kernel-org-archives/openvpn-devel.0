Date: Fri, 24 Mar 2023 13:33:17 +0100 (CET)
Message-Id: <202303241233.32OCXHuj089180@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230324121050.1350913-1-arne@...1227...>
References: <20230324121050.1350913-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Parse compression options and
 bail out when compression is disabled
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

This is best viewed with "--color-moved=zebra", as it really just moves
stuff around (and gets rid of a few #ifdef USE_COMP).  That we now
have #include statements after code is a big ugly, but saves having
another set of #ifdef... 

Client-tested with and without compression built in, and pushed to GHA
for verification that nothing is breaking anymore.

Your patch has been applied to master and release/2.6 branch.

commit a8170dd0e76a7440f3291ad26d78f8ca247a191b (master)
commit 5a189d5e249c89c55ef7cad4d19a9d8e89a20ff1 (release/2.6)
Author: Arne Schwabe
Date:   Fri Mar 24 13:10:50 2023 +0100

     Parse compression options and bail out when compression is disabled

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230324121050.1350913-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26512.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


