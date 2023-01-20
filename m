Date: Fri, 20 Jan 2023 18:54:26 +0100 (CET)
Message-Id: <202301201754.30KHsQk3034151@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230120094100.2063883-1-selva.nair@...277...>
References: <20230120094100.2063883-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Cleanup route error and debug
 logging on Windows
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

Lots of good unifications, thanks, and thanks for sending the v2
quickly.

I have not tested beyond "push at github", but Lev has tested, and 
I have stared at the changes and liked what I saw :-) - especially 
the interface ID change fixes "that bug" that I happened to hit when
testing the v6-route-via-IPAPI patch.  Thanks!

(But there is always more work)

Your patch has been applied to the master and release/2.6 branch.

commit a45c201e2edcf5ccb6baea0a03145023db7f222b (master)
commit 638082f3d92dcfd4211a213073de08a0b69fb61d (release/2.6)
Author: Selva Nair
Date:   Fri Jan 20 04:41:00 2023 -0500

     Cleanup route error and debug logging on Windows

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20230120094100.2063883-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26058.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


