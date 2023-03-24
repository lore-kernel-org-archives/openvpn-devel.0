Date: Fri, 24 Mar 2023 13:37:06 +0100 (CET)
Message-Id: <202303241237.32OCb68T089595@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230324121818.2358-1-lstipakov@...277...>
References: <20230324121818.2358-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Don't overwrite socket flags
 when using DCO on Windows
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

"Because it makes sense".  We didn't discover this before as it needs
a server actually pushing sock-options *and* a DCO-on-Windows client
(*and* TCP?).

I haven't actually tested this, but discussed this beforehand with
Lev, and he has (and the change looks good).

Your patch has been applied to the master and release/2.6 branch.

commit 82e7d5cfd81f03f045ace2bf1d3590b79441ea17 (master)
commit cfc5228f9aeaa99c75fb7538435780e4dd7fb7de (release/2.6)
Author: Lev Stipakov
Date:   Fri Mar 24 14:18:18 2023 +0200

     Don't overwrite socket flags when using DCO on Windows

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230324121818.2358-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26513.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


