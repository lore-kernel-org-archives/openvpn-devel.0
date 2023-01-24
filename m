Date: Tue, 24 Jan 2023 08:36:28 +0100 (CET)
Message-Id: <202301240736.30O7aSsR016222@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230121194226.2081637-1-selva.nair@...277...>
References: <20230121194226.2081637-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix one more 'existing route
 may get deleted' case
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

This is identical to the "I already tested these" bits of v1, so
didn't do more than "compare diffs" and "basic linux compile test" 
(with --enable-iproute2) plus "run binary once to see if errors
are detected" (they are) today.

Your patch has been applied to the master and release/2.6 branch.

commit 00fac39c58a7d5c8fa6d8f40232e9ab79f3fa9e0 (master)
commit f30b1c90c06af73aef4ce93a62119393727032d6 (release/2.6)
Author: Selva Nair
Date:   Sat Jan 21 14:42:26 2023 -0500

     Fix one more 'existing route may get deleted' case

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230121194226.2081637-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26067.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


